using System;
using System.IO;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public static class FileExtensions
    {
        public static void ClearOutputDirectory(this string reportRoot)
        {
            if (Directory.Exists(reportRoot))
            {
                foreach (string file in Directory.GetFiles(reportRoot))
                {
                    File.Delete(file);
                }

                foreach (string subDirectory in Directory.GetDirectories(reportRoot))
                {
                    foreach (string file in Directory.GetFiles(subDirectory))
                    {
                        File.Delete(file);
                    }
                }
            }
            Directory.CreateDirectory(reportRoot);
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