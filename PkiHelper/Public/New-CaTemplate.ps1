$ApplicationPolicies = @{
    # Remote Desktop
    'Remote Desktop' = '1.3.6.1.4.1.311.54.1.2'
    # Windows Update
    'Windows Update' = '1.3.6.1.4.1.311.76.6.1'
    # Windows Third Party Applicaiton Component
    'Windows Third Party Application Component' = '1.3.6.1.4.1.311.10.3.25'
    # Windows TCB Component
    'Windows TCB Component' = '1.3.6.1.4.1.311.10.3.23'
    # Windows Store
    'Windows Store' = '1.3.6.1.4.1.311.76.3.1'
    # Windows Software Extension verification
    ' Windows Software Extension Verification' = '1.3.6.1.4.1.311.10.3.26'
    # Windows RT Verification
    'Windows RT Verification' = '1.3.6.1.4.1.311.10.3.21'
    # Windows Kits Component
    'Windows Kits Component' = '1.3.6.1.4.1.311.10.3.20'
    # ROOT_PROGRAM_NO_OCSP_FAILOVER_TO_CRL
    'No OCSP Failover to CRL' = '1.3.6.1.4.1.311.60.3.3'
    # ROOT_PROGRAM_AUTO_UPDATE_END_REVOCATION
    'Auto Update End Revocation' = '1.3.6.1.4.1.311.60.3.2'
    # ROOT_PROGRAM_AUTO_UPDATE_CA_REVOCATION
    'Auto Update CA Revocation' = '1.3.6.1.4.1.311.60.3.1'
    # Revoked List Signer
    'Revoked List Signer' = '1.3.6.1.4.1.311.10.3.19'
    # Protected Process Verification
    'Protected Process Verification' = '1.3.6.1.4.1.311.10.3.24'
    # Protected Process Light Verification
    'Protected Process Light Verification' = '1.3.6.1.4.1.311.10.3.22'
    # Platform Certificate
    'Platform Certificate' = '2.23.133.8.2'
    # Microsoft Publisher
    'Microsoft Publisher' = '1.3.6.1.4.1.311.76.8.1'
    # Kernel Mode Code Signing
    'Kernel Mode Code Signing' = '1.3.6.1.4.1.311.6.1.1'
    # HAL Extension
    'HAL Extension' = '1.3.6.1.4.1.311.61.5.1'
    # Endorsement Key Certificate
    'Endorsement Key Certificate' = '2.23.133.8.1'
    # Early Launch Antimalware Driver
    'Early Launch Antimalware Driver' = '1.3.6.1.4.1.311.61.4.1'
    # Dynamic Code Generator
    'Dynamic Code Generator' = '1.3.6.1.4.1.311.76.5.1'
    # Domain Name System (DNS) Server Trust
    'DNS Server Trust' = '1.3.6.1.4.1.311.64.1.1'
    # Document Encryption
    'Document Encryption' = '1.3.6.1.4.1.311.80.1'
    # Disallowed List
    'Disallowed List' = '1.3.6.1.4.1.10.3.30'
    # Attestation Identity Key Certificate
    # System Health Authentication
    'System Health Authentication' = '1.3.6.1.4.1.311.47.1.1'
    # Smartcard Logon
    'IdMsKpScLogon' = '1.3.6.1.4.1.311.20.2.2'
    # Certificate Request Agent
    'ENROLLMENT_AGENT' = '1.3.6.1.4.1.311.20.2.1'
    # CTL Usage
    'AUTO_ENROLL_CTL_USAGE' = '1.3.6.1.4.1.311.20.1'
    # Private Key Archival
    'KP_CA_EXCHANGE' = '1.3.6.1.4.1.311.21.5'
    # Key Recovery Agent
    'KP_KEY_RECOVERY_AGENT' = '1.3.6.1.4.1.311.21.6'
    # Secure Email
    'PKIX_KP_EMAIL_PROTECTION' = '1.3.6.1.5.5.7.3.4'
    # IP Security End System
    'PKIX_KP_IPSEC_END_SYSTEM' = '1.3.6.1.5.5.7.3.5'
    # IP Security Tunnel Termination
    'PKIX_KP_IPSEC_TUNNEL' = '1.3.6.1.5.5.7.3.6'
    # IP Security User
    'PKIX_KP_IPSEC_USER' = '1.3.6.1.5.5.7.3.7'
    # Time Stamping
    'PKIX_KP_TIMESTAMP_SIGNING' = '1.3.6.1.5.5.7.3.8'
    # OCSP Signing
    'KP_OCSP_SIGNING' = '1.3.6.1.5.5.7.3.9'
    # IP security IKE intermediate
    'IPSEC_KP_IKE_INTERMEDIATE' = '1.3.6.1.5.5.8.2.2'
    # Microsoft Trust List Signing
    'KP_CTL_USAGE_SIGNING' = '1.3.6.1.4.1.311.10.3.1'
    # Microsoft Time Stamping
    'KP_TIME_STAMP_SIGNING' = '1.3.6.1.4.1.311.10.3.2'
    # Windows Hardware Driver Verification
    'WHQL_CRYPTO' = '1.3.6.1.4.1.311.10.3.5'
    # Windows System Component Verification
    'NT5_CRYPTO' = '1.3.6.1.4.1.311.10.3.6'
    # OEM Windows System Component Verification
    'OEM_WHQL_CRYPTO' = '1.3.6.1.4.1.311.10.3.7'
    # Embedded Windows System Component Verification
    'EMBEDDED_NT_CRYPTO' = '1.3.6.1.4.1.311.10.3.8'
    # Root List Signer
    'ROOT_LIST_SIGNER' = '1.3.6.1.4.1.311.10.3.9'
    # Qualified Subordination
    'KP_QUALIFIED_SUBORDINATION' = '1.3.6.1.4.1.311.10.3.10'
    # Key Recovery
    'KP_KEY_RECOVERY' = '1.3.6.1.4.1.311.10.3.11'
    # Document Signing
    'KP_DOCUMENT_SIGNING' = '1.3.6.1.4.1.311.10.3.12'
    # Lifetime Signing
    'KP_LIFETIME_SIGNING' = '1.3.6.1.4.1.311.10.3.13'
    'DRM' = '1.3.6.1.4.1.311.10.5.1'
    'DRM_INDIVIDUALIZATION' = '1.3.6.1.4.1.311.10.5.2'
    # Key Pack Licenses
    'LICENSES' = '1.3.6.1.4.1.311.10.6.1'
    # License Server Verification
    'LICENSE_SERVER' = '1.3.6.1.4.1.311.10.6.2'
    'Server Authentication' = '1.3.6.1.5.5.7.3.1' #The certificate can be used for OCSP authentication.            
    KP_IPSEC_USER = '1.3.6.1.5.5.7.3.7' #The certificate can be used for an IPSEC user.            
    'Code Signing' = '1.3.6.1.5.5.7.3.3' #The certificate can be used for signing code.
    'Client Authentication' = '1.3.6.1.5.5.7.3.2' #The certificate can be used for authenticating a client.
    KP_EFS = '1.3.6.1.4.1.311.10.3.4' #The certificate can be used to encrypt files by using the Encrypting File System.
    EFS_RECOVERY = '1.3.6.1.4.1.311.10.3.4.1' #The certificate can be used for recovery of documents protected by using Encrypting File System (EFS).
    DS_EMAIL_REPLICATION = '1.3.6.1.4.1.311.21.19' #The certificate can be used for Directory Service email replication.         
    ANY_APPLICATION_POLICY = '1.3.6.1.4.1.311.10.12.1' #The applications that can use the certificate are not restricted.
}

function New-CATemplate
{
    # .ExternalHelp AutomatedLab.Help.xml
    [cmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$TemplateName,
        
        [string]$DisplayName,
        
        [Parameter(Mandatory = $true)]
        [string]$SourceTemplateName,
        
        [ValidateSet('EFS_RECOVERY', 'Auto Update CA Revocation', 'No OCSP Failover to CRL', 'OEM_WHQL_CRYPTO', 'Windows TCB Component', 'DNS Server Trust', 'Windows Third Party Application Component', 'ANY_APPLICATION_POLICY', 'KP_LIFETIME_SIGNING', 'Disallowed List', 'DS_EMAIL_REPLICATION', 'LICENSE_SERVER', 'KP_KEY_RECOVERY', 'Windows Kits Component', 'AUTO_ENROLL_CTL_USAGE', 'PKIX_KP_TIMESTAMP_SIGNING', 'Windows Update', 'Document Encryption', 'KP_CTL_USAGE_SIGNING', 'IPSEC_KP_IKE_INTERMEDIATE', 'PKIX_KP_IPSEC_TUNNEL', 'Code Signing', 'KP_KEY_RECOVERY_AGENT', 'KP_QUALIFIED_SUBORDINATION', 'Early Launch Antimalware Driver', 'Remote Desktop', 'WHQL_CRYPTO', 'EMBEDDED_NT_CRYPTO', 'System Health Authentication', 'DRM', 'PKIX_KP_EMAIL_PROTECTION', 'KP_TIME_STAMP_SIGNING', 'Protected Process Light Verification', 'Endorsement Key Certificate', 'KP_IPSEC_USER', 'PKIX_KP_IPSEC_END_SYSTEM', 'LICENSES', 'Protected Process Verification', 'IdMsKpScLogon', 'HAL Extension', 'KP_OCSP_SIGNING', 'Server Authentication', 'Auto Update End Revocation', 'KP_EFS', 'KP_DOCUMENT_SIGNING', 'Windows Store', 'Kernel Mode Code Signing', 'ENROLLMENT_AGENT', 'ROOT_LIST_SIGNER', 'Windows RT Verification', 'NT5_CRYPTO', 'Revoked List Signer', 'Microsoft Publisher', 'Platform Certificate', ' Windows Software Extension Verification', 'KP_CA_EXCHANGE', 'PKIX_KP_IPSEC_USER', 'Dynamic Code Generator', 'Client Authentication', 'DRM_INDIVIDUALIZATION')]
        [string[]]$ApplicationPolicy,

        [Pki.CATemplate.EnrollmentFlags]$EnrollmentFlags,

        [Pki.CATemplate.PrivateKeyFlags]$PrivateKeyFlags = 0,

        [Pki.CATemplate.KeyUsage]$KeyUsage = 0,
        
        [int]$Version,

        [timespan]$ValidityPeriod,
        
        [timespan]$RenewalPeriod
    )

    $configNc = ([adsi]'LDAP://RootDSE').ConfigurationNamingContext
    $templateContainer = [adsi]"LDAP://CN=Certificate Templates,CN=Public Key Services,CN=Services,$configNc"
    Write-Verbose "Template container is '$templateContainer'"

    $sourceTemplate = $templateContainer.Children | Where-Object Name -eq $SourceTemplateName
    if (-not $sourceTemplate)
    {
        Write-Error "The source template '$SourceTemplateName' could not be found"
        return
    }

    if (($templateContainer.Children | Where-Object Name -eq $TemplateName))
    {
        Write-Error "The template '$TemplateName' does aleady exist"
        return
    }
    
    if (-not $DisplayName) { $DisplayName = $TemplateName }
    
    $newCertTemplate = $templateContainer.Create('pKICertificateTemplate', "CN=$TemplateName") 
    $newCertTemplate.put('distinguishedName',"CN=$TemplateName,CN=Certificate Templates,CN=Public Key Services,CN=Services,$configNc")

    $lastOid = $templateContainer.Children | 
    Sort-Object -Property { [int]($_.'msPKI-Cert-Template-OID' -split '\.')[-1] } | 
    Select-Object -Last 1 -ExpandProperty msPKI-Cert-Template-OID
    $oid = Get-NextOid -Oid $lastOid
    
    $flags = $sourceTemplate.flags.Value
    $flags = $flags -bor [Pki.CATemplate.Flags]::IsModified -bxor [Pki.CATemplate.Flags]::IsDefault
    
    $newCertTemplate.put('flags', $flags)
    $newCertTemplate.put('displayName', $DisplayName)
    $newCertTemplate.put('revision','100')
    $newCertTemplate.put('pKIDefaultKeySpec', $sourceTemplate.pKIDefaultKeySpec.Value)

    $newCertTemplate.put('pKIMaxIssuingDepth', $sourceTemplate.pKIMaxIssuingDepth.Value)
    $newCertTemplate.put('pKICriticalExtensions', $sourceTemplate.pKICriticalExtensions.Value)
    
    $eku = @($sourceTemplate.pKIExtendedKeyUsage.Value)
    $newCertTemplate.put('pKIExtendedKeyUsage', $eku)
    
    #$newCertTemplate.put('pKIDefaultCSPs','2,Microsoft Base Cryptographic Provider v1.0, 1,Microsoft Enhanced Cryptographic Provider v1.0')
    $newCertTemplate.put('msPKI-RA-Signature', '0')
    $newCertTemplate.put('msPKI-Enrollment-Flag', $EnrollmentFlags)
    $newCertTemplate.put('msPKI-Private-Key-Flag', $PrivateKeyFlags)
    $newCertTemplate.put('msPKI-Certificate-Name-Flag', $sourceTemplate.'msPKI-Certificate-Name-Flag'.Value)
    $newCertTemplate.put('msPKI-Minimal-Key-Size', $sourceTemplate.'msPKI-Minimal-Key-Size'.Value)
    
    if (-not $Version)
    {
        $Version = $sourceTemplate.'msPKI-Template-Schema-Version'.Value
    }
    $newCertTemplate.put('msPKI-Template-Schema-Version', $Version)
    $newCertTemplate.put('msPKI-Template-Minor-Revision', '1')
                   
    $newCertTemplate.put('msPKI-Cert-Template-OID', $oid)
    
    if (-not $ApplicationPolicy)
    {
        #V2 template
        $ap = $sourceTemplate.'msPKI-Certificate-Application-Policy'.Value
        if (-not $ap)
        {
            #V1 template
            $ap = $sourceTemplate.pKIExtendedKeyUsage.Value
        }
    }
    else
    {
        $ap = $ApplicationPolicy | ForEach-Object { $ApplicationPolicies[$_] }
    }
    
    if ($ap)
    {
        $newCertTemplate.put('msPKI-Certificate-Application-Policy', $ap)
    }
    
    $newCertTemplate.SetInfo()

    if ($KeyUsage)
    {
        $newCertTemplate.pKIKeyUsage = $KeyUsage
    }
    else
    {
        $newCertTemplate.pKIKeyUsage = $sourceTemplate.pKIKeyUsage
    }
    
    if ($ValidityPeriod)
    {
        $newCertTemplate.pKIExpirationPeriod.Value = [Pki.Period]::ToByteArray($ValidityPeriod)
    }
    else
    {
        $newCertTemplate.pKIExpirationPeriod = $sourceTemplate.pKIExpirationPeriod
    }
    
    if ($RenewalPeriod)
    {
        $newCertTemplate.pKIOverlapPeriod.Value = [Pki.Period]::ToByteArray($RenewalPeriod)
    }
    else
    {
        $newCertTemplate.pKIOverlapPeriod = $sourceTemplate.pKIOverlapPeriod
    }    
    $newCertTemplate.SetInfo()
}
