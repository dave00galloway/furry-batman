using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    /// <summary>
    /// A parsed csv file along with its column definition
    /// </summary>
    public class DefinedCsvFile
    {
        private  ICsvColumnDefinition _CsvColumnDefinition;
        public ICsvColumnDefinition CsvColumnDefinition
        {
            //must be a way to cast this so the type info isn't lost...
            get { return  _CsvColumnDefinition; }
            private set { _CsvColumnDefinition = value; }
        }
        
        public Type FileType { get; private set; }
        public List<List<string>> ParsedFile { get; private set; }

        public DefinedCsvFile(List<List<string>> ParsedFile, ICsvColumnDefinition CsvColumnDefinition)
        {
            this.CsvColumnDefinition = CsvColumnDefinition;
            this.FileType = CsvColumnDefinition.GetType();
            this.ParsedFile = ParsedFile;
        }
    }
}
