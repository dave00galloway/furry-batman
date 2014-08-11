using System;
using System.IO;
using System.Threading;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public static class FileExtensions
    {
        public const int FILE_DELETE_RETRY_COUNT = 5;
        public const int FILE_DELETE_RETRY_WAIT = 500;
        public static void ClearOutputDirectory(this string reportRoot)
        {
            if (Directory.Exists(reportRoot))
            {
                foreach (string file in Directory.GetFiles(reportRoot))
                {
                    try
                    {
                        File.Delete(file);
                    }
                    catch (Exception e)
                    {
                        DeleteFileWithRetry(file, e, "error trying to clear files in output directory");
                        //e.ConsoleExceptionLogger("error trying to clear files in output directory");
                    }
                }

                foreach (string subDirectory in Directory.GetDirectories(reportRoot))
                {
                    foreach (string file in Directory.GetFiles(subDirectory))
                    {
                        try
                        {
                            File.Delete(file);
                        }
                        catch (Exception e)
                        {
                            DeleteFileWithRetry(file, e, "error trying to clear files in output sub directory");
                            //e.ConsoleExceptionLogger("error trying to clear files in output sub directory");
                        }
                    }
                }
            }
            Directory.CreateDirectory(reportRoot);
        }

        private static void DeleteFileWithRetry(string file, Exception e, string errorTryingToClearFilesInOutputDirectory)
        {
            var deleted = false;
            for (int i = 0; i <= FILE_DELETE_RETRY_COUNT; i++)
            {
                try
                {
                    File.Delete(file);
                    deleted = true;
                    break;
                }
                catch (Exception)
                {
                }
                Thread.Sleep(FILE_DELETE_RETRY_WAIT);
            }
            if (deleted) return;
            try
            {
                File.Delete(file);
            }
            catch (Exception)
            {
                e.ConsoleExceptionLogger(errorTryingToClearFilesInOutputDirectory);
            }
        }

        /// <summary>
        /// Split a string containing multiple lines into an array of strings
        /// Typically useful where a csv/txt file has been transmitted as a stream or similar
        /// </summary>
        /// <param name="responseString"></param>
        /// <returns></returns>
        public static string[] SplitStringIntoLines(this string responseString)
        {
            return responseString.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
        }
    }
}