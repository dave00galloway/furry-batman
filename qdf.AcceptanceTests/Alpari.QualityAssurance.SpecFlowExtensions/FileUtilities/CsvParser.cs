using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Microsoft.VisualBasic.FileIO;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
// ReSharper disable once ClassNeverInstantiated.Global - used by client tests
    public class CsvParser : IDisposable
    {
        private bool _disposed;

        public CsvParser(string fileNamePath)
        {
            FileNamePath = fileNamePath;
        }

        // ReSharper disable once MemberCanBePrivate.Global  - used by client tests
        public string FileNamePath { get; private set; }

        public void Dispose()
        {
            Dispose(true);
            // This object will be cleaned up by the Dispose method. 
            // Therefore, you should call GC.SupressFinalize to 
            // take this object off the finalization queue 
            // and prevent finalization code for this object 
            // from executing a second time.
            GC.SuppressFinalize(this);
        }

        /// <summary>
        ///     Parse the CSV file into a list of lines, with no keys. Each line is a list of strings
        ///     It's assumed the client code will apply logic to the returned list to add structure to the list
        /// </summary>
        /// <returns></returns>
        public List<List<string>> ParseAsList(string delimiter)
        {
            IEnumerable<string> unparsedFile = File.ReadAllLines(FileNamePath);
            var parsedFile = new List<List<string>>();
            long lineId = 0;
            foreach (var line in unparsedFile)
            {
                lineId++;
                try
                {
                    parsedFile.Add(GetValues(line, delimiter));
                }
                catch (Exception e)
                {
                    Console.WriteLine(
                        "Error reading values for line {0} in file {1}. Line contents = {2}. Exception Details = {3}",
                        lineId, FileNamePath, line, e.Message);
                }
            }
            return parsedFile;
        }

        public List<List<string>> ParseAsList()
        {
            return ParseAsList(",");
        }

        /// <summary>
        ///     Turn a string into a CSV cell output
        ///     //TODO - put in extensions! Also check to see if it can be used to help with Fluent Assertion output, which is
        ///     still a bit of a pain to process
        ///     http://stackoverflow.com/questions/6377454/escaping-tricky-string-to-csv-format
        /// </summary>
        /// <param name="str">String to output</param>
        /// <returns>The CSV cell formatted string</returns>
        public static string StringToCsvCell(string str)
        {
            var mustQuote = (str.Contains(",") || str.Contains("\"") || str.Contains("\r") || str.Contains("\n"));
            if (mustQuote)
            {
                var sb = new StringBuilder();
                sb.Append("\"");
                foreach (var nextChar in str)
                {
                    sb.Append(nextChar);
                    if (nextChar == '"')
                        sb.Append("\"");
                }
                sb.Append("\"");
                return sb.ToString();
            }

            return str;
        }

        /// <summary>
        ///     removes characters from a string which might cause Windows a problem when creationg files/directories
        /// </summary>
        /// <param name="stringToCleanse"></param>
        /// <returns></returns>
        public static string RemoveWindowsUnfriendlyChars(object stringToCleanse)
        {
            var cleansedString =
                stringToCleanse.ToString()
                    .Replace(" ", "")
                    .Replace(@"\", "")
                    .Replace(@"/", "")
                    .Replace(@"(", "")
                    .Replace(@")", "")
                    .Replace("-", "");
            return cleansedString;
        }

        private static List<string> GetValues(string row, string delimiter)
        {
            using (var sr = new StringReader(row))
            {
                var parser = new TextFieldParser(sr);
                parser.SetDelimiters(delimiter);
// ReSharper disable once AssignNullToNotNullAttribute
                return parser.ReadFields().Select(x => x.Trim()).ToList();
            }
        }

        // Implement IDisposable. 
        // Do not make this method virtual. 
        // A derived class should not be able to override this method. 

        protected virtual void Dispose(bool disposing)
        {
            // Check to see if Dispose has already been called. 
            if (!_disposed)
            {
                // Note disposing has been done.
                _disposed = true;
            }
        }
    }
}