using System.Collections.Generic;
using System.Linq;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public static class CsvParserExtensionMethods
    {
        public static string escapeCommasIfInEscapeList(this string val, int[] columnsToEscape,
            KeyValuePair<string, int> column)
        {
            if (columnsToEscape.Contains(column.Value))
            {
                val = CsvParser.StringToCSVCell(val);
            }
            return val;
        }
    }
}