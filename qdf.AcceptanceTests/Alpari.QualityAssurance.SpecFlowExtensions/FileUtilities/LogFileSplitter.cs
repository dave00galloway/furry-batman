using System;
using System.IO;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    /// <summary>
    ///     Contains methods to split a log file, e.g. by starting at the first instance of a string and ending at the next
    ///     instance of the same or another string. e.g. a timestamp
    /// </summary>
    public static class LogFileSplitter
    {
        /// <summary>
        ///     Simple Split based on start and end strings
        /// </summary>
        /// <param name="logFileSplitParams"></param>
        public static void CreateLogFileExtract(this LogFileSplitParams<string, string> logFileSplitParams)
        {
            string directory = Path.GetDirectoryName(logFileSplitParams.OutputFile);
            if (directory == null)
            {
                throw new ArgumentNullException(logFileSplitParams.OutputFile);
            }
            if (!Directory.Exists(directory))
            {
                Directory.CreateDirectory(directory);
            }
            using (StreamWriter writerStream = File.CreateText(logFileSplitParams.OutputFile))
            {
                using (StreamReader readerStream = File.OpenText(logFileSplitParams.FileToParse))
                {
                    string s;
                    ulong counter = 1;
                    bool start = false;
                    while ((s = readerStream.ReadLine()) != null)
                    {
                        if (!start && s.Contains(logFileSplitParams.StartAt))
                        {
                            start = true;
                        }
                        if (start)
                        {
                            try
                            {
                                writerStream.WriteLine(s);
                            }
                            catch (Exception e)
                            {
                                Console.WriteLine("Error at line {0}. Exception details {1}", counter, e);
                            }
                        }
                        if (start && s.Contains(logFileSplitParams.EndAt))
                        {
                            break;
                        }
                        counter++;
                    }
                }
            }
        }

        /// <summary>
        ///     throw  new NotImplementedException();
        /// </summary>
        /// <param name="logFileSplitParams"></param>
        public static void CreateLogFileExtract(this LogFileSplitParams<int, int> logFileSplitParams)
        {
            throw new NotImplementedException();
        }

        /// <summary>
        ///     throw  new NotImplementedException();
        /// </summary>
        /// <typeparam name="TS"></typeparam>
        /// <typeparam name="TE"></typeparam>
        /// <param name="logFileSplitParams"></param>
        public static void CreateLogFileExtract<TS, TE>(this LogFileSplitParams<TS, TE> logFileSplitParams)
        {
            throw new NotImplementedException();
        }
    }

    /// <summary>
    ///     interesting problem, it's likely  that you might want to start and stop using strings and/or line numbers
    ///     the standard step transformation requires you to specify type, so you'd need a seperate transform for each
    ///     combination of type params
    ///     and a seperate step definition specifiying swhich type transform to use. It's possible to do this, but rather
    ///     bulky, and would need to be replicated in every project that needed the steps
    ///     Could a factory method or similar provide the specialisation by examining the Specflow table? Possibly not, as what
    ///     would the return type be?
    /// </summary>
    /// <typeparam name="TS"></typeparam>
    /// <typeparam name="TE"></typeparam>
    public class LogFileSplitParams<TS, TE>
    {
        public string FileToParse { get; set; }
        public TS StartAt { get; set; }
        public TE EndAt { get; set; }
        public string OutputFile { get; set; }
    }
}