using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public static class LogFileParser
    {
        public static List<T> ParseLogFileToMemory<T>(this LogFileParserParameters logFileParameters) where T : new()
        {
            string delimiter = logFileParameters.InnerSyntaxDelimiter.ToString(CultureInfo.InvariantCulture);
            string joinBy = LogFileParserParameters.GetParseSyntaxBlocks(logFileParameters).Last().JoinBy;
            List<JoinSyntax> columnJoins = LogFileParserParameters.GetJoinSyntaxBlocks(logFileParameters);
            List<string> propNames = TypeExtensions.GetTypeFromT<T>().GetPropertyNamesAsList();
            List<string> vals = GetValuesAsStringList(logFileParameters);

            if (columnJoins != null)
            {
                for (int index = 0; index < vals.Count; index++)
                {
                    var s = vals[index];
                    vals[index] = LogFileParserParameters.JoinColumns(s, columnJoins, joinBy, logFileParameters.OuputDelimiter);
                }
            }

            ////make the reasonable assumption that the first column is going to be a DateTime. hard code the format for now
            //for (int index = 0; index < vals.Count; index++)
            //{
            //    var val = vals[index];
            //    var columns = val.Split(Convert.ToChar(logFileParameters.OuputDelimiter));
            //    columns[0] = DateTime.Parse(columns[0],new System.Globalization.CultureInfo("en-GB", true),System.Globalization.DateTimeStyles.AssumeLocal)).
            //    ToString();
            //    ;
            //    //DateTime.Parse(val.Split(',')[0], new System.Globalization.CultureInfo("en-GB", true),
            //    //    System.Globalization.DateTimeStyles.AssumeLocal);

            //    vals[index]
            //}


            vals.Insert(0, String.Join(logFileParameters.OuputDelimiter, propNames));
            var list = vals.UntypedStringArrayToList<T>(logFileParameters.OuputDelimiter, null);

            return list;
        }

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
                ParseLogFile(logFileParameters, writerStream);
            }
        }

        private static void ParseLogFile(LogFileParserParameters logFileParameters, StreamWriter writerStream)
        {
            using (StreamReader readerStream = File.OpenText(logFileParameters.FileToParse))
            {
                string s;
                List<ParseSyntax> syntaxBlocks = LogFileParserParameters.GetParseSyntaxBlocks(logFileParameters);
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

        private static List<string> GetValuesAsStringList(LogFileParserParameters logFileParameters)
        {
            var list = new List<string>();
            using (StreamReader readerStream = File.OpenText(logFileParameters.FileToParse))
            {
                string s;
                List<ParseSyntax> syntaxBlocks = LogFileParserParameters.GetParseSyntaxBlocks(logFileParameters);
                while ((s = readerStream.ReadLine()) != null)
                {
                    s = s.ParseLine(syntaxBlocks);
                    if (s != null)
                    {
                        list.Add(s);
                    }
                }
            }
            return list;
        }

        private static string ParseLine(this string stringToParse, IEnumerable<ParseSyntax> syntaxBlocks)
        {
            if (stringToParse == null) return null;
            foreach (ParseSyntax syntaxBlock in syntaxBlocks)
            {
                //var parsedString = syntaxBlock.ApplyDelimiterTo > 0
                //    ? stringToParse.Split(new[] { syntaxBlock.Delimiter }, syntaxBlock.ApplyDelimiterTo)
                //    : stringToParse.Split(syntaxBlock.Delimiter);
                string[] parsedString = stringToParse.Split(syntaxBlock.Delimiter);
                for (int index = 0; index < parsedString.Length; index++)
                {
                    string s = parsedString[index];
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

        /// <summary>
        ///     specify using the Inner and outer delimiters which columns if any to join
        ///     only relevant to parsing to memory
        ///     e.g. given an 0uter delimiter of ^ and an inner delimiter of ,
        ///     0,1, ,^2,3, ,
        ///     means join columns 0 and 1 and 2 and 3. Note the second join will be on the columns in the result of the first join, so use with care!
        /// </summary>
        public string ColumnJoins { get; set; }
        public string OuputDelimiter { get; set; }

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

        public static List<JoinSyntax> GetJoinSyntaxBlocks(LogFileParserParameters logFileParameters)
        {
            if (logFileParameters.ColumnJoins == null) return null;
            string[] blocks = logFileParameters.ColumnJoins.Split(logFileParameters.OuterSyntaxDelimiter);
            return
                blocks.Select(block => block.Split(logFileParameters.InnerSyntaxDelimiter))
                    .Select(elements => new JoinSyntax
                    {
                        Col1 = Convert.ToInt32(elements[0]),
                        Col2 = Convert.ToInt32(elements[1]),
                        JoinBy = elements[2]
                    }).ToList();
        }

        public static string JoinColumns(string s, IEnumerable<JoinSyntax> columnJoins, string delimiter, string ouputDelimiter)
        {
            foreach (JoinSyntax columnJoin in columnJoins)
            {
                var columns = s.Split(new[] {Convert.ToChar(delimiter)}).ToList();
                columns[columnJoin.Col1] = String.Format("{0}{1}{2}", columns[columnJoin.Col1], columnJoin.JoinBy,
                    columns[columnJoin.Col2]);
                columns.RemoveAt(columnJoin.Col2);
                s = String.Join(ouputDelimiter, columns);
            }
            return s;
        }
    }

    public class JoinSyntax
    {
        public int Col1 { get; set; }
        public int Col2 { get; set; }

        /// <summary>
        ///     which character to join the resultant string with
        /// </summary>
        public string JoinBy { get; set; }
    }

    public class ParseSyntax
    {
        /// <summary>
        ///     which character to split the current line at
        /// </summary>
        public char Delimiter { get; set; }

        /// <summary>
        ///     delimit only to the nth instance  of the delimiter. 0 means all
        ///     currently all is the only setting that works here
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
    }
}