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
            ExportMissingInCoimpareWithByMethod(export, diffs);
            AdditionalInCompareWithByMethod(export, diffs);
            ExportFieldDiffsByMethod(export, diffs);
            return diffs.ToString();
        }

        public string CheckForDifferences(ExportParameters export, bool useDefaultExportNames)
        {
            if (!useDefaultExportNames)
            {
                return CheckForDifferences(export);
            }
            var diffs = new StringBuilder();
            export.FileName = String.Format("missing-{0}", export.FileName);
            ExportMissingInCoimpareWithByMethod(export, diffs);
            export.FileName = String.Format("additional-{0}", export.FileName.Replace("missing-",""));
            AdditionalInCompareWithByMethod(export, diffs);
            export.FileName = String.Format("fieldDiffs-{0}", export.FileName.Replace("additional-", ""));
            ExportFieldDiffsByMethod(export, diffs);
            return diffs.ToString();
        }

        private void ExportFieldDiffsByMethod(ExportParameters export, StringBuilder diffs)
        {
            if (FieldDifferences.Rows.Count > 0)
            {
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
                FieldDifferences.Rows.Cast<DataRow>().ToList().ExportEnumerableByMethod(export);
            }
        }

        private void AdditionalInCompareWithByMethod(ExportParameters export, StringBuilder diffs)
        {
            if (AdditionalInCompareWith.Count > 0)
            {
                string diff = String.Format("AdditionalInCompareWith = {0}",
                    Verify.That(AdditionalInCompareWith.Count, CompareUsing.ShouldBe, 0));
                diffs.AppendLine(diff);
                Console.WriteLine(diff);
                AdditionalInCompareWith.ExportEnumerableByMethod(export);
            }
        }

        private void ExportMissingInCoimpareWithByMethod(ExportParameters export, StringBuilder diffs)
        {
            if (MissingInCompareWith.Count > 0)
            {
                string diff = String.Format("MissingInCompareWith = {0}",
                    Verify.That(MissingInCompareWith.Count, CompareUsing.ShouldBe, 0));

                diffs.AppendLine(diff);
                Console.WriteLine(diff);
                MissingInCompareWith.ExportEnumerableByMethod(export);
            }
        }


    }
}