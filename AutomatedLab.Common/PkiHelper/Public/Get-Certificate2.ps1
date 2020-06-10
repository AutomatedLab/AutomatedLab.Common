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
        [string]$Store,
        
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
    
    $services = Get-Service
    
    if ($ServiceName -and $Location -ne 'CERT_SYSTEM_STORE_SERVICES')
    {
        $Location = 'CERT_SYSTEM_STORE_SERVICES'
    }
    
    if ($ServiceName -and $ServiceName -notin $services.Name)
    {
        Write-Error "The service '$ServiceName' could not be found."
        return
    }
    
    $storeProvider = [System.Security.Cryptography.X509Certificates.CertStoreProvider]::CERT_STORE_PROV_SYSTEM
    
    $certs = foreach ($currentLocation in [Enum]::GetNames([System.Security.Cryptography.X509Certificates.CertStoreLocation]))
    {
        if ($Location -and $Location -ne $currentLocation)
        {
            Write-Verbose "Skipping location '$currentLocation'"
            continue
        }
        Write-Verbose "Enumerating stores location '$currentLocation'"

        $internalLocation = [System.Security.Cryptography.X509Certificates.CertStoreLocation]$currentLocation -bor [System.Security.Cryptography.X509Certificates.CertOpenStoreFlags]::CERT_STORE_READONLY_FLAG
    
        $availableStores = if ($ServiceName)
        {
            [System.Security.Cryptography.X509Certificates.Win32]::GetServiceCertificateStores($ServiceName)
        }
        elseif ($Location -eq [System.Security.Cryptography.X509Certificates.CertStoreLocation]::CERT_SYSTEM_STORE_SERVICES)
        {
            $services = Get-Service
            foreach ($Service in $services)
            {
                [System.Security.Cryptography.X509Certificates.Win32]::GetServiceCertificateStores($service.Name)
            }
        }
        else
        {
            [System.Security.Cryptography.X509Certificates.Win32]::GetCertificateStores()
        }
        
        $availableStores = if ($Location -eq [System.Security.Cryptography.X509Certificates.CertStoreLocation]::CERT_SYSTEM_STORE_CURRENT_USER)
        {
            $availableStores | Where-Object Location -eq CurrentUser
        }
        elseif ($Location -eq [System.Security.Cryptography.X509Certificates.CertStoreLocation]::CERT_SYSTEM_STORE_LOCAL_MACHINE)
        {
            $availableStores | Where-Object Location -eq LocalMachine
        }
        elseif ($Location -eq [System.Security.Cryptography.X509Certificates.CertStoreLocation]::CERT_SYSTEM_STORE_LOCAL_MACHINE)
        {
            $availableStores | Where-Object Location -eq LocalMachine
        }
        elseif ($Location -eq [System.Security.Cryptography.X509Certificates.CertStoreLocation]::CERT_SYSTEM_STORE_SERVICES)
        {
            $availableStores | Where-Object Location -eq Services
        }
        elseif ($Location -eq [System.Security.Cryptography.X509Certificates.CertStoreLocation]::CERT_SYSTEM_STORE_USERS)
        {
            $availableStores | Where-Object Location -eq Users
        }
        elseif ($Location -eq [System.Security.Cryptography.X509Certificates.CertStoreLocation]::CERT_SYSTEM_STORE_CURRENT_USER_GROUP_POLICY)
        {
            $availableStores | Where-Object Location -eq CurrentUserGroupPolicy
        }
        elseif ($Location -eq [System.Security.Cryptography.X509Certificates.CertStoreLocation]::CERT_SYSTEM_STORE_LOCAL_MACHINE_GROUP_POLICY)
        {
            $availableStores | Where-Object Location -eq LocalMachineGroupPolicy
        }
        elseif ($Location -eq [System.Security.Cryptography.X509Certificates.CertStoreLocation]::CERT_SYSTEM_STORE_LOCAL_MACHINE_ENTERPRISE)
        {
            $availableStores | Where-Object Location -eq LocalMachineEnterprise
        }
        else
        {
            $availableStores
        }
        
        if ($Store)
        {
            if ($ServiceName)
            {
                if ("$ServiceName\$Store" -notin $availableStores.Name)
                {
                    Write-Error "The store '$Store' does not exist for location '$currentLocation' for service '$ServiceName'"
                    continue
                }
                else
                {
                    $availableStores = $availableStores | Where-Object Name -eq "$ServiceName\$Store"
                }
                
            }
            else
            {
                if ($Store -notin $availableStores.Name)
                {
                    Write-Error "The store '$Store' does not exist for location '$currentLocation'"
                    continue
                }
                else
                {
                    $availableStores = $availableStores | Where-Object Name -eq $Store
                }
            }
        }
            
        foreach ($storePath in $availableStores)
        {
            Write-Verbose "Enumerating certificates in store '$storePath' in location '$currentLocation'"
                
            $storePtr = [System.Security.Cryptography.X509Certificates.Win32]::CertOpenStore($storeProvider, 0, 0, $internalLocation, $storePath.Name)
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
        $certInfo.Store = $cert.Store.Name
        $certInfo.ServiceName = $cert.ServiceName
        
        $certInfo
    }
}
