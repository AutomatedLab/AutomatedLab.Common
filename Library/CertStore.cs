using AutomatedLab.Common;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace System.Security.Cryptography.X509Certificates
{
    public class CertificateStore
    {
        public string Name { get; set; }
        public string Location { get; set; }
        public string SystemName { get; set; }

        public override string ToString()
        {
            return string.Format("{0} {1} ({2})", Location, Name, SystemName);
        }
    }

    public class Win32
    {
        private const int FALSE = 0;
        private const int TRUE = 1;
        private static string currentStore = string.Empty;
        private static string serviceName = string.Empty;
        private static string userName = string.Empty;
        private static uint flags = (uint)CertOpenStoreFlags.CERT_STORE_FIND_ALL;

        #region Structs
        [StructLayout(LayoutKind.Sequential)]
        struct CERT_SYSTEM_STORE_RELOCATE_PARA
        {
            public IntPtr RegistryKey;
            public IntPtr StoreLocation;
        }
        #endregion

        #region Functions
        [DllImport("Crypt32", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern IntPtr CertOpenStore(
            int storeProvider,
            int encodingType,
            IntPtr hcryptProv,
            uint flags,
            string pvPara);

        [DllImport("Crypt32", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern bool CertCloseStore(
            IntPtr storeProvider,
            uint flags);

        [DllImport("Crypt32", CharSet = CharSet.Unicode, SetLastError = true)]
        static extern int CertEnumPhysicalStore(
            IntPtr SystemStore,
            uint flags,
            ArrayList userArg,
            EnumPhyCallbackWithArrayList callback
      );

        [DllImport("Crypt32", CharSet = CharSet.Unicode, SetLastError = true)]
        static extern int CertEnumSystemStore(
            uint Flags,
            [MarshalAs(UnmanagedType.LPWStr)]
            string SystemStoreLocationPara,
            ArrayList userArg,
            EnumStoreCallbackWithArrayList callback
       );

        [DllImport("Crypt32", CharSet = CharSet.Unicode, SetLastError = true)]
        static extern int CertEnumSystemStoreLocation(
            uint Flags,
            ArrayList userArg,
            EnumLocCallbackWithArrayList callback
        );

        [DllImport("Crypt32", CharSet = CharSet.Unicode, SetLastError = true)]
        static extern int CertEnumSystemStore(
            uint Flags,
            IntPtr SystemStoreLocationPara,
            ArrayList userArg,
            EnumStoreCallbackWithArrayList callback
        );
        #endregion

        #region Delegates
        delegate int EnumLocCallbackWithArrayList(
            [MarshalAs(UnmanagedType.LPWStr)]
            string storeLocation,
            uint flags,
            IntPtr reserved,
            ArrayList userArg);

        delegate int EnumPhyCallbackWithArrayList(IntPtr systemStore,
            uint flags,
            [MarshalAs(UnmanagedType.LPWStr)]
            string storeName,
            IntPtr storeInfo,
            IntPtr reserved,
            ArrayList userArg);

        delegate int EnumStoreCallbackWithArrayList(IntPtr systemStore,
            uint flags,
            IntPtr storeInfo,
            IntPtr reserved,
            ArrayList userArg);

        static int MyEnumLocCallbackWithArrayList(
            string storeLocation,
            uint flags,
            IntPtr reserved,
            ArrayList userArg)
        {

            currentStore = storeLocation;

            switch ((CertStoreLocation)flags)
            {
                case CertStoreLocation.CERT_SYSTEM_STORE_LOCAL_MACHINE:
                case CertStoreLocation.CERT_SYSTEM_STORE_LOCAL_MACHINE_GROUP_POLICY:
                case CertStoreLocation.CERT_SYSTEM_STORE_CURRENT_USER:
                case CertStoreLocation.CERT_SYSTEM_STORE_CURRENT_SERVICE:
                case CertStoreLocation.CERT_SYSTEM_STORE_CURRENT_USER_GROUP_POLICY:
                case CertStoreLocation.CERT_SYSTEM_STORE_LOCAL_MACHINE_ENTERPRISE:
                    CertEnumSystemStore(flags, IntPtr.Zero, userArg, MyEnumStoreCallbackWithArrayList);
                    break;
                case CertStoreLocation.CERT_SYSTEM_STORE_SERVICES: //Services
                    IntPtr servicePtr = Marshal.StringToHGlobalUni(serviceName);
                    CertEnumSystemStore(flags, servicePtr, userArg, MyEnumStoreCallbackWithArrayList);
                    Marshal.FreeHGlobal(servicePtr);
                    break;
                case CertStoreLocation.CERT_SYSTEM_STORE_USERS:

                default:
                    CertEnumSystemStore(flags, storeLocation, userArg, MyEnumStoreCallbackWithArrayList);
                    break;
            }
            return TRUE;
        }

        static int MyEnumStoreCallbackWithArrayList(
            IntPtr systemStore,
            uint flags,
            IntPtr storeInfo,
            IntPtr reserved,
            ArrayList userArg)
        {
            if (CertEnumPhysicalStore(systemStore, flags, userArg, MyEnumPhyCallbackWithArrayList) == 0)
            {
                Exception ex = Marshal.GetExceptionForHR(Marshal.GetHRForLastWin32Error());
            }
            return TRUE;
        }

        static int MyEnumPhyCallbackWithArrayList(
            IntPtr systemStore,
            uint flags,
            string storeName,
            IntPtr storeInfo,
            IntPtr reserved,
            ArrayList userArg)
        {
            string systemName = string.Empty;
            if (TryGetSystemName(systemStore, flags, out systemName))
            {

                userArg.Add(new CertificateStore()
                {
                    Location = currentStore,
                    Name = systemName,
                    SystemName = storeName
                }
                );
            }
            return TRUE;
        }
        #endregion

        #region Methods
        static bool TryGetSystemName(IntPtr systemStore, uint flags, out string systemName)
        {
            systemName = string.Empty;
            if (systemStore == IntPtr.Zero)
                return false;

            if (flags < 0)
            {
                CERT_SYSTEM_STORE_RELOCATE_PARA cssrp = (CERT_SYSTEM_STORE_RELOCATE_PARA)Marshal.PtrToStructure(
                    systemStore, typeof(CERT_SYSTEM_STORE_RELOCATE_PARA)
                );
                systemName = Marshal.PtrToStringUni(cssrp.StoreLocation);
                return true;
            }
            else
            {
                systemName = Marshal.PtrToStringUni(systemStore);
                return true;
            }
        }

        public static List<CertificateStore> GetCertificateStores(bool returnOnlyDefault = true)
        {
            var al = new ArrayList();
            var result = 0;

            try
            {
                result = CertEnumSystemStoreLocation((uint)CertOpenStoreFlags.CERT_STORE_FIND_ALL, al, MyEnumLocCallbackWithArrayList);
            }
            catch (Win32Exception e)
            {
                throw e;
            }

            if (returnOnlyDefault)
                return al.Cast<CertificateStore>().Where(entry => entry.SystemName == ".Default").ToList();
            else
                return al.Cast<CertificateStore>().ToList();
        }

        public static List<CertificateStore> GetServiceCertificateStores(string serviceName, bool returnOnlyDefault = true)
        {
            Win32.serviceName = serviceName;

            return GetCertificateStores(returnOnlyDefault).Where(entry => entry.Name.StartsWith(serviceName)).ToList();
        }
        #endregion
    }

    #region Enums
    [Flags]
    public enum CertOpenStoreFlags : uint
    {
        CERT_STORE_FIND_ALL = 0,
        CERT_STORE_NO_CRYPT_RELEASE_FLAG = 1,
        CERT_STORE_SET_LOCALIZED_NAME_FLAG = 2,
        CERT_STORE_DEFER_CLOSE_UNTIL_LAST_FREE_FLAG = 4,
        CERT_STORE_DELETE_FLAG = 10,
        CERT_STORE_SHARE_STORE_FLAG = 64,
        CERT_STORE_SHARE_CONTEXT_FLAG = 128,
        CERT_STORE_MANIFOLD_FLAG = 256,
        CERT_STORE_ENUM_ARCHIVED_FLAG = 512,
        CERT_STORE_UPDATE_KEYID_FLAG = 1024,
        CERT_STORE_BACKUP_RESTORE_FLAG = 2048,
        CERT_STORE_MAXIMUM_ALLOWED_FLAG = 4096,
        CERT_STORE_CREATE_NEW_FLAG = 8192,
        CERT_STORE_OPEN_EXISTING_FLAG = 16384,
        CERT_STORE_READONLY_FLAG = 32768,
        CERT_REGISTRY_STORE_REMOTE_FLAG = 65536,
        CERT_REGISTRY_STORE_SERIALIZED_FLAG = 131072,
        CERT_REGISTRY_STORE_ROAMING_FLAG = 262144,
        CERT_REGISTRY_STORE_MY_IE_DIRTY_FLAG = 524288,
        CERT_REGISTRY_STORE_LM_GPT_FLAG = 16777216,
        CERT_REGISTRY_STORE_CLIENT_GPT_FLAG = 2147483648
    }

    public enum CertStoreLocation : uint
    {
        CERT_SYSTEM_STORE_LOCATION_MASK = 16711680,
        CERT_SYSTEM_STORE_LOCATION_SHIFT = 16,

        CERT_SYSTEM_STORE_CURRENT_USER_ID = 1,  //hklm
        CERT_SYSTEM_STORE_LOCAL_MACHINE_ID = 2,//hklm\Software\Microsoft\Cryptography\Services
        CERT_SYSTEM_STORE_CURRENT_SERVICE_ID = 4,
        CERT_SYSTEM_STORE_SERVICES_ID = 5,//HKEY_USERS
        CERT_SYSTEM_STORE_USERS_ID = 6, //hkcu\Software\Policies\Microsoft\SystemCertificates
        CERT_SYSTEM_STORE_CURRENT_USER_GROUP_POLICY_ID = 7, //hklm\Software\Policies\Microsoft\SystemCertificates
        CERT_SYSTEM_STORE_LOCAL_MACHINE_GROUP_POLICY_ID = 8, //hklm\Software\Microsoft\EnterpriseCertificates
        CERT_SYSTEM_STORE_LOCAL_MACHINE_ENTERPRISE_ID = 9,

        CERT_SYSTEM_STORE_CURRENT_USER = (int)CERT_SYSTEM_STORE_CURRENT_USER_ID << (int)CERT_SYSTEM_STORE_LOCATION_SHIFT,
        CERT_SYSTEM_STORE_LOCAL_MACHINE = (int)CERT_SYSTEM_STORE_LOCAL_MACHINE_ID << (int)CERT_SYSTEM_STORE_LOCATION_SHIFT,
        CERT_SYSTEM_STORE_CURRENT_SERVICE = (int)CERT_SYSTEM_STORE_CURRENT_SERVICE_ID << (int)CERT_SYSTEM_STORE_LOCATION_SHIFT,
        CERT_SYSTEM_STORE_SERVICES = (int)CERT_SYSTEM_STORE_SERVICES_ID << (int)CERT_SYSTEM_STORE_LOCATION_SHIFT,
        CERT_SYSTEM_STORE_USERS = (int)CERT_SYSTEM_STORE_USERS_ID << (int)CERT_SYSTEM_STORE_LOCATION_SHIFT,
        CERT_SYSTEM_STORE_CURRENT_USER_GROUP_POLICY = (int)CERT_SYSTEM_STORE_CURRENT_USER_GROUP_POLICY_ID << (int)CERT_SYSTEM_STORE_LOCATION_SHIFT,
        CERT_SYSTEM_STORE_LOCAL_MACHINE_GROUP_POLICY = (int)CERT_SYSTEM_STORE_LOCAL_MACHINE_GROUP_POLICY_ID << (int)CERT_SYSTEM_STORE_LOCATION_SHIFT,
        CERT_SYSTEM_STORE_LOCAL_MACHINE_ENTERPRISE = (int)CERT_SYSTEM_STORE_LOCAL_MACHINE_ENTERPRISE_ID << (int)CERT_SYSTEM_STORE_LOCATION_SHIFT
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
    #endregion
}
