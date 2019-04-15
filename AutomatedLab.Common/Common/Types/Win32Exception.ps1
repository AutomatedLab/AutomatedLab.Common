Add-Type -TypeDefinition @'
namespace AutomatedLab.Common
{
    using System;

    public class Win32Exception : System.ComponentModel.Win32Exception
    {
        public new int ErrorCode { get; set; }

        public Win32Exception(int error) : base(error)
        {
            ErrorCode = error;
        }

        public Win32Exception(string message) : base(message)
        { }

        public Win32Exception(int error, string message)  : base(error, message)
        {
            ErrorCode = error;
        }

        public Win32Exception(string message , Exception innerException) : base(message, innerException)
        { }
    }
}
'@