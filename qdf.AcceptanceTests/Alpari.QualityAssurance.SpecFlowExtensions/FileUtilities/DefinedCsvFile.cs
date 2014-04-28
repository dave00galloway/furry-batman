using System;
using System.Collections.Generic;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    /// <summary>
    ///     A parsed csv file along with its column definition
    /// </summary>
    public class DefinedCsvFile
    {
        public DefinedCsvFile(List<List<string>> parsedFile, ICsvColumnDefinition csvColumnDefinition)
        {
            this.CsvColumnDefinition = csvColumnDefinition;
            FileType = csvColumnDefinition.GetType();
            this.ParsedFile = parsedFile;
        }

        public ICsvColumnDefinition CsvColumnDefinition { get; private set; }

        public Type FileType { get; private set; }
        public List<List<string>> ParsedFile { get; private set; }
    }
}