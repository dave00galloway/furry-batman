﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading;

namespace Alpari.QA.ProcessRunner
{
    public class ProcessRunner : IProcessRunner, IDisposable
    {
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

        public void Dispose()
        {
            Process.Dispose();
            ProcessStartInfoWrapper.Dispose();
            NewProcessStarted = false; //shouldn't need to do this
            if (ProcessStartInfoWrapper.RedirectStandardOutput)
            {
                Process.OutputDataReceived -= StandardOutputHandler;
                StandardOutputList.Clear();
            }

            Process.StandardOutput.Close();
            Process.StandardOutput.Dispose();
            if (ProcessStartInfoWrapper.RedirectStandardInput)
            {
                StreamWriter.FlushAsync();
                StreamWriter.Close();
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
            StandardOutputList.Add(e.Data);
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
        public IList<string> StandardOutputList { get; private set; }
        public StreamWriter StreamWriter { get; private set; }

        private bool SyncOnTextInList(string expectedText, bool throwExceptions)
        {
            try
            {
                var shadowList = new string[StandardOutputList.Count];
                StandardOutputList.CopyTo(shadowList, 0);
                if (shadowList.Any(line => line.Trim().Contains(expectedText.Trim())))
                {
                    return true;
                }
            }
            catch (Exception)
            {
                if (throwExceptions)
                {
                    throw;
                }
            }
            return false;
        }
    }
}