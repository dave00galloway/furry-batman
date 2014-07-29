using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QA.ProcessRunner
{
    /// <summary>
    /// http://stackoverflow.com/questions/283128/how-do-i-send-ctrlc-to-a-process-in-c
    /// Unfortunately doesn't work, but it would be nice if it did....
    /// </summary>
    public static class GenerateConsoleControlEvent
    {
        //import in the declaration for GenerateConsoleCtrlEvent
        [DllImport("kernel32.dll", SetLastError = true)]
        static extern bool GenerateConsoleCtrlEvent(ConsoleCtrlEvent sigevent, int dwProcessGroupId);

        private enum ConsoleCtrlEvent
        {
            CtrlC = 0
            //    ,
            //CTRL_BREAK = 1,
            //CTRL_CLOSE = 2,
            //CTRL_LOGOFF = 5,
            //CTRL_SHUTDOWN = 6
        }

        //set up the parents CtrlC event handler, so we can ignore the event while sending to the child
        private static volatile bool _sendingCtrlCToChild;
        static void Console_CancelKeyPress(object sender, ConsoleCancelEventArgs e)
        {
            e.Cancel = _sendingCtrlCToChild;
        }

        public static void CloseProcessViaCtrlC(this Process processToClose)
        {
            //hook up the event handler in the parent
            Console.CancelKeyPress += Console_CancelKeyPress;   

           //sned the ctrl-c to the process group (the parent will get it too!)
            _sendingCtrlCToChild = true;
            GenerateConsoleCtrlEvent(ConsoleCtrlEvent.CtrlC, processToClose.Id);
            processToClose.WaitForExit();
            _sendingCtrlCToChild = false;

            //note that the ctrl-c event will get called on the parent on background thread
            //so you need to be sure the parent has handled and checked SENDING_CTRL_C_TO_CHILD
            //already before setting it to false. 1000 ways to do this, obviously.         
        }
    }
}
