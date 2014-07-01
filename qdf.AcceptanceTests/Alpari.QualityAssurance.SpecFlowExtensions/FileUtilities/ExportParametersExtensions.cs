using System;
using System.IO;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public static class ExportParametersExtensions
    {
        public static string CsvFileNamePath(this ExportParameters exportParameters)
        {
            return String.Format("{0}{1}.{2}", exportParameters.Path,
                exportParameters.FileName
                , CsvParserExtensionMethods.csv);
        }

        public static void DeleteIfOverwriting(this ExportParameters exportParameters)
        {
            if (exportParameters.Overwrite)
            {
                File.Delete(exportParameters.CsvFileNamePath());
            }
        }
    }
}