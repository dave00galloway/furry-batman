using System.Collections;

namespace Alpari.QA.WMIExtensions.Process
{
    public interface IProcessObject
    {
        ArrayList RunningProcesses();
        ArrayList ProcessProperties(string processName);
        string CreateProcess(string processPath);
        void TerminateProcess(string processName);
        void SetPriority(string processName, ProcessPriority.Priority priority);
        string GetProcessOwner(string processName);
        string GetProcessOwnerSid(string processName);
    }
}