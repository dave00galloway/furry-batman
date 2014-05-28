using System.Globalization;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using qdf.AcceptanceTests.DataContexts;
using qdf.AcceptanceTests.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcStepBase :StepCentral
    {

        public static readonly string FullName = typeof(QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcStepBase).FullName;
        protected SignalsCompareDataSnapOnCCDataContext SignalsCompareDataSnapOnCcDataContext { get; private set; }
        protected DiffDeltaParameters DiffDeltaParameters { get; set; }
        protected List<DiffDeltaParameters> DiffDeltaParameterList { get; set; }
        protected DiffDeltaFinder DiffDeltaFinder { get; private set; }
        public List<List<DiffDeltaResult>> DiffDeltaList { get; private set; }
        public Dictionary<string,List<DiffDeltaSummary>> DiffDeltaSummary { get; private set; }
        public Dictionary<string, decimal> DeltaSumDecimals { get; set; }

        public QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcStepBase(SignalsCompareDataSnapOnCc signalsCompareDataSnapOnCc, DiffDeltaFinder diffDeltaFinder)
        {
            DiffDeltaFinder = diffDeltaFinder;
            SignalsCompareDataSnapOnCcDataContext = signalsCompareDataSnapOnCc.SignalsCompareDataSnapOnCcDataContext;
            DiffDeltaList = new List<List<DiffDeltaResult>>();
            DiffDeltaSummary = new Dictionary<string, List<DiffDeltaSummary>>();
        }

        [StepArgumentTransformation]
        public static DiffDeltaParameters DiffDeltaParametersTransform(Table table)
        {
            return table.CreateInstance<DiffDeltaParameters>();
        }

        [StepArgumentTransformation]
        public List<DiffDeltaParameters> DiffDeltaParametersListTransform(Table table)
        {
            //get distict combinations of data
            var start = table.Rows.First()["StartDate"];
            var startDate = Convert.ToDateTime(start);
            var end = table.Rows.First()["EndDate"];
            var endDate = Convert.ToDateTime(end);
            var distinctCombosQuery =
                SignalsCompareDataSnapOnCcDataContext.CompareDataSnapOnCCs.Where(
                    cd => cd.TimeStamp >= startDate &&
                               cd.TimeStamp < endDate
                    )
                    .Select(cd => new {cd.Book, cd.Symbol, cd.Server})
                    .Distinct().OrderBy(cd=> cd.Server).ThenBy(cd=>cd.Book).ThenBy(cd=>cd.Symbol);
            var returnTable = new Table(new[] { "Book", "Symbol" ,"Server" ,"StartDate","EndDate","NumberOfDiffs" });
            foreach (var combo in distinctCombosQuery)
            {
                returnTable.AddRow(new[] { combo.Book, combo.Symbol, combo.Server, start, end, table.Rows.First()["NumberOfDiffs"] });
            }

            //return data
            return returnTable.CreateSet<DiffDeltaParameters>().ToList();
        }

        protected void GetDeltaDiffsAndOutput(string exportMethod, out List<DiffDeltaResult> diffDeltaQuery, out List<DiffDeltaSummary> diffDeltaSummaryQuery, string diffDeltaSummary = "diffDeltaSummary", string diffDeltas = "diffDeltas")
        {
            diffDeltaQuery = DiffDeltaFinder.DiffDeltas.SelectMany(diffDelta => diffDelta.CompareData,
                (diffDelta, compareData) =>
                    new DiffDeltaResult
                    {
                        HiSource = diffDelta.HiSource.ToString(),
                        LoSource = diffDelta.LoSource.ToString(),
                        Section = compareData.Section,
                        Diff = diffDelta.Diff,
                        Delta = diffDelta.Delta,
                        Id = compareData.Id,
                        Position = compareData.Position,
                        Start = diffDelta.StartTimeStamp,
                        TimeStamp = compareData.TimeStamp,
                        End = diffDelta.EndTimeStamp
                    }).ToList();
            diffDeltaSummaryQuery = DiffDeltaFinder.DiffDeltas.Select(diffDelta => new DiffDeltaSummary
            {
                HiSource = diffDelta.HiSource.ToString(),
                LoSource = diffDelta.LoSource.ToString(),
                Diff = diffDelta.Diff,
                Delta = diffDelta.Delta,
                Start = diffDelta.StartTimeStamp,
                End = diffDelta.EndTimeStamp
            }).ToList();


            switch ((ExportTypes)Enum.Parse(typeof(ExportTypes), CultureInfo.InvariantCulture.TextInfo.ToTitleCase(exportMethod.ToLower())))
            {
                case ExportTypes.Csv:
                    diffDeltaQuery.EnumerableToCsv(String.Format("{0}{1}.{2}", DealReconciliationStepBase.ScenarioOutputDirectory, diffDeltas.RemoveWindowsUnfriendlyChars(), CsvParserExtensionMethods.csv), false);
                    diffDeltaSummaryQuery.EnumerableToCsv(
                        String.Format("{0}{1}.{2}", DealReconciliationStepBase.ScenarioOutputDirectory, diffDeltaSummary.RemoveWindowsUnfriendlyChars(), CsvParserExtensionMethods.csv), false);
                    break;
                case ExportTypes.Console:
                    throw new NotImplementedException();
                case ExportTypes.Database:
                    throw new NotImplementedException();

                //case ExportTypes.Unknown:
                default:
                    throw new ArgumentException(exportMethod.ToString(CultureInfo.InvariantCulture));
            }
        }

        protected void AnalyseAndExportDiffDeltasByCombination(string exportMethod)
        {
            DeltaSumDecimals = new Dictionary<string, decimal>();
            foreach (var keyValuePair in DiffDeltaSummary)
            {
                var list = keyValuePair.Value;
                var sum = list.Sum(summary => summary.Delta);
                DeltaSumDecimals.Add(keyValuePair.Key, sum);
            }

            var sumQuery = (from d in DeltaSumDecimals
                            select new { Combination = d.Key, DeltaSum = d.Value }).OrderByDescending(x => x.DeltaSum);
            sumQuery.ExportEnumerableByMethod(exportMethod,
                new ExportParameters
                {
                    ExportType = (ExportTypes) Enum.Parse(typeof (ExportTypes), exportMethod,true),
                    FileNamePath = DealReconciliationStepBase.ScenarioOutputDirectory
                });
        }



        protected void AnalyseAndExportDiffDeltasByBook(string exportMethod)
        {
            var deltaSumByBook = new Dictionary<char, decimal>();
            //we've lost the query parameters, so we'll have to parse the names to get the book info etc.
            var bookQuery = DiffDeltaSummary.Keys.GroupBy(x => x.ToCharArray()[0]);
            foreach (IGrouping<char, string> bookGrouping in bookQuery)
            {
                foreach (KeyValuePair<string, List<DiffDeltaSummary>> keyValuePair in DiffDeltaSummary)
                {
                    if (keyValuePair.Key.ToCharArray()[0] == bookGrouping.Key)
                    {
                        var list = keyValuePair.Value;
                        var sum = list.Sum(summary => summary.Delta);
                        if (deltaSumByBook.ContainsKey(bookGrouping.Key))
                        {
                            deltaSumByBook[bookGrouping.Key] += sum;
                        }
                        else
                        {
                            deltaSumByBook[bookGrouping.Key] = sum;
                        }
                    }
                    
                }
            }

        }

        protected void ResetDataContext()
        {
            SignalsCompareDataSnapOnCcDataContext.Dispose();
            SignalsCompareDataSnapOnCcDataContext = new SignalsCompareDataSnapOnCc().SignalsCompareDataSnapOnCcDataContext;
        }

    }
}
