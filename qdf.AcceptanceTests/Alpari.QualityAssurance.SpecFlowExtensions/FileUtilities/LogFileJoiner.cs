using System;
using System.IO;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public static class LogFileJoiner
    {
        public static void JoinFiles(this CombineLogFileParameters fileParameters)
        {
            switch (fileParameters.JoinType)
            {
                case JoinType.Concatenate:
                    Console.WriteLine(fileParameters.JoinType);
                    fileParameters.Concatenate();
                    break;
                default:
                    throw new ArgumentException("not a recognised join type", "fileParameters");
            }
        }

        /// <summary>
        ///     TODO:- add check for existence of array of files to concatenate
        /// </summary>
        /// <param name="fileParameters"></param>
        private static void Concatenate(this CombineLogFileParameters fileParameters)
        {
            File.WriteAllText(fileParameters.OutputFile,
                File.ReadAllText(fileParameters.File1) + Environment.NewLine + File.ReadAllText(fileParameters.File2));
        }
    }

    public class CombineLogFileParameters
    {
        public String File1 { get; set; }
        public String File2 { get; set; }
        public String OutputFile { get; set; }

        /// <summary>
        ///     Defaults to Concatenate as enums are ints, so there is no need to try to set a default value in the constructor or
        ///     anywhere else
        /// </summary>
        public JoinType JoinType { get; set; }
    }

    public enum JoinType
    {
        Concatenate = 0
    }
}