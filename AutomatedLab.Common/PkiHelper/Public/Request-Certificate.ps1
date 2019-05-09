function Request-Certificate
{
    [cmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = 'Please enter the subject beginning with CN=')]
        [ValidatePattern('CN=')]
        [string]$Subject,

        [Parameter(HelpMessage = 'Please enter the SAN domains as a comma separated list')]
        [string[]]$SAN,

        [Parameter(HelpMessage = 'Please enter the Online Certificate Authority')]
        [string]$OnlineCA,

        [Parameter(Mandatory = $true, HelpMessage = 'Please enter the Online Certificate Authority')]
        [string]$TemplateName
    )

    $infFile = [System.IO.Path]::GetTempFileName()
    $requestFile = [System.IO.Path]::GetTempFileName()
    $certFile = [System.IO.Path]::GetTempFileName()
    $rspFile = [System.IO.Path]::GetTempFileName()

    ### INI file generation
    $iniContent = @'
[Version]
Signature="$Windows NT$"

[NewRequest]
Subject="{0}"
Exportable=TRUE
KeyLength=2048
KeySpec=1
KeyUsage=0xA0
MachineKeySet=True
ProviderName="Microsoft RSA SChannel Cryptographic Provider"
ProviderType=12
SMIME=FALSE
RequestType=PKCS10
[Strings]
szOID_ENHANCED_KEY_USAGE = "2.5.29.37"
szOID_PKIX_KP_SERVER_AUTH = "1.3.6.1.5.5.7.3.1"
szOID_PKIX_KP_CLIENT_AUTH = "1.3.6.1.5.5.7.3.2"
'@

    $iniContent = $iniContent -f $Subject

    Add-Content -Path $infFile -Value $iniContent
    Write-Verbose "ini file created '$infFile'"
 
    if ($SAN)
    {
        Write-Verbose 'Assing SAN section'
        Add-Content -Path $infFile -Value 'szOID_SUBJECT_ALT_NAME2 = "2.5.29.17"'
        Add-Content -Path $infFile -Value '[Extensions]'
        Add-Content -Path $infFile -Value '2.5.29.17 = "{text}"'
 
        foreach ($s in $SAN)
        {
            Write-Verbose "`t $s"
            $temp = '_continue_ = "dns={0}&"' -f $s
            Add-Content -Path $infFile -Value $temp
        }
    }
 
    ### Certificate request generation
    Remove-Item -Path $requestFile
    Write-Verbose "Calling 'certreq.exe -new $infFile $requestFile | Out-Null'"
    certreq.exe -new $infFile $requestFile | Out-Null
 
    ### Online certificate request and import
    if (-not $OnlineCA)
    {
        Write-Verbose 'No CA given, trying to find one...'
        $OnlineCA = Find-CertificateAuthority -ErrorAction Stop
        Write-Verbose "Found CA '$OnlineCA'"
    }
    
    if (-not $OnlineCA)
    {
        Write-Error "No OnlineCA given and no one could be found in the machine's domain"
        return
    }
       
    Remove-Item -Path $certFile
    Write-Verbose "Calling 'certreq.exe -q -submit -attrib CertificateTemplate:$TemplateName -config $OnlineCA $requestFile $certFile | Out-Null'"
    certreq.exe -submit -q -attrib "CertificateTemplate:$TemplateName" -config $OnlineCA $requestFile $certFile | Out-Null

    if ($LASTEXITCODE)
    {
        $ex = New-Object System.ComponentModel.Win32Exception($LASTEXITCODE)
        Write-Error -Message "Submitting the certificate request failed: $($ex.Message)" -Exception $ex 
        return
    }
 
    Write-Verbose "Calling 'certreq.exe -accept $certFile'"
    certreq.exe -q -accept $certFile
    if ($LASTEXITCODE)
    {
        $ex = New-Object System.ComponentModel.Win32Exception($LASTEXITCODE)
        Write-Error -Message "Accepting the certificate failed: $($ex.Message)" -Exception $ex
        return
    }

    Copy-Item -Path $certFile -Destination c:\cert.cer -Force
    Copy-Item -Path $infFile -Destination c:\request.inf -Force

    $certPrint = [System.Security.Cryptography.X509Certificates.X509Certificate2][System.Security.Cryptography.X509Certificates.X509Certificate2]::CreateFromCertFile('C:\cert.cer')
    $certPrint

    Remove-Item -Path $infFile, $requestFile, $certFile, $rspFile, 'C:\cert.cer' -Force
}
