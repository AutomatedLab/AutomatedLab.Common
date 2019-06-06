using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Text.RegularExpressions;

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