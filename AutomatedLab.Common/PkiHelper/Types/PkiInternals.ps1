$pkiInternalsTypes = @'
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Text.RegularExpressions;

namespace Pki
{
    public static class Period
    {
        public static TimeSpan ToTimeSpan(byte[] value)
        {
            var period = BitConverter.ToInt64(value, 0); period /= -10000000;
            return TimeSpan.FromSeconds(period);
        }

        public static byte[] ToByteArray(TimeSpan value)
        {
            var period = value.TotalSeconds;
            period *= -10000000;
            return BitConverter.GetBytes((long)period);
        }
    }
}

namespace Pki.CATemplate
{
    /// <summary>
    /// 2.27 msPKI-Private-Key-Flag Attribute
    /// https://msdn.microsoft.com/en-us/library/cc226547.aspx
    /// </summary>
    [Flags]
    public enum PrivateKeyFlags
    {
        None = 0, //This flag indicates that attestation data is not required when creating the certificate request. It also instructs the server to not add any attestation OIDs to the issued certificate. For more details, see [MS-WCCE] section 3.2.2.6.2.1.4.5.7.
        RequireKeyArchival = 1, //This flag instructs the client to create a key archival certificate request, as specified in [MS-WCCE] sections 3.1.2.4.2.2.2.8 and 3.2.2.6.2.1.4.5.7.
        AllowKeyExport = 16, //This flag instructs the client to allow other applications to copy the private key to a .pfx file, as specified in [PKCS12], at a later time.
        RequireStrongProtection = 32, //This flag instructs the client to use additional protection for the private key.
        RequireAlternateSignatureAlgorithm = 64, //This flag instructs the client to use an alternate signature format. For more details, see [MS-WCCE] section 3.1.2.4.2.2.2.8.
        ReuseKeysRenewal = 128, //This flag instructs the client to use the same key when renewing the certificate.<35>
        UseLegacyProvider = 256, //This flag instructs the client to process the msPKI-RA-Application-Policies attribute as specified in section 2.23.1.<36>
        TrustOnUse = 512, //This flag indicates that attestation based on the user's credentials is to be performed. For more details, see [MS-WCCE] section 3.2.2.6.2.1.4.5.7.
        ValidateCert = 1024, //This flag indicates that attestation based on the hardware certificate of the Trusted Platform Module (TPM) is to be performed. For more details, see [MS-WCCE] section 3.2.2.6.2.1.4.5.7.
        ValidateKey = 2048, //This flag indicates that attestation based on the hardware key of the TPM is to be performed. For more details, see [MS-WCCE] section 3.2.2.6.2.1.4.5.7.
        Preferred = 4096, //This flag informs the client that it SHOULD include attestation data if it is capable of doing so when creating the certificate request. It also instructs the server that attestation may or may not be completed before any certificates can be issued. For more details, see [MS-WCCE] sections 3.1.2.4.2.2.2.8 and 3.2.2.6.2.1.4.5.7.
        Required = 8192, //This flag informs the client that attestation data is required when creating the certificate request. It also instructs the server that attestation must be completed before any certificates can be issued. For more details, see [MS-WCCE] sections 3.1.2.4.2.2.2.8 and 3.2.2.6.2.1.4.5.7.
        WithoutPolicy = 16384, //This flag instructs the server to not add any certificate policy OIDs to the issued certificate even though attestation SHOULD be performed. For more details, see [MS-WCCE] section 3.2.2.6.2.1.4.5.7.
        xxx = 0x000F0000
    }

    [Flags]
    public enum KeyUsage
    {
        DIGITAL_SIGNATURE = 0x80,
        NON_REPUDIATION = 0x40,
        KEY_ENCIPHERMENT = 0x20,
        DATA_ENCIPHERMENT = 0x10,
        KEY_AGREEMENT = 0x8,
        KEY_CERT_SIGN = 0x4,
        CRL_SIGN = 0x2,
        ENCIPHER_ONLY_KEY_USAGE = 0x1,
        DECIPHER_ONLY_KEY_USAGE = (0x80 << 8),
        NO_KEY_USAGE = 0x0
    }

    public enum KeySpec
    {
        KeyExchange = 1, //Keys used to encrypt/decrypt session keys
        Signature = 2 //Keys used to create and verify digital signatures.
    }

    /// <summary>
    /// 2.26 msPKI-Enrollment-Flag Attribute
    /// https://msdn.microsoft.com/en-us/library/cc226546.aspx
    /// </summary>
    [Flags]
    public enum EnrollmentFlags
    {
        None = 0,
        IncludeSymmetricAlgorithms = 1, //This flag instructs the client and server to include a Secure/Multipurpose Internet Mail Extensions (S/MIME) certificate extension, as specified in RFC4262, in the request and in the issued certificate.  
        CAManagerApproval = 2, // This flag instructs the CA to put all requests in a pending state.  
        KraPublish = 4, // This flag instructs the CA to publish the issued certificate to the key recovery agent (KRA) container in Active Directory.  
        DsPublish = 8, // This flag instructs clients and CA servers to append the issued certificate to the userCertificate attribute, as specified in RFC4523, on the user object in Active Directory.  
        AutoenrollmentCheckDsCert = 16, // This flag instructs clients not to do autoenrollment for a certificate based on this template if the user's userCertificate attribute (specified in RFC4523) in Active Directory has a valid certificate based on the same template.  
        Autoenrollment = 32, //This flag instructs clients to perform autoenrollment for the specified template.  
        ReenrollExistingCert = 64, //This flag instructs clients to sign the renewal request using the private key of the existing certificate.
        RequireUserInteraction = 256, // This flag instructs the client to obtain user consent before attempting to enroll for a certificate that is based on the specified template.
        RemoveInvalidFromStore = 1024, // This flag instructs the autoenrollment client to delete any certificates that are no longer needed based on the specific template from the local certificate storage.
        AllowEnrollOnBehalfOf = 2048, //This flag instructs the server to allow enroll on behalf of(EOBO) functionality.
        IncludeOcspRevNoCheck = 4096, // This flag instructs the server to not include revocation information and add the id-pkix-ocsp-nocheck extension, as specified in RFC2560 section Ã¯Â¿Â½4.2.2.2.1, to the certificate that is issued.    Windows Server 2003 - this flag is not supported.
        ReuseKeyTokenFull = 8192, //This flag instructs the client to reuse the private key for a smart card-based certificate renewal if it is unable to create a new private key on the card.Windows XP, Windows Server 2003 - this flag is not supported. NoRevocationInformation 16384 This flag instructs the server to not include revocation information in the issued certificate. Windows Server 2003, Windows Server 2008 - this flag is not supported.
        BasicConstraintsInEndEntityCerts = 32768, //This flag instructs the server to include Basic Constraints extension in the end entity certificates. Windows Server 2003, Windows Server 2008 - this flag is not supported.
        IgnoreEnrollOnReenrollment = 65536, //This flag instructs the CA to ignore the requirement for Enroll permissions on the template when processing renewal requests. Windows Server 2003, Windows Server 2008, Windows Server 2008 R2 - this flag is not supported.
        IssuancePoliciesFromRequest = 131072 //This flag indicates that the certificate issuance policies to be included in the issued certificate come from the request rather than from the template. The template contains a list of all of the issuance policies that the request is allowed to specify; if the request contains policies that are not listed in the template, then the request is rejected. Windows Server 2003, Windows Server 2008, Windows Server 2008 R2 - this flag is not supported.
    }

    /// <summary>
    /// 2.28 msPKI-Certificate-Name-Flag Attribute
    /// https://msdn.microsoft.com/en-us/library/cc226548.aspx
    /// </summary>
    [Flags]
    public enum NameFlags
    {
        EnrolleeSuppliesSubject = 1, //This flag instructs the client to supply subject information in the certificate request  
        OldCertSuppliesSubjectAndAltName = 8, //This flag instructs the client to reuse values of subject name and alternative subject name extensions from an existing valid certificate when creating a certificate renewal request. Windows Server 2003, Windows Server 2008 - this flag is not supported.
        EnrolleeSuppluiesAltSubject = 65536, //This flag instructs the client to supply subject alternate name information in the certificate request.  
        AltSubjectRequireDomainDNS = 4194304, //This flag instructs the CA to add the value of the requester's FQDN and NetBIOS name to the Subject Alternative Name extension of the issued certificate.  
        AltSubjectRequireDirectoryGUID = 16777216, //This flag instructs the CA to add the value of the objectGUID attribute from the requestor's user object in Active Directory to the Subject Alternative Name extension of the issued certificate.  
        AltSubjectRequireUPN = 33554432, //This flag instructs the CA to add the value of the UPN attribute from the requestor's user object in Active Directory to the Subject Alternative Name extension of the issued certificate.  
        AltSubjectRequireEmail = 67108864, //This flag instructs the CA to add the value of the e-mail attribute from the requestor's user object in Active Directory to the Subject Alternative Name extension of the issued certificate.  
        AltSubjectRequireDNS = 134217728, //This flag instructs the CA to add the value obtained from the DNS attribute of the requestor's user object in Active Directory to the Subject Alternative Name extension of the issued certificate.  
        SubjectRequireDNSasCN = 268435456, //This flag instructs the CA to add the value obtained from the DNS attribute of the requestor's user object in Active Directory as the CN in the subject of the issued certificate.  
        SubjectRequireEmail = 536870912, //This flag instructs the CA to add the value of the e-mail attribute from the requestor's user object in Active Directory as the subject of the issued certificate.  
        SubjectRequireCommonName = 1073741824, //This flag instructs the CA to set the subject name to the requestor's CN from Active Directory.  
        SubjectrequireDirectoryPath = -2147483648 //This flag instructs the CA to set the subject name to the requestor's distinguished name (DN) from Active Directory.
    }

    /// <summary>
    /// 2.4 flags Attribute
    /// https://msdn.microsoft.com/en-us/library/cc226550.aspx
    /// </summary>
    [Flags]
    public enum Flags
    {
        Undefined = 1, //Undefined.
        AddEmail = 2, //Reserved. All protocols MUST ignore this flag.
        Undefined2 = 4, //Undefined.
        DsPublish = 8, //Reserved. All protocols MUST ignore this flag.
        AllowKeyExport = 16, //Reserved. All protocols MUST ignore this flag.
        Autoenrollment = 32, //This flag indicates whether clients can perform autoenrollment for the specified template.
        MachineType = 64, //This flag indicates that this certificate template is for an end entity that represents a machine.
        IsCA = 128, //This flag indicates a certificate request for a CA certificate.
        AddTemplateName = 512, //This flag indicates that a certificate based on this section needs to include a template name certificate extension.
        DoNotPersistInDB = 1024, //This flag indicates that the record of a certificate request for a certificate that is issued need not be persisted by the CA. Windows Server 2003, Windows Server 2008 - this flag is not supported.
        IsCrossCA = 2048, //This flag indicates a certificate request for cross-certifying a certificate.
        IsDefault = 65536, //This flag indicates that the template SHOULD not be modified in any way.
        IsModified = 131072 //This flag indicates that the template MAY be modified if required.
    }
}

namespace Pki.Certificates
{
    public enum CertificateType
    {
        Cer,
        Pfx
    }

    public class CertificateInfo
    {
        private X509Certificate2 certificate;
        private byte[] rawContentBytes;


        public string ComputerName { get; set; }
        public string Location { get; set; }
        public string ServiceName { get; set; }
        public string Store { get; set; }
        public string Password { get; set; }


        public X509Certificate2 Certificate
        {
            get { return certificate; }
        }

        public List<string> DnsNameList
        {
            get
            {
                return ParseSujectAlternativeNames(Certificate).ToList();
            }
        }

        public string Thumbprint
        {
            get
            {
                return Certificate.Thumbprint;
            }
        }

        public byte[] CertificateBytes
        {
            get
            {
                return certificate.RawData;
            }
        }

        public byte[] RawContentBytes
        {
            get
            {
                return rawContentBytes;
            }
        }

        public CertificateInfo(X509Certificate2 certificate)
        {
            this.certificate = certificate;
            rawContentBytes = new byte[0];
        }

        public CertificateInfo(byte[] bytes)
        {
            rawContentBytes = bytes;
            certificate = new X509Certificate2(rawContentBytes);
        }

        public CertificateInfo(byte[] bytes, SecureString password)
        {
            rawContentBytes = bytes;
            certificate = new X509Certificate2(rawContentBytes, password, X509KeyStorageFlags.Exportable);
            Password = ConvertToString(password);
        }

        public CertificateInfo(string fileName)
        {
            rawContentBytes = File.ReadAllBytes(fileName);
            certificate = new X509Certificate2(rawContentBytes);
        }

        public CertificateInfo(string fileName, SecureString password)
        {
            rawContentBytes = File.ReadAllBytes(fileName);
            certificate = new X509Certificate2(rawContentBytes, password, X509KeyStorageFlags.Exportable);
            Password = ConvertToString(password);
        }

        public X509ContentType Type
        {
            get
            {
                if (rawContentBytes.Length > 0)
                    return X509Certificate2.GetCertContentType(rawContentBytes);
                else
                    return X509Certificate2.GetCertContentType(CertificateBytes);
            }
        }

        public static IEnumerable<string> ParseSujectAlternativeNames(X509Certificate2 cert)
        {
            Regex sanRex = new Regex(@"^DNS Name=(.*)", RegexOptions.Compiled | RegexOptions.CultureInvariant);

            var sanList = from X509Extension ext in cert.Extensions
                          where ext.Oid.FriendlyName.Equals("Subject Alternative Name", StringComparison.Ordinal)
                          let data = new AsnEncodedData(ext.Oid, ext.RawData)
                          let text = data.Format(true)
                          from line in text.Split(new char[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries)
                          let match = sanRex.Match(line)
                          where match.Success && match.Groups.Count > 0 && !string.IsNullOrEmpty(match.Groups[1].Value)
                          select match.Groups[1].Value;

            return sanList;
        }

        private string ConvertToString(SecureString s)
        {
            var bstr = System.Runtime.InteropServices.Marshal.SecureStringToBSTR(s);
            return System.Runtime.InteropServices.Marshal.PtrToStringAuto(bstr);
        }
    }
}
'@

try
{
    [Pki.Period]$temp = $null
}
catch
{
    Add-Type -TypeDefinition $pkiInternalsTypes
}
