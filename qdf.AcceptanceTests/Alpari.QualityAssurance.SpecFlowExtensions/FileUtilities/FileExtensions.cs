using System;
using System.IO;
using System.Threading;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using Microsoft.VisualBasic.Devices;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public static class FileExtensions
    {
        //public const int FILE_DELETE_RETRY_COUNT = 5;
        //public const int FILE_DELETE_RETRY_WAIT = 500;
        public static void ClearOutputDirectory(this string reportRoot)
        {
            if (Directory.Exists(reportRoot))
            {
                foreach (string file in Directory.GetFiles(reportRoot))
                {
                    File.Delete(file);
                    //try
                    //{
                    //    File.Delete(file);
                    //}
                    //catch (Exception e)
                    //{
                    //    DeleteFileWithRetry(file, e, "error trying to clear files in output directory");
                    //    //e.ConsoleExceptionLogger("error trying to clear files in output directory");
                    //}
                }

                foreach (string subDirectory in Directory.GetDirectories(reportRoot))
                {
                    foreach (string file in Directory.GetFiles(subDirectory))
                    {
                        File.Delete(file);
                        //try
                        //{
                        //    File.Delete(file);
                        //}
                        //catch (Exception e)
                        //{
                        //    DeleteFileWithRetry(file, e, "error trying to clear files in output sub directory");
                        //    //e.ConsoleExceptionLogger("error trying to clear files in output sub directory");
                        //}
                    }
                }
            }
            Directory.CreateDirectory(reportRoot);
        }

        /// <summary>
        /// Copy the source directory to the destination directory.
        /// Use the VB method initially. If there is an exception, try again using System.IO Directory and File objects to recursively create and copy the files and folders
        /// This will allow files and folders which aren't locked (or have another cause of error), to be copied individually, and exceptions on individual files and folders are reported to the console
        /// </summary>
        /// <param name="sourceDirectory"></param>
        /// <param name="newDirectory"></param>
        /// <param name="deleteSource"></param>
        public static void RecursivelyCopyDirectory(this string sourceDirectory, string newDirectory, bool deleteSource = false)
        {
            bool exceptionThrown = false;
            Directory.CreateDirectory(newDirectory);
            //http://stackoverflow.com/questions/58744/best-way-to-copy-the-entire-contents-of-a-directory-in-c-sharp
            try
            {
                new Computer().FileSystem.CopyDirectory(sourceDirectory,newDirectory);
            }
            catch (Exception)
            {
                exceptionThrown = true;
                //foreach (string file in Directory.GetFiles(MasterStepBase.ScenarioOutputDirectory))
                //{
                //    string newFile = String.Format("{0}{1}", newDirectory, file.Split(new[] { '\\' })[file.Split(new[] { '\\' }).Length - 1]);
                //    File.Copy(file, newFile);
                //}
                //Now Create all of the directories
                foreach (string dirPath in Directory.GetDirectories(sourceDirectory, "*",
                    SearchOption.AllDirectories))
                    try
                    {
                        Directory.CreateDirectory(dirPath.Replace(sourceDirectory, newDirectory));
                    }
                    catch (Exception e)
                    {
                        e.ConsoleExceptionLogger(String.Format("error creating directory{0}", dirPath));
                    }

                //Copy all the files & Replaces any files with the same name
                foreach (string newPath in Directory.GetFiles(sourceDirectory, "*",
                    SearchOption.AllDirectories))
                    try
                    {
                        File.Copy(newPath, newPath.Replace(sourceDirectory, newDirectory), true);
                    }
                    catch (Exception e)
                    {
                        e.ConsoleExceptionLogger(String.Format("error copying file directory{0}", newPath));
                    }
            }
            if (deleteSource && !exceptionThrown)
            {
                Directory.Delete(sourceDirectory,true);
            }
        }

        //private static void DeleteFileWithRetry(string file, Exception e, string errorTryingToClearFilesInOutputDirectory)
        //{
        //    var deleted = false;
        //    for (int i = 0; i <= FILE_DELETE_RETRY_COUNT; i++)
        //    {
        //        try
        //        {
        //            File.Delete(file);
        //            deleted = true;
        //            break;
        //        }
        //        catch (Exception)
        //        {
        //        }
        //        Thread.Sleep(FILE_DELETE_RETRY_WAIT);
        //    }
        //    if (deleted) return;
        //    try
        //    {
        //        File.Delete(file);
        //    }
        //    catch (Exception)
        //    {
        //        e.ConsoleExceptionLogger(errorTryingToClearFilesInOutputDirectory);
        //    }
        //}

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