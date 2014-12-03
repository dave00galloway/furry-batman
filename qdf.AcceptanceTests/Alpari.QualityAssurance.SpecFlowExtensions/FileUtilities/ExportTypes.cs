using System;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public enum ExportTypes
    {
        Unknown = 0,
        Csv = 1,
        Database = 2,
        Console = 3,
        /// <summary>
        /// Use this for untyped data tables
        /// </summary>
        DataTableToCsv = 4,
        /// <summary>
        /// Use this for untyped data tables
        /// </summary>
        DataTableToConsole = 5,
        WebClient = 6
    }

    [Obsolete("Use Export Parameters class instead")]
    public enum ExportParams
    {
        FileNamePath,
        ConnectionString,
        TableName
    }
}
