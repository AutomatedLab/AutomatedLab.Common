function Get-Certificate2
{
    [cmdletBinding(DefaultParameterSetName = 'FindCer')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'FindCer')]
        [Parameter(Mandatory = $true, ParameterSetName = 'FindPfx')]
        [string]$SearchString,

        [Parameter(Mandatory = $true, ParameterSetName = 'FindCer')]
        [Parameter(Mandatory = $true, ParameterSetName = 'FindPfx')]        
        [System.Security.Cryptography.X509Certificates.X509FindType]$FindType,
        
        [Parameter(ParameterSetName = 'AllCer')]
        [Parameter(ParameterSetName = 'AllPfx')]
        [Parameter(ParameterSetName = 'FindCer')]
        [Parameter(ParameterSetName = 'FindPfx')]
        [System.Security.Cryptography.X509Certificates.CertStoreLocation]$Location,
        
        [Parameter(ParameterSetName = 'AllCer')]
        [Parameter(ParameterSetName = 'AllPfx')]
        [Parameter(ParameterSetName = 'FindCer')]
        [Parameter(ParameterSetName = 'FindPfx')]
        [System.Security.Cryptography.X509Certificates.StoreName]$Store,
        
        [Parameter(ParameterSetName = 'AllCer')]
        [Parameter(ParameterSetName = 'AllPfx')]
        [Parameter(ParameterSetName = 'FindCer')]
        [Parameter(ParameterSetName = 'FindPfx')]
        [string]$ServiceName,

        [Parameter(Mandatory = $true, ParameterSetName = 'AllCer')]
        [Parameter(Mandatory = $true, ParameterSetName = 'AllPfx')]
        [switch]$All,

        [Parameter(ParameterSetName = 'AllCer')]
        [Parameter(ParameterSetName = 'AllPfx')]
        [switch]$IncludeServices,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'FindPfx')]
        [Parameter(Mandatory = $true, ParameterSetName = 'AllPfx')]
        [securestring]$Password,
        
        [Parameter(ParameterSetName = 'FindPfx')]
        [Parameter(ParameterSetName = 'AllPfx')]
        [switch]$ExportPrivateKey
    )
    
    if ($Location -eq 'CERT_SYSTEM_STORE_SERVICES' -and (-not $ServiceName))
    {
        Write-Error "Please specify a ServiceName if the Location is set to 'CERT_SYSTEM_STORE_SERVICES'"
        return
    }
    else
    {
        $IncludeServices = $true
    }
    
    $storeProvider = [System.Security.Cryptography.X509Certificates.CertStoreProvider]::CERT_STORE_PROV_SYSTEM_REGISTRY
    
    $certs = foreach ($currentLocation in [Enum]::GetNames([System.Security.Cryptography.X509Certificates.CertStoreLocation]))
    {
        if ($Location -and $Location -ne $currentLocation)
        {
            continue
        }
        Write-Verbose "Enumerating stores location '$currentLocation'"

        $internalLocation = [System.Security.Cryptography.X509Certificates.CertStoreLocation]$currentLocation -bor [System.Security.Cryptography.X509Certificates.CertStoreFlags]::CERT_STORE_READONLY_FLAG
    
        foreach ($currentStore in [System.Enum]::GetNames([System.Security.Cryptography.X509Certificates.StoreName]))
        {
            if ($Store -and $Store -ne $currentStore)
            {
                continue
            }
            
            if ($currentLocation -eq [System.Security.Cryptography.X509Certificates.CertStoreLocation]::CERT_SYSTEM_STORE_SERVICES -and $IncludeServices)
            {
                $services = Get-Service
                $storePaths = @()
                
                foreach ($service in $services)
                {
                    $storePaths += "$($service.Name)\$currentStore"
                }
            }
            else
            {
                $storePaths = $currentStore
            }
            
            Write-Verbose "Enumerating certificates in store '$storePath' in location '$currentLocation'"
        
            foreach ($storePath in $storePaths)
            {
                $storePtr = [System.Security.Cryptography.X509Certificates.Win32]::CertOpenStore($storeProvider, 0, 0, $internalLocation, $storePath)
                if ($storePtr -eq [System.IntPtr]::Zero)
                {
                    Write-Verbose "Store '$storePath' in location '$currentLocation' could not be opened."
                    continue
                }
            
                $s = New-Object System.Security.Cryptography.X509Certificates.X509Store($storePtr)
                $result = if ($All)
                {
                    $s.Certificates
                }
                else
                {
                    $s.Certificates.Find($FindType, $SearchString, $false)
                }
                
                foreach ($item in $result)
                {
                    $item | Add-Member -MemberType NoteProperty -Name Location -Value $currentLocation
                    $item | Add-Member -MemberType NoteProperty -Name Store -Value $storePath
                    $item | Add-Member -MemberType NoteProperty -Name Password -Value $plainPassword
                    
                    if ($Location -eq 'CERT_SYSTEM_STORE_SERVICES')
                    {
                        $item | Add-Member -MemberType NoteProperty -Name ServiceName -Value ($storePath -split '\\')[0]
                        $item | Add-Member -MemberType NoteProperty -Name Store -Value ($storePath -split '\\')[1] -Force
                    }
                    
                    $item
                }

                [void][System.Security.Cryptography.X509Certificates.Win32]::CertCloseStore($storePtr, 0)
            }
        }
    }

    Write-Verbose "Found $($certs.Count) certificates"
    
    if ($SearchString -and $certs.Count -eq 0)
    {
        Write-Error "No certificate found applying search string '$SearchString' and looking for '$FindType'"
        return
    }
    
    foreach ($cert in $certs)
    {
        $tempFile = [System.IO.Path]::GetTempFileName()
        Remove-Item -Path $tempFile

        Write-Verbose "Current certificate is $($cert.Thumbprint)"

        try
        {
            if ($cert.HasPrivateKey -and $ExportPrivateKey)
            {
                Write-Verbose 'Calling Export-PfxCertificate'
                Export-PfxCertificate -Cert $cert -FilePath $tempFile -Password $Password -ErrorAction Stop | Out-Null
            }
            else
            {
                Write-Verbose 'Calling Export-Certificate'
                Export-Certificate -Cert $cert -FilePath $tempFile -ErrorAction Stop | Out-Null
            }
            Write-Verbose 'Export finished'
        }
        catch
        {
            if ($SearchString) #A specific cert is desired so an error is written as not in list mode
            {
                Write-Error $_
            }
            continue
        }

        $certInfo = if ($ExportPrivateKey)
        {
            New-Object Pki.Certificates.CertificateInfo($tempFile, $Password)
        }
        else
        {
            New-Object Pki.Certificates.CertificateInfo($tempFile)
        }
        Remove-Item -Path $tempFile
        
        $certInfo.ComputerName = $env:COMPUTERNAME
        $certInfo.Location = $cert.Location
        $certInfo.Store = $cert.Store
        $certInfo.ServiceName = $cert.ServiceName
        
        $certInfo
    }
}
