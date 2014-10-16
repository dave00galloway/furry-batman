using System;
using System.Collections;
using System.Globalization;
using System.Linq;
using System.Management;

namespace Alpari.QA.WMIExtensions.Process
{
    public class ProcessMethod
    {
        public static string StartProcess(string machineName, string processPath)
        {
            var processTask = new ManagementClass(@"\\" + machineName + @"\root\CIMV2",
                "Win32_Process", null);
            ManagementBaseObject methodParams = processTask.GetMethodParameters("Create");
            methodParams["CommandLine"] = processPath;
            ManagementBaseObject exitCode = processTask.InvokeMethod("Create", methodParams, null);
            return exitCode == null ? null : TranslateProcessStartExitCode(exitCode["ReturnValue"].ToString());
        }

        public static void KillProcess(ManagementScope connectionScope, string processName)
        {
            var msQuery = new SelectQuery("SELECT * FROM Win32_Process Where Name = '" + processName + "'");
            var searchProcedure = new ManagementObjectSearcher(connectionScope, msQuery);
            foreach (ManagementObject item in searchProcedure.Get().Cast<ManagementObject>())
            {
                try
                {
                    item.InvokeMethod("Terminate", null);
                }
                catch (SystemException e)
                {
                    Console.WriteLine("An Error Occurred: " + e.Message);
                }
            }
        }

        public static void ChangePriority(ManagementScope connectionScope,
            string processName,
            ProcessPriority.Priority priority)
        {
            var msQuery = new SelectQuery("SELECT * FROM Win32_Process Where Name = '" + processName + "'");
            var searchProcedure = new ManagementObjectSearcher(connectionScope, msQuery);
            foreach (ManagementObject item in searchProcedure.Get().Cast<ManagementObject>())
            {
                try
                {
                    ManagementBaseObject methodParams = item.GetMethodParameters("SetPriority");
                    methodParams["Priority"] = priority;
                    item.InvokeMethod("SetPriority", methodParams, null);
                }
                catch (SystemException e)
                {
                    Console.WriteLine("An Error Occurred: " + e.Message);
                }
            }
        }

        public static string ProcessOwner(ManagementScope connectionScope,
            string processName)
        {
            var msQuery = new SelectQuery("SELECT * FROM Win32_Process Where Name = '" + processName + "'");
            var searchProcedure = new ManagementObjectSearcher(connectionScope, msQuery);
            string owner = string.Empty;
            foreach (ManagementObject item in searchProcedure.Get().Cast<ManagementObject>())
            {
                try
                {
                    ManagementBaseObject methodParams = item.GetMethodParameters("GetOwner");
                    ManagementBaseObject managementBaseObject = item.InvokeMethod("GetOwner", null, null);
                    owner = managementBaseObject["User"].ToString();
                }
                catch (SystemException e)
                {
                    Console.WriteLine("An Error Occurred: " + e.Message);
                }
            }
            return owner;
        }

        public static string ProcessOwnerSid(ManagementScope connectionScope,
            string processName)
        {
            var msQuery = new SelectQuery("SELECT * FROM Win32_Process Where Name = '" + processName + "'");
            var searchProcedure = new ManagementObjectSearcher(connectionScope, msQuery);
            string owner = string.Empty;
            foreach (ManagementObject item in searchProcedure.Get().Cast<ManagementObject>())
            {
                try
                {
                    ManagementBaseObject methodParams = item.GetMethodParameters("GetOwnerSid");
                    ManagementBaseObject managementBaseObject = item.InvokeMethod("GetOwnerSid", null, null);
                    owner = managementBaseObject["Sid"].ToString();
                }
                catch (SystemException e)
                {
                    Console.WriteLine("An Error Occurred: " + e.Message);
                }
            }
            return owner;
        }

        public static ArrayList RunningProcesses(ManagementScope connectionScope)
        {
            var alProcesses = new ArrayList();
            var msQuery = new SelectQuery("SELECT * FROM Win32_Process");
            var searchProcedure = new ManagementObjectSearcher(connectionScope, msQuery);

            foreach (ManagementObject item in searchProcedure.Get().Cast<ManagementObject>())
            {
                alProcesses.Add(item["Name"].ToString());
            }
            return alProcesses;
        }

        public static ArrayList ProcessProperties(ManagementScope connectionScope,
            string processName)
        {
            var alProperties = new ArrayList();
            var msQuery = new SelectQuery("SELECT * FROM Win32_Process Where Name = '" + processName + "'");
            var searchProcedure = new ManagementObjectSearcher(connectionScope, msQuery);

            foreach (ManagementObject item in searchProcedure.Get().Cast<ManagementObject>())
            {
                try
                {
                    alProperties.Add("Caption: " + item["Caption"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("CommandLine: " + item["CommandLine"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("CreationClassName: " + item["CreationClassName"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("CreationDate: " + item["CreationDate"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("CSCreationClassName: " + item["CSCreationClassName"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("CSName: " + item["CSName"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("Description: " + item["Description"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("ExecutablePath: " + item["ExecutablePath"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("ExecutionState: " + item["ExecutionState"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("Handle: " + item["Handle"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("HandleCount: " + item["HandleCount"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("InstallDate: " + item["InstallDate"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("KernelModeTime: " + item["KernelModeTime"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("MaximumWorkingSetSize: " + item["MaximumWorkingSetSize"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("Memory Usage: " + TranslateMemoryUsage(item["WorkingSetSize"].ToString()));
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("MinimumWorkingSetSize: " + item["MinimumWorkingSetSize"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("Name: " + item["Name"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("OSCreationClassName: " + item["OSCreationClassName"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("OSName: " + item["OSName"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("OtherOperationCount: " + item["OtherOperationCount"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("OtherTransferCount: " + item["OtherTransferCount"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("PageFaults: " + item["PageFaults"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("PageFileUsage: " + item["PageFileUsage"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("ParentProcessId: " + item["ParentProcessId"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("PeakPageFileUsage: " + item["PeakPageFileUsage"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("PeakVirtualSize: " + item["PeakVirtualSize"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("PeakWorkingSetSize: " + item["PeakWorkingSetSize"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("Priority: " + item["Priority"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("PrivatePageCount: " + item["PrivatePageCount"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("ProcessId: " + item["ProcessId"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("QuotaNonPagedPoolUsage: " + item["QuotaNonPagedPoolUsage"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("QuotaPagedPoolUsage: " + item["QuotaPagedPoolUsage"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("QuotaPeakNonPagedPoolUsage: " + item["QuotaPeakNonPagedPoolUsage"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("QuotaPeakPagedPoolUsage: " + item["QuotaPeakPagedPoolUsage"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("ReadOperationCount: " + item["ReadOperationCount"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("ReadTransferCount: " + item["ReadTransferCount"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("SessionId: " + item["SessionId"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("Status: " + item["Status"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("TerminationDate: " + item["TerminationDate"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("ThreadCount: " + item["ThreadCount"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("UserModeTime: " + item["UserModeTime"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("VirtualSize: " + item["VirtualSize"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("WindowsVersion: " + item["WindowsVersion"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("WorkingSetSize: " + item["WorkingSetSize"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("WriteOperationCount: " + item["WriteOperationCount"]);
                }
                catch (SystemException)
                {
                }
                try
                {
                    alProperties.Add("WriteTransferCount: " + item["WriteTransferCount"]);
                }
                catch (SystemException)
                {
                }
            }
            return alProperties;
        }

        private static string TranslateMemoryUsage(string workingSet)
        {
            int calc = Convert.ToInt32(workingSet);
            calc = calc/1024;
            return calc.ToString(CultureInfo.InvariantCulture);
        }

        private static string TranslateProcessStartExitCode(string exitCode)
        {
            string code = string.Empty;
            int eCode = Convert.ToInt32(exitCode);
            switch (eCode)
            {
                case 0:
                    code = "Successful(Completion)";
                    break;
                case 2:
                    code = "Access(Denied)";
                    break;
                case 3:
                    code = "Insufficient(priviledge)";
                    break;
                case 8:
                    code = "Uknown(Failure)";
                    break;
                case 9:
                    code = "Path(Not Found)";
                    break;
                case 21:
                    code = "Invalid(Parameter)";
                    break;
            }
            return code;
        }
    }
}