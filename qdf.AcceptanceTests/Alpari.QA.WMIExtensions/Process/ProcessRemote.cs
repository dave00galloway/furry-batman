using System.Collections;
using System.Management;

namespace Alpari.QA.WMIExtensions.Process
{
    public class ProcessRemote
    {
        #region "fields"

        private readonly ManagementScope _connectionScope;
        private readonly string _machineName;
        private string _domain;
        private string _password;
        private string _userName;

        #endregion

        #region "constructors"

        public ProcessRemote(string userName,
            string password,
            string domain,
            string machineName)
        {
            _userName = userName;
            _password = password;
            _domain = domain;
            _machineName = machineName;
            ConnectionOptions options = ProcessConnection.ProcessConnectionOptions();
            if (domain != null || userName != null)
            {
                options.Username = domain + "\\" + userName;
                options.Password = password;
            }
            _connectionScope = ProcessConnection.ConnectionScope(machineName, options);
        }

        #endregion

        #region "polymorphic methods"

        public ArrayList RunningProcesses()
        {
            ArrayList alProcesses = ProcessMethod.RunningProcesses(_connectionScope);
            return alProcesses;
        }

        public ArrayList ProcessProperties(string processName)
        {
            ArrayList alProperties = ProcessMethod.ProcessProperties(_connectionScope,
                processName);
            return alProperties;
        }

        public string CreateProcess(string processPath)
        {
            return ProcessMethod.StartProcess(_machineName, processPath);
        }

        public void TerminateProcess(string processName)
        {
            ProcessMethod.KillProcess(_connectionScope, processName);
        }

        public void SetPriority(string processName, ProcessPriority.Priority priority)
        {
            ProcessMethod.ChangePriority(_connectionScope, processName, priority);
        }

        public string GetProcessOwner(string processName)
        {
            return ProcessMethod.ProcessOwner(_connectionScope, processName);
        }

        public string GetProcessOwnerSid(string processName)
        {
            return ProcessMethod.ProcessOwnerSid(_connectionScope, processName);
        }

        #endregion
    }
}