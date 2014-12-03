using Alpari.QA.WMIExtensions.Process;
using System.Diagnostics;

namespace Alpari.QA.ProcessRunner
{
    /// <summary>
    ///     methods for working with Processes (not process runners)
    /// </summary>
    public static class ProcessExtensions
    {
        /// <summary>
        ///     based on http://alperguc.blogspot.co.uk/2008/11/c-process-processgetprocessesbyname.html
        /// </summary>
        /// <param name="processName"></param>
        /// <returns></returns>
        public static Process[] GetProcessesByName(this string processName)
        {
            Process[] aProc = Process.GetProcessesByName(processName);
            return aProc.Length > 0 ? aProc : null;
        }

        public static void KillProcessesByName(this string processName)
        {
            Process[] procs = processName.GetProcessesByName();
            if (procs == null) return;
            foreach (Process process in procs)
            {
                process.Kill();
            }
        }

        /// <summary>
        ///     the above code doesn't work for unmanaged processes, so adding an overload to send a kill via command line/WMI
        /// </summary>
        /// <param name="processname"></param>
        /// <param name="useWmi"></param>
        public static void KillProcessesByName(this string processname, bool useWmi)
        {
            if (useWmi)
            {
                var processObject = new ProcessLocal();
                processObject.TerminateProcess(processname);
            }
            //if (useCommandLine)
            //{
            //    using (var cmd = new ProcessRunner(new ProcessStartInfoWrapper
            //    {
            //        CreateNoWindow = true,
            //        FileName = "cmd.exe",
            //        RedirectStandardInput = true,
            //        RedirectStandardError = true,
            //        RedirectStandardOutput = true,
            //        UseShellExecute = false
            //    }))
            //    {
            //        string format = string.Format("cmd.exe /k \"taskkill /F /T /IM \"\"{0}\"\"\"", processname);
            //        Console.WriteLine(format);
            //        cmd.SendInput(format);
            //        //format = string.Format("taskkill /F /T /IM \"taskkill\"");
            //        //cmd.SendInput(format);
            //    }
            //}
            else
            {
                processname.KillProcessesByName();
            }
        }
    }
}