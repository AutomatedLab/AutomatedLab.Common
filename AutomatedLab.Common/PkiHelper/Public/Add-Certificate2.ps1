function Add-Certificate2
{
    [cmdletBinding(DefaultParameterSetName = 'ByteArray')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'File')]
        [string]$Path,
        
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ByteArray')]
        [byte[]]$RawContentBytes,
        
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Security.Cryptography.X509Certificates.StoreName]$Store,
        
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Security.Cryptography.X509Certificates.CertStoreLocation]$Location,
        
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string]$ServiceName,
        
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('CER', 'PFX')]
        [string]$CertificateType = 'CER',
        
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string]$Password
    )
    
    process
    {
        if ($Location -eq 'CERT_SYSTEM_STORE_SERVICES' -and (-not $ServiceName))
        {
            Write-Error "Please specify a ServiceName if the Location is set to 'CERT_SYSTEM_STORE_SERVICES'"
            return
        }
    
        $storePath = $Store
        
        if ($Path -and -not (Test-Path -Path $Path))
        {
            Write-Error "The path '$Path' does not exist."
            continue
        }
        
        if ($ServiceName)
        {
            if (-not (Get-Service -Name $ServiceName))
            {
                Write-Error "The service '$ServiceName' could not be found."
                return
            }
            else
            {
                $storePath = "$ServiceName\$Store"
            }
        }
    
        $storeProvider = [System.Security.Cryptography.X509Certificates.CertStoreProvider]::CERT_STORE_PROV_SYSTEM_REGISTRY

        $Location = $Location -bor [System.Security.Cryptography.X509Certificates.CertStoreFlags]::CERT_STORE_MAXIMUM_ALLOWED_FLAG
    
        $storePtr = [System.Security.Cryptography.X509Certificates.Win32]::CertOpenStore($storeProvider, 0, 0, $Location, $storePath)
        if ($storePtr -eq [System.IntPtr]::Zero)
        {
            Write-Error "Store '$Store' in location '$Location' could not be opened."
            return
        }
        $s = New-Object System.Security.Cryptography.X509Certificates.X509Store($storePtr)
        
        if ($Path)
        {
            $RawContentBytes = [System.IO.File]::ReadAllBytes($Path)
        }
        
        try
        {
            if ($Password)
            {
                $securePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
            }
            $certInfo = if ([System.Security.Cryptography.X509Certificates.X509Certificate2]::GetCertContentType($RawContentBytes) -eq 'Pfx')
            {
                New-Object Pki.Certificates.CertificateInfo($RawContentBytes, $securePassword)
            }
            else
            {
                New-Object Pki.Certificates.CertificateInfo(,$RawContentBytes)
            }
        }
        catch
        {
            Write-Error -ErrorRecord $_
            return
        }

        Write-Verbose "Store '$Store' in location '$Location' knowns about $($s.Certificates.Count) certificates before import."
        
        $s.Add($certInfo.Certificate)
        
        Write-Verbose "Store '$Store' in location '$Location' knowns about $($s.Certificates.Count) certificates after import."

        [void][System.Security.Cryptography.X509Certificates.Win32]::CertCloseStore($storePtr, 0)
    }
}
