using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using System;
using System.Collections.Generic;
using System.IO;

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
            foreach (string line in unparsedFile)
            {
                lineId++;
                try
                {
                    parsedFile.Add(line.GetValuesFromCsvRow(delimiter));
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
        ///     Moved to StringUtils. left call here for backwards compatibility and to provide example of usage
        ///     http://stackoverflow.com/questions/6377454/escaping-tricky-string-to-csv-format
        /// </summary>
        /// <param name="str">String to output</param>
        /// <returns>The CSV cell formatted string</returns>
        public static string StringToCsvCell(string str)
        {
            return str.StringToCsvCell();
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