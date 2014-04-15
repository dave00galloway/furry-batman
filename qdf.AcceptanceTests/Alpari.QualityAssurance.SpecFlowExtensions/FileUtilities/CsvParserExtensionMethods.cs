using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities
{
    public static class CsvParserExtensionMethods
    {
        public static string escapeCommasIfInEscapeList(this string val, int[] grcColumnsToEscape, KeyValuePair<string, int> column)
        {
            if (grcColumnsToEscape.Contains(column.Value))
            {
                val = CsvParser.StringToCSVCell(val);
            }
            return val;
        }
    }
}
