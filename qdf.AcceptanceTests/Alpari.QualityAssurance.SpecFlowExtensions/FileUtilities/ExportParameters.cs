using System.Collections.Generic;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    /// <summary>
    ///     class for holding info about a specific file import/export
    /// </summary>
    public class ExportParameters
    {
        //string representations of ExportTypes Enumeration to allow switching on defined set of strings
        public const string UNKNOWN = "Unknown";
        public const string CSV = "Csv";
        public const string DATABASE = "Database";
        public const string CONSOLE = "Console";
        public const string WEB_CLIENT = "WebClient";

        /// <summary>
        ///     Use this for untyped data tables
        /// </summary>
        public const string DATA_TABLE_TO_CSV = "DataTableToCsv";

        /// <summary>
        ///     Use this for untyped data tables
        /// </summary>
        public const string DATA_TABLE_TO_CONSOLE = "DataTableToConsole";

        public ExportTypes ExportType { get; set; }
        public string FileName { get; set; }
        public string Path { get; set; }
        /// <summary>
        /// used to differentiate 2 or more result sets that would otherwise conflict or overwrite each other
        /// </summary>
        public string Segregator { get; set; }
        public bool Overwrite { get; set; }
        public IDictionary<string,string> QueryParameters { get; set; }
        public string SeriesDateFormat { get; set; }
    }
}