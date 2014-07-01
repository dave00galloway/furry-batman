using System.Security.Cryptography;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.FluentVerifications;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

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
                string diff = String.Format("MissingInCompareWith = {0}",
                    Verify.That(MissingInCompareWith.Count, CompareUsing.ShouldBe, 0));
                //Verify.That(MissingInCompareWith.Count,CompareUsing.SHOULD_BE,0)
                diffs.AppendLine(diff);
                //this is the bit to swap out with a delegate:-
                Console.WriteLine(diff);
                Console.WriteLine(String.Join(",",
                    (from DataColumn column in MissingInCompareWith.First().Table.Columns select column.ColumnName)));
                foreach (DataRow item in MissingInCompareWith)
                {
                    Console.WriteLine(String.Join(",",
                        item.ItemArray.Select(x => CsvParser.StringToCsvCell(x.ToString()))));
                }
            }

            if (AdditionalInCompareWith.Count > 0)
            {
                string diff = String.Format("AdditionalInCompareWith = {0}",
                    Verify.That(AdditionalInCompareWith.Count, CompareUsing.ShouldBe, 0));
                //Verify.That(MissingInCompareWith.Count,CompareUsing.SHOULD_BE,0)
                diffs.AppendLine(diff);
                //this is the bit to swap out with a delegate:-
                Console.WriteLine(diff);
                Console.WriteLine(String.Join(",",
                    (from DataColumn column in AdditionalInCompareWith.First().Table.Columns select column.ColumnName)));
                foreach (DataRow item in AdditionalInCompareWith)
                {
                    Console.WriteLine(String.Join(",",
                        item.ItemArray.Select(x => CsvParser.StringToCsvCell(x.ToString()))));
                }
            }

            if (FieldDifferences.Rows.Count > 0)
            {
                //check the diffs aren't empty
                var emptyDiffQuery = (from DataRow row in FieldDifferences.Rows
                    where row["difference"].ToString() != ""
                    select row).ToList();
                if (emptyDiffQuery.Count > 0)
                {
                    string diff = String.Format("emptyDiffQuery.Count = {0}",
                        Verify.That(emptyDiffQuery.Count, CompareUsing.ShouldBe, 0));
                    diffs.AppendLine(diff);
                    //this is the bit to swap out with a delegate:-
                    Console.WriteLine(diff);                    
                }

                Console.WriteLine(String.Join(",",
                    (from DataColumn column in FieldDifferences.Columns select column.ColumnName)));
                foreach (DataRow item in FieldDifferences.Rows)
                {
                    Console.WriteLine(String.Join(",",
                        item.ItemArray.Select(x => CsvParser.StringToCsvCell(x.ToString()))));
                }
            }

            return diffs.ToString();
        }

        public string CheckForDifferences(ExportParameters export)
        {
            var diffs = new StringBuilder();
            if (MissingInCompareWith.Count > 0)
            {
                string diff = String.Format("MissingInCompareWith = {0}",
                    Verify.That(MissingInCompareWith.Count, CompareUsing.ShouldBe, 0));
                
                diffs.AppendLine(diff);
                Console.WriteLine(diff);
                //var values = new List<List<KeyValuePair<string, string>>>();
                //var columns = (from DataColumn column in MissingInCompareWith.First().Table.Columns
                //    select column.ColumnName).ToList();
                //foreach (var row in MissingInCompareWith)
                //{
                //    var value = new List<KeyValuePair<string, string>>();
                //    for (int j = 0; j < row.ItemArray.Length; j++)
                //    {
                //        value.Add(new KeyValuePair<string, string>(columns[j],row.ItemArray[j].ToString().StringToCsvCell(true)));
                //    }
                //    values.Add(value);
                //}
                MissingInCompareWith.ExportEnumerableByMethod(export);

            }

            if (AdditionalInCompareWith.Count > 0)
            {
                string diff = String.Format("AdditionalInCompareWith = {0}",
                    Verify.That(AdditionalInCompareWith.Count, CompareUsing.ShouldBe, 0));
                //Verify.That(MissingInCompareWith.Count,CompareUsing.SHOULD_BE,0)
                diffs.AppendLine(diff);
                Console.WriteLine(diff);
                //this is the bit to swap out with a delegate:-
                AdditionalInCompareWith.ExportEnumerableByMethod(export);
            }

            if (FieldDifferences.Rows.Count > 0)
            {
                //check the diffs aren't empty
                var emptyDiffQuery = (from DataRow row in FieldDifferences.Rows
                                      where row["difference"].ToString() != ""
                                      select row).ToList();
                if (emptyDiffQuery.Count > 0)
                {
                    string diff = String.Format("emptyDiffQuery.Count = {0}",
                        Verify.That(emptyDiffQuery.Count, CompareUsing.ShouldBe, 0));
                    diffs.AppendLine(diff);
                    Console.WriteLine(diff);
                }
                //List<DataRow> rows = FieldDifferences.Rows.Cast<DataRow>().ToList();
                FieldDifferences.Rows.Cast<DataRow>().ToList().ExportEnumerableByMethod(export);

            }

            return diffs.ToString();
        }
    }
}