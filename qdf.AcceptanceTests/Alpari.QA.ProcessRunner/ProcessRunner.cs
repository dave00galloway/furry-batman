using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Threading;

namespace Alpari.QA.ProcessRunner
{
    /// <summary>
    ///     WTK:-
    ///     http://stackoverflow.com/questions/2316596/system-diaganostics-process-id-isnt-the-same-process-id-shown-in-task-manager
    ///     (doesn't quite work though...
    /// </summary>
    public class ProcessRunner : IProcessRunner
    {
        private IntPtr _job;

        private IList<string> _standardOutputList;
        private IList<string> _standardErrorOutputList;

        public ProcessRunner(IProcessStartInfoWrapper processStartInfoWrapper)
        {
            if (_job == IntPtr.Zero)
                _job = CreateJobObject(IntPtr.Zero, null);
            ProcessStartInfoWrapper = processStartInfoWrapper;
            ProcessStartInfoWrapper.SetupProcessStartInfo();
            Process = new Process {StartInfo = ProcessStartInfoWrapper.ProcessStartInfo};
            NewProcessStarted = Process.Start();
            if (ProcessStartInfoWrapper.RedirectStandardOutput)
            {
                _standardOutputList = new List<string>();
                Process.OutputDataReceived += StandardOutputHandler;
                Process.BeginOutputReadLine();
            }
            if (ProcessStartInfoWrapper.RedirectStandardError)
            {
                _standardErrorOutputList = new List<string>();
                Process.ErrorDataReceived += StandardErrorOutputHandler;
                Process.BeginErrorReadLine();
            }
            //defer assigning the process to the job until the stdOutput has been redirected so that no messages are missed
            AssignProcessToJobObject(_job, Process.Handle);
            if (ProcessStartInfoWrapper.RedirectStandardInput)
            {
                StreamWriter = Process.StandardInput;
            }
        }

        /// <summary>
        ///     ToDo:- create an extension class for IProcessRunner and add this as a default implementation of
        ///     StandardOutputHandler
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void StandardOutputHandler(object sender, DataReceivedEventArgs e)
        {
            lock (_standardOutputList)
            {
                _standardOutputList.Add(e.Data);
            }
        }

        public void StandardErrorOutputHandler(object sender, DataReceivedEventArgs e)
        {
            lock (_standardErrorOutputList)
            {
                _standardErrorOutputList.Add(e.Data);
            }
        }

        public void SendInput(string input)
        {
            StreamWriter.WriteLine(input);
        }

        public void WaitForStandardOutputToContainText(string expectedText, int waitTimeMilliSeconds)
        {
            var stopwatch = new Stopwatch();
            stopwatch.Start();
            while (stopwatch.ElapsedMilliseconds <= waitTimeMilliSeconds)
            {
                if (SyncOnTextInList(expectedText, false)) return;
                Thread.Sleep(20);
            }
            SyncOnTextInList(expectedText, true);
        }

        public void WaitForStandardErrorOutputToContainText(string expectedText, int waitTimeMilliSeconds)
        {
            var stopwatch = new Stopwatch();
            stopwatch.Start();
            while (stopwatch.ElapsedMilliseconds <= waitTimeMilliSeconds)
            {
                if (SyncOnTextInErrorList(expectedText, false)) return;
                Thread.Sleep(20);
            }
            SyncOnTextInErrorList(expectedText, true);
        }

        public IProcessStartInfoWrapper ProcessStartInfoWrapper { get; set; }
        public Process Process { get; private set; }
        public bool NewProcessStarted { get; set; }

        /// <summary>
        ///     publicly returns a copy of the StandardOutputList, while locking the backing field to prevent any changes
        ///     when the copy has been returned, the lock is released, and other threads can write to the property or its backing
        ///     field
        /// </summary>
        public IList<string> StandardOutputList
        {
            get
            {
                lock (_standardOutputList)
                {
                    return SetStandardOutputShadowList();
                }
            }
        }

        public IList<string> StandardErrorOutputList
        {
            get
            {
                lock (_standardErrorOutputList)
                {

                    return SetStandardErrorOutputShadowList();
                }
            }
        }


        public StreamWriter StreamWriter { get; private set; }
        

        public void Dispose()
        {
            //todo:- implement Log4Net
            // ReSharper disable EmptyGeneralCatchClause
            int processId = Process.Id;
            try
            {
                TerminateProc();
            }
            catch
            {
            }

            if (ProcessStartInfoWrapper.RedirectStandardOutput)
            {
                Process.OutputDataReceived -= StandardOutputHandler;
                _standardOutputList.Clear();
            }

            if (ProcessStartInfoWrapper.RedirectStandardError)
            {
                Process.ErrorDataReceived -= StandardOutputHandler;
                _standardErrorOutputList.Clear();
            }

            if (ProcessStartInfoWrapper.RedirectStandardInput)
            {
                StreamWriter.Flush();
                StreamWriter.Close();
            }

            try
            {
                if (!HasExitedCheck())
                {
                    Process.CloseMainWindow();
                }
            }
            catch
            {
            }
            try
            {
                Process.Close();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            try
            {
                Process.Dispose();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
            }
            try
            {
                if (!HasExitedCheck())
                {
                    Process.Kill();
                }
            }
            catch
            {
            }

            Process.Dispose();
            ProcessStartInfoWrapper.Dispose();

            try
            {
                //small theoretical risk of another process starting with same id, but this does make sure unmanaged processes close!
                Process.GetProcessById(processId).Kill();
            }
            catch
            {
            }
        }

        [DllImport("kernel32.dll", CharSet = CharSet.Unicode)]
        private static extern IntPtr CreateJobObject(IntPtr lpJobAttributes, string lpName);

        [DllImport("kernel32.dll")]
        private static extern bool AssignProcessToJobObject(IntPtr hJob, IntPtr hProcess);

        [DllImport("kernel32.dll")]
        private static extern bool TerminateJobObject(IntPtr hJob, uint uExitCode);

        private void TerminateProc()
        {
            // terminate the Job object, which kills all processes within it
            TerminateJobObject(_job, 0);
            _job = IntPtr.Zero;
        }

        private bool HasExitedCheck()
        {
            //unmanaged processes might not have .HasExited, so check here and default to false
            bool hasExited = false;
            try
            {
                hasExited = Process.HasExited;
            }
            catch
            {
            }
            return hasExited;
            // ReSharper restore EmptyGeneralCatchClause
        }

        private bool SyncOnTextInList(string expectedText, bool throwExceptions)
        {
            bool sync = false;
            lock (_standardOutputList)
            {
                try
                {
                    string[] shadowList = SetStandardOutputShadowList();
                    if (shadowList.Any(line => line.Trim().Contains(expectedText.Trim())))
                    {
                        sync = true;
                    }
                }
                catch (Exception)
                {
                    if (throwExceptions)
                    {
                        throw;
                    }
                }
            }
            return sync;
        }

        private bool SyncOnTextInErrorList(string expectedText, bool throwExceptions)
        {
            bool sync = false;
            lock (_standardErrorOutputList)
            {
                try
                {
                    string[] shadowList = SetStandardErrorOutputShadowList();
                    if (shadowList.Any(line => line.Trim().Contains(expectedText.Trim())))
                    {
                        sync = true;
                    }
                }
                catch (Exception)
                {
                    if (throwExceptions)
                    {
                        throw;
                    }
                }
            }
            return sync;
        }

        private string[] SetStandardOutputShadowList()
        {
            var shadowList = new string[_standardOutputList.Count];
            _standardOutputList.CopyTo(shadowList, 0);
            return shadowList;
        }

        private string[] SetStandardErrorOutputShadowList()
        {
            var shadowList = new string[_standardErrorOutputList.Count];
            _standardErrorOutputList.CopyTo(shadowList, 0);
            return shadowList;
        }
    }
}