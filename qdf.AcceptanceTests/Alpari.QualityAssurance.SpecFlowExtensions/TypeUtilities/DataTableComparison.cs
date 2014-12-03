using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.FluentVerifications;
using FluentAssertions;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    public class DataTableComparison
    {
        public List<DataRow> MissingInCompareWith { get; set; }
        public List<DataRow> AdditionalInCompareWith { get; set; }
        public DataTable FieldDifferences { get; set; }
        public List<DataRow> DuplicatesInBase { get; set; }
        public List<DataRow> DuplicatesInCompareWith { get; set; }

        //add overloads/delegates to allow output of diffs to different output types
        [Obsolete("Use an overload which specifies an output method")]
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
            ExportMissingInCompareWithByMethod(export, diffs);
            ExportAdditionalInCompareWithByMethod(export, diffs);
            ExportFieldDiffsByMethod(export, diffs);
            ExportDuplicatesInBaseByMethod(export, diffs);
            ExportDuplicatesInCompareWithByMethod(export, diffs);
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
            ExportMissingInCompareWithByMethod(export, diffs);
            export.FileName = String.Format("additional-{0}", export.FileName.Replace("missing-",""));
            ExportAdditionalInCompareWithByMethod(export, diffs);
            export.FileName = String.Format("fieldDiffs-{0}", export.FileName.Replace("additional-", ""));
            ExportFieldDiffsByMethod(export, diffs);
            export.FileName = String.Format("dupesInBase-{0}", export.FileName.Replace("fieldDiffs-", ""));
            ExportDuplicatesInBaseByMethod(export, diffs);
            export.FileName = String.Format("dupesInNew-{0}", export.FileName.Replace("dupesInBase-", ""));
            ExportDuplicatesInCompareWithByMethod(export, diffs);
            return diffs.ToString();
        }

        /// <summary>
        /// Used so often saved having to repeat this code in every project
        /// get an already prepped comparison from Scenario Context, and call the appropiate stesp as defneed in exportParameters.
        /// Assume no diffs expected.
        /// </summary>
        /// <param name="exportParameters"></param>
        /// <param name="scenarioOutputDirectory"></param>
        /// <param name="key"></param>
        public static void CheckComparisonInScenarioContext(ExportParameters exportParameters, string scenarioOutputDirectory, string key = "diffs")
        {
            var diffs = (DataTableComparison)ScenarioContext.Current[key];
            exportParameters.Path = scenarioOutputDirectory;
            diffs.CheckForDifferences(exportParameters, true).Should().BeNullOrWhiteSpace();            
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

        private void ExportAdditionalInCompareWithByMethod(ExportParameters export, StringBuilder diffs)
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

        private void ExportMissingInCompareWithByMethod(ExportParameters export, StringBuilder diffs)
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

        private void ExportDuplicatesInCompareWithByMethod(ExportParameters export, StringBuilder diffs)
        {
            if (DuplicatesInCompareWith != null && DuplicatesInCompareWith.Count > 0)
            {
                string diff = String.Format("DuplicatesInCompareWith.Count = {0}",
                    Verify.That(DuplicatesInCompareWith.Count, CompareUsing.ShouldBe, 0));
                diffs.AppendLine(diff);
                Console.WriteLine(diff);
                DuplicatesInCompareWith.ExportEnumerableByMethod(export);
            }
        }

        private void ExportDuplicatesInBaseByMethod(ExportParameters export, StringBuilder diffs)
        {
            if (DuplicatesInBase != null && DuplicatesInBase.Count > 0)
            {
                string diff = String.Format("DuplicatesInBase.Count = {0}",
                    Verify.That(DuplicatesInBase.Count, CompareUsing.ShouldBe, 0));
                diffs.AppendLine(diff);
                Console.WriteLine(diff);
                DuplicatesInBase.ExportEnumerableByMethod(export);
            }
        }


    }
}