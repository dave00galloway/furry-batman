using System.Collections.Generic;
using System.Diagnostics;

namespace Alpari.QA.ProcessRunner
{
    public class ProcessRunner : IProcessRunner
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
        }

        /// <summary>
        /// ToDo:- create an extension class for IProcessRunner and add this as a default implementation of StandardOutputHandler
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void StandardOutputHandler(object sender, DataReceivedEventArgs e)
        {
            StandardOutputList.Add(e.Data);
        }

        public IProcessStartInfoWrapper ProcessStartInfoWrapper { get; set; }
        public Process Process { get; private set; }
        public bool NewProcessStarted { get; set; }
        public IList<string> StandardOutputList { get; private set; }
    }
}