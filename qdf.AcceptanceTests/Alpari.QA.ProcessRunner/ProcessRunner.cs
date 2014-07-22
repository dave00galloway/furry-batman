using System;
using System.Diagnostics;

namespace Alpari.QA.ProcessRunner
{
    public class ProcessRunner : IProcessRunner
    {
        public IProcessStartInfoWrapper ProcessStartInfoWrapper { get; set; }
        public Process Process { get; private set; }
        public bool NewProcessStarted { get; set; }

        public ProcessRunner(IProcessStartInfoWrapper processStartInfoWrapper)
        {
            ProcessStartInfoWrapper = processStartInfoWrapper;
            ProcessStartInfoWrapper.SetupProcessStartInfo();
            Process = new Process();
            //Process.Start(ProcessStartInfoWrapper.ProcessStartInfo);
            Process.StartInfo = ProcessStartInfoWrapper.ProcessStartInfo;
            NewProcessStarted = Process.Start();
        }

        
    }
}