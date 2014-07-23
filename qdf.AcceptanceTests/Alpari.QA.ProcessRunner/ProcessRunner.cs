using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading;

namespace Alpari.QA.ProcessRunner
{
    public class ProcessRunner : IProcessRunner
    {
        private IList<string> _standardOutputList;

        public ProcessRunner(IProcessStartInfoWrapper processStartInfoWrapper)
        {
            ProcessStartInfoWrapper = processStartInfoWrapper;
            ProcessStartInfoWrapper.SetupProcessStartInfo();
            Process = new Process {StartInfo = ProcessStartInfoWrapper.ProcessStartInfo};
            NewProcessStarted = Process.Start();
            if (ProcessStartInfoWrapper.RedirectStandardOutput)
            {
                StandardOutputList = new List<string>();
                Process.OutputDataReceived += StandardOutputHandler;
                Process.BeginOutputReadLine();
            }
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
                    return SetShadowList();
                }
            }
            private set { _standardOutputList = value; }
        }


        public StreamWriter StreamWriter { get; private set; }

        public void Dispose()
        {
            //unmanaged processes might not have .HasExited, so check here and default to false
            //todo:- implemet Log4Net

            if (ProcessStartInfoWrapper.RedirectStandardOutput)
            {
                Process.OutputDataReceived -= StandardOutputHandler;
                _standardOutputList.Clear();
            }
            else
            {
                Process.StandardOutput.Close();
                Process.StandardOutput.Dispose();
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
                // ReSharper disable EmptyGeneralCatchClause
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
        }

        private bool HasExitedCheck()
        {
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
                    string[] shadowList = SetShadowList();
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

        private string[] SetShadowList()
        {
            var shadowList = new string[_standardOutputList.Count];
            _standardOutputList.CopyTo(shadowList, 0);
            return shadowList;
        }
    }
}