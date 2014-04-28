using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.FluentVerifications;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    public class DataTableComparison
    {
        public List<DataRow> MissingInCompareWith { get; set; }
        public List<DataRow> AdditionalInCompareWith { get; set; }
        public DataTable FieldDifferences { get; set; }

        //add overloads/delegates to allow output of diffs to different output types
        public string CheckForDifferences()
        {
            var diffs = new StringBuilder();
            if (MissingInCompareWith.Count > 0)
            {
                var diff = String.Format("MissingInCompareWith = {0}",
                    Verify.That(MissingInCompareWith.Count, CompareUsing.SHOULD_BE, 0));
                //Verify.That(MissingInCompareWith.Count,CompareUsing.SHOULD_BE,0)
                diffs.AppendLine(diff);
                //this is the bit to swap out with a delegate:-
                Console.WriteLine(diff);
                Console.WriteLine(String.Join(",",
                    (from DataColumn column in MissingInCompareWith.First().Table.Columns select column.ColumnName)));
                foreach (var item in MissingInCompareWith)
                {
                    Console.WriteLine(String.Join(",",
                        item.ItemArray.Select(x => CsvParser.StringToCSVCell(x.ToString()))));
                }
            }

            if (AdditionalInCompareWith.Count > 0)
            {
                var diff = String.Format("AdditionalInCompareWith = {0}",
                    Verify.That(AdditionalInCompareWith.Count, CompareUsing.SHOULD_BE, 0));
                //Verify.That(MissingInCompareWith.Count,CompareUsing.SHOULD_BE,0)
                diffs.AppendLine(diff);
                //this is the bit to swap out with a delegate:-
                Console.WriteLine(diff);
                Console.WriteLine(String.Join(",",
                    (from DataColumn column in AdditionalInCompareWith.First().Table.Columns select column.ColumnName)));
                foreach (var item in AdditionalInCompareWith)
                {
                    Console.WriteLine(String.Join(",",
                        item.ItemArray.Select(x => CsvParser.StringToCSVCell(x.ToString()))));
                }
            }

            if (FieldDifferences.Rows.Count > 0)
            {
                var diff = String.Format("FieldDifferences.Rows.Count = {0}",
                    Verify.That(FieldDifferences.Rows.Count, CompareUsing.SHOULD_BE, 0));
                diffs.AppendLine(diff);
                //this is the bit to swap out with a delegate:-
                Console.WriteLine(diff);
                Console.WriteLine(String.Join(",",
                    (from DataColumn column in FieldDifferences.Columns select column.ColumnName)));
                foreach (DataRow item in FieldDifferences.Rows)
                {
                    Console.WriteLine(String.Join(",",
                        item.ItemArray.Select(x => CsvParser.StringToCSVCell(x.ToString()))));
                }
            }

            return diffs.ToString();
        }
    }
}