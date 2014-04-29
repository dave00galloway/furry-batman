using System;

namespace Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities
{
    public static class ConsoleLogger
    {
        /// <summary>
        ///     use this for simple exceoption logging if no other logging is coinfigured
        /// </summary>
        /// <param name="e"></param>
        public static void ConsoleExceptionLogger(Exception e)
        {
            Console.WriteLine("{0} {1}", e.Message, e.StackTrace);
        }
    }
}