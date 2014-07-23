using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;

namespace Alpari.QA.ProcessRunner
{
    public interface IProcessRunner: IDisposable
    {
        IProcessStartInfoWrapper ProcessStartInfoWrapper { get; set; }
        Process Process { get; }
        bool NewProcessStarted { get; set; }
        IList<string> StandardOutputList { get; }
        StreamWriter StreamWriter { get; }
        void StandardOutputHandler(object sender, DataReceivedEventArgs e);
        void SendInput(string input);
        void WaitForStandardOutputToContainText(string expectedText, int i);
    }
}