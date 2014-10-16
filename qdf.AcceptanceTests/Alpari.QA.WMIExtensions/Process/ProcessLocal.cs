using System;
using System.Collections;
using System.Management;

namespace Alpari.QA.WMIExtensions.Process
{
    public class ProcessLocal : IProcessObject
    {
        #region "fields"

        private readonly ManagementScope _connectionScope;

        #endregion

        #region "constructors"

        public ProcessLocal()
        {
            ConnectionOptions options = ProcessConnection.ProcessConnectionOptions();
            _connectionScope = ProcessConnection.ConnectionScope(
                Environment.MachineName, options);
        }

        #endregion

        #region "polymorphic methods"

        public ArrayList RunningProcesses()
        {
            var alProcesses = ProcessMethod.RunningProcesses(_connectionScope);
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
            return ProcessMethod.StartProcess(Environment.MachineName, processPath);
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