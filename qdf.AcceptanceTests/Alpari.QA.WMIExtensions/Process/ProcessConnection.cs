using System;
using System.Management;

namespace Alpari.QA.WMIExtensions.Process
{
    public class ProcessConnection
    {
        public static ConnectionOptions ProcessConnectionOptions()
        {
            var options = new ConnectionOptions
            {
                Impersonation = ImpersonationLevel.Impersonate,
                Authentication = AuthenticationLevel.Default,
                EnablePrivileges = true
            };
            return options;
        }

        public static ManagementScope ConnectionScope(string machineName,
            ConnectionOptions options)
        {
            var connectScope = new ManagementScope
            {
                Path = new ManagementPath(@"\\" + machineName + @"\root\CIMV2"),
                Options = options
            };

            try
            {
                connectScope.Connect();
            }
            catch (ManagementException e)
            {
                Console.WriteLine("An Error Occurred: " + e.Message);
            }
            return connectScope;
        }
    }
}