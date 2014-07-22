using System.Collections.Generic;
using System.Diagnostics;

namespace Alpari.QA.ProcessRunner
{
    public interface IProcessRunner
    {
        IProcessStartInfoWrapper ProcessStartInfoWrapper { get; set; }
        Process Process { get; }
        bool NewProcessStarted { get; set; }
        IList<string> StandardOutputList { get; }
        void StandardOutputHandler(object sender, DataReceivedEventArgs e);
    }
}