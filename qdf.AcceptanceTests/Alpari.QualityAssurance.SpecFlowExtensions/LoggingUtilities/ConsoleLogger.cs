using System;

namespace Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities
{
    public static class ConsoleLogger
    {
        /// <summary>
        ///     use this for simple exceoption logging if no other logging is coinfigured
        /// </summary>
        /// <param name="e"></param>
        public static void ConsoleExceptionLogger(this Exception e)
        {
            Console.WriteLine("{0}\r\n{1}", e.Message, e.StackTrace);
        }

        /// <summary>
        ///     use this for simple exceoption logging if no other logging is coinfigured
        /// </summary>
        /// <param name="e"></param>
        /// <param name="message"></param>
        public static void ConsoleExceptionLogger(this Exception e, string message)
        {
            Console.WriteLine("{0}\r\n{1}\r\n{2}", message, e.Message, e.StackTrace);
        }
    }
}