function Add-Certificate2
{
    [cmdletBinding(DefaultParameterSetName = 'File')]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'File')]
        [string]$Path,
        
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'ByteArray')]
        [byte[]]$Cert,
        
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Security.Cryptography.X509Certificates.StoreName]$Store,
        
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Security.Cryptography.X509Certificates.CertStoreLocation]$Location,
        
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string]$ServiceName,
        
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('CER', 'PFX')]
        [string]$CertificateType = 'CER',
        
        [Parameter(Mandatory = $true)]
        [securestring]
        $Password
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
        $newCert = if ($Path)
        {
            if ($CertificateType -eq 'CER')
            {
                New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($Path) -ErrorAction Stop
            }
            else
            {
                New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($Path, $password, ('Exportable', 'PersistKeySet')) -ErrorAction Stop
            }
        }
        else
        {
            if ($CertificateType -eq 'CER')
            {
                New-Object System.Security.Cryptography.X509Certificates.X509Certificate2(, $Cert) -ErrorAction Stop
            }
            else
            {
                New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($Cert, $password, ('Exportable', 'PersistKeySet')) -ErrorAction Stop
            }
        }
        
        if (-not $newCert)
        {
            return
        }
    
        Write-Verbose "Store '$Store' in location '$Location' knowns about $($s.Certificates.Count) certificates before import."
        
        $s.Add($newCert)
        
        Write-Verbose "Store '$Store' in location '$Location' knowns about $($s.Certificates.Count) certificates after import."

        [void][System.Security.Cryptography.X509Certificates.Win32]::CertCloseStore($storePtr, 0)
    }
}
