using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities
{
    public static class ConsoleLogger
    {
        /// <summary>
        /// use this for simple exceoption logging if no other logging is coinfigured
        /// </summary>
        /// <param name="e"></param>
        public static void ConsoleExceptionLogger(Exception e)
        {
            Console.WriteLine(String.Format("{0} {1}", e.Message, e.StackTrace));
        }
    }
}
