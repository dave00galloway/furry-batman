using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    //public interface ILogFileParser
    //{
    //    void ParseLogFileToFile();
    //}

    public static class LogFileParser
    {
        public static void ParseLogFileToFile(this LogFileParserParameters logFileParameters)
        {
            string directory = Path.GetDirectoryName(logFileParameters.OutputFile);
            if (directory == null)
            {
                throw new ArgumentNullException(logFileParameters.OutputFile);
            }
            if (!Directory.Exists(directory))
            {
                Directory.CreateDirectory(directory);
            }
            using (StreamWriter writerStream = File.CreateText(logFileParameters.OutputFile))
            {
                using (StreamReader readerStream = File.OpenText(logFileParameters.FileToParse))
                {
                    string s;
                    var syntaxBlocks = ParseSyntax.GetParseSyntaxBlocks(logFileParameters);
                    while ((s = readerStream.ReadLine()) != null)
                    {
                        s = s.ParseLine(syntaxBlocks);
                        if (s != null)
                        {
                            //Console.WriteLine(s);
                            writerStream.WriteLine(s);                            
                        }
                    }
                }
            }
        }

        private static string ParseLine(this string stringToParse, IEnumerable<ParseSyntax> syntaxBlocks)
        {
            if (stringToParse == null) return null;
            foreach (ParseSyntax syntaxBlock in syntaxBlocks)
            {
                //var parsedString = syntaxBlock.ApplyDelimiterTo > 0
                //    ? stringToParse.Split(new[] { syntaxBlock.Delimiter }, syntaxBlock.ApplyDelimiterTo)
                //    : stringToParse.Split(syntaxBlock.Delimiter);
                var parsedString = stringToParse.Split(syntaxBlock.Delimiter);
                for (int index = 0; index < parsedString.Length; index++)
                {
                    var s = parsedString[index];
                    parsedString[index] = s.Trim();
                }
                if (syntaxBlock.IncludeCriteria.Length > 0)
                {
                    if (!parsedString[syntaxBlock.ApplyIncludeTo].Contains(syntaxBlock.IncludeCriteria))
                    {
                        stringToParse = null;
                        break;
                    }
                }
                stringToParse = String.Join(syntaxBlock.JoinBy, parsedString).Trim();
            }

            return stringToParse;
        }
    }

    public class LogFileParserParameters
    {
        public string FileToParse { get; set; }
        public string OutputFile { get; set; }
        public string ParseSyntax { get; set; }

        /// <summary>
        ///     which character delimits the differnet syntax blocks?
        /// </summary>
        public char OuterSyntaxDelimiter { get; set; }

        public char InnerSyntaxDelimiter { get; set; }
    }

    public class ParseSyntax
    {
        /// <summary>
        ///     which character to split the current line at
        /// </summary>
        public char Delimiter { get; set; }

        /// <summary>
        ///     delimit only to the nth instance  of the delimiter. 0 means all
        /// </summary>
        public int ApplyDelimiterTo { get; set; }

        /// <summary>
        ///     if specified, only keep lines that contain this text
        /// </summary>
        public string IncludeCriteria { get; set; }

        /// <summary>
        ///     apply the include criteria to this column in the parsed line
        /// </summary>
        public int ApplyIncludeTo { get; set; }

        /// <summary>
        ///     which character to join the resultant string with
        /// </summary>
        public string JoinBy { get; set; }

        public static List<ParseSyntax> GetParseSyntaxBlocks(LogFileParserParameters logFileParameters)
        {
            string[] blocks = logFileParameters.ParseSyntax.Split(logFileParameters.OuterSyntaxDelimiter);
            return
                blocks.Select(block => block.Split(logFileParameters.InnerSyntaxDelimiter))
                    .Select(elements => new ParseSyntax
                    {
                        Delimiter = Convert.ToChar(elements[0]),
                        ApplyDelimiterTo = Convert.ToInt16(elements[1]),
                        IncludeCriteria = elements[2],
                        ApplyIncludeTo = Convert.ToInt16(elements[3]),
                        JoinBy = elements[4]
                    }).ToList();
        }
    }
}