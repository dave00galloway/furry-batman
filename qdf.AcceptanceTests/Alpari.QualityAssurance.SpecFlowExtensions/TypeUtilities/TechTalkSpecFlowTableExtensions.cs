using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    /// Class for performing failry generic operations on Specflow tables
    /// </summary>
    public static class TechTalkSpecFlowTableExtensions
    {
        public static string[] IgnoredFieldsQuery(this Table table)
        {
            string[] ignoredFieldsQuery = table.Rows.Select(row => row["ExcludedFields"]).ToArray();
            return ignoredFieldsQuery;
        }

        public static string[] IgnoredFieldsQuery(this Table table, string columnToIgnore)
        {
            string[] ignoredFieldsQuery = table.Rows.Select(row => row[columnToIgnore]).ToArray();
            return ignoredFieldsQuery;
        }

        public static string[] ColumnToList(this Table table, string columnToExtract)
        {
            return table.Rows.Select(row => row[columnToExtract]).ToArray();
        }
    }
}
