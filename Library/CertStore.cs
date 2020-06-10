using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace System.Security.Cryptography.X509Certificates
{
    public class Win32
    {
        static List<string> stores = new List<string>();

        [DllImport("crypt32.dll", EntryPoint = "CertOpenStore", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern IntPtr CertOpenStore(
            int storeProvider,
            int encodingType,
            IntPtr hcryptProv,
            int flags,
            String pvPara);

        [DllImport("crypt32.dll", EntryPoint = "CertCloseStore", CharSet = CharSet.Auto, SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool CertCloseStore(
            IntPtr storeProvider,
            int flags);

        [DllImport("crypt32.dll", CharSet = CharSet.Unicode)]
        public static extern uint CertEnumSystemStore(
            uint dwFlags,
            uint pvSystemStoreLocationPara,
            string pvArg,
            CertEnumSystemStoreCallback pfnEnum
            );

        public static bool CertEnumSystemStoreCallbackMethod(
                string pvSystemStore,
                uint dwFlags,
                ref CERT_SYSTEM_STORE_INFO pStoreInfo,
                uint pvReserved,
                string pvArg
                )
        {
            stores.Add(pvSystemStore);
            return true;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct CERT_SYSTEM_STORE_INFO
        {
            uint cbSize;
        }

        public static string[] GetCertificateStores(CertStoreLocation location)
        {
            uint retval = 0;
            stores = new List<string>();

            CertEnumSystemStoreCallback StoreCallback = new CertEnumSystemStoreCallback(CertEnumSystemStoreCallbackMethod);
            retval = CertEnumSystemStore(
                (uint)location,
                0,
                "My",
                StoreCallback
                );

            return stores.ToArray();
        }
    }

    public delegate bool CertEnumSystemStoreCallback(
        [In, MarshalAs(UnmanagedType.LPWStr)]
        string pvSystemStore,
        uint dwFlags,
        ref Win32.CERT_SYSTEM_STORE_INFO pStoreInfo,
        uint pvReserved,
        [In, MarshalAs(UnmanagedType.LPWStr)]
        string pvArg
        );

    public enum CertStoreLocation
    {
        CERT_SYSTEM_STORE_CURRENT_USER = 0x00010000,
        CERT_SYSTEM_STORE_LOCAL_MACHINE = 0x00020000,
        CERT_SYSTEM_STORE_SERVICES = 0x00050000,
        CERT_SYSTEM_STORE_USERS = 0x00060000
    }

    [Flags]
    public enum CertStoreFlags
    {
        CERT_STORE_NO_CRYPT_RELEASE_FLAG = 0x00000001,
        CERT_STORE_SET_LOCALIZED_NAME_FLAG = 0x00000002,
        CERT_STORE_DEFER_CLOSE_UNTIL_LAST_FREE_FLAG = 0x00000004,
        CERT_STORE_DELETE_FLAG = 0x00000010,
        CERT_STORE_SHARE_STORE_FLAG = 0x00000040,
        CERT_STORE_SHARE_CONTEXT_FLAG = 0x00000080,
        CERT_STORE_MANIFOLD_FLAG = 0x00000100,
        CERT_STORE_ENUM_ARCHIVED_FLAG = 0x00000200,
        CERT_STORE_UPDATE_KEYID_FLAG = 0x00000400,
        CERT_STORE_BACKUP_RESTORE_FLAG = 0x00000800,
        CERT_STORE_READONLY_FLAG = 0x00008000,
        CERT_STORE_OPEN_EXISTING_FLAG = 0x00004000,
        CERT_STORE_CREATE_NEW_FLAG = 0x00002000,
        CERT_STORE_MAXIMUM_ALLOWED_FLAG = 0x00001000
    }

    public enum CertStoreProvider
    {
        CERT_STORE_PROV_MSG = 1,
        CERT_STORE_PROV_MEMORY = 2,
        CERT_STORE_PROV_FILE = 3,
        CERT_STORE_PROV_REG = 4,
        CERT_STORE_PROV_PKCS7 = 5,
        CERT_STORE_PROV_SERIALIZED = 6,
        CERT_STORE_PROV_FILENAME_A = 7,
        CERT_STORE_PROV_FILENAME_W = 8,
        CERT_STORE_PROV_FILENAME = CERT_STORE_PROV_FILENAME_W,
        CERT_STORE_PROV_SYSTEM_A = 9,
        CERT_STORE_PROV_SYSTEM_W = 10,
        CERT_STORE_PROV_SYSTEM = CERT_STORE_PROV_SYSTEM_W,
        CERT_STORE_PROV_COLLECTION = 11,
        CERT_STORE_PROV_SYSTEM_REGISTRY_A = 12,
        CERT_STORE_PROV_SYSTEM_REGISTRY_W = 13,
        CERT_STORE_PROV_SYSTEM_REGISTRY = CERT_STORE_PROV_SYSTEM_REGISTRY_W,
        CERT_STORE_PROV_PHYSICAL_W = 14,
        CERT_STORE_PROV_PHYSICAL = CERT_STORE_PROV_PHYSICAL_W,
        CERT_STORE_PROV_SMART_CARD_W = 15,
        CERT_STORE_PROV_SMART_CARD = CERT_STORE_PROV_SMART_CARD_W,
        CERT_STORE_PROV_LDAP_W = 16,
        CERT_STORE_PROV_LDAP = CERT_STORE_PROV_LDAP_W
    }
}
