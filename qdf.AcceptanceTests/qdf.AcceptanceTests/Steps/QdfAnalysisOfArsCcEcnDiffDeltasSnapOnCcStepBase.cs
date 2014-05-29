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
        public const int DIFF_DELTA_SUMMARY_BOOK = 0;
        public const int DIFF_DELTA_SUMMARY_SYMBOL_START_INDEX = 1;
        public const int DIFF_DELTA_SUMMARY_SYMBOL_END_INDEX = 6;
        public const int DIFF_DELTA_SUMMARY_SERVER_START_INDEX = 7;

        public static readonly string FullName = typeof(QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcStepBase).FullName;
        protected SignalsCompareDataSnapOnCCDataContext SignalsCompareDataSnapOnCcDataContext { get; private set; }
        protected DiffDeltaParameters DiffDeltaParameters { get; set; }
        protected List<DiffDeltaParameters> DiffDeltaParameterList { get; set; }
        protected DiffDeltaFinder DiffDeltaFinder { get; private set; }
        public Dictionary<string, List<DiffDeltaResult>> DiffDeltaList { get; private set; }
        public Dictionary<string,List<DiffDeltaSummary>> DiffDeltaSummary { get; private set; }
        public Dictionary<string, decimal> DeltaSumDecimals { get; private set; }
        public Dictionary<char, decimal> DeltaSumByBook { get; private set; }
        public Dictionary<string, decimal> DeltaSumByServer { get; private set; }
        public Dictionary<string, decimal> DeltaSumBySymbol { get; private set; }


        public QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcStepBase(SignalsCompareDataSnapOnCc signalsCompareDataSnapOnCc, DiffDeltaFinder diffDeltaFinder)
        {
            DiffDeltaFinder = diffDeltaFinder;
            SignalsCompareDataSnapOnCcDataContext = signalsCompareDataSnapOnCc.SignalsCompareDataSnapOnCcDataContext;
            DiffDeltaList = new Dictionary<string, List<DiffDeltaResult>>();
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
            sumQuery.ExportEnumerableByMethod(
                new ExportParameters
                {
                    ExportType = (ExportTypes) Enum.Parse(typeof (ExportTypes), exportMethod,true),
                    Path = DealReconciliationStepBase.ScenarioOutputDirectory,
                    FileName = "DiffDeltasByCombination"
                });
        }

        protected void AnalyseAndExportDiffDeltasByBook(string exportMethod)
        {
            DeltaSumByBook = new Dictionary<char, decimal>();
            //we've lost the query parameters, so we'll have to parse the names to get the book info etc.
            //TODO:- store query parameters in DiffDeltaSummary as well
            var bookQuery = DiffDeltaSummary.Keys.GroupBy(x => x.ToCharArray()[DIFF_DELTA_SUMMARY_BOOK]);
            foreach (IGrouping<char, string> bookGrouping in bookQuery)
            {
                foreach (KeyValuePair<string, List<DiffDeltaSummary>> keyValuePair in DiffDeltaSummary)
                {
                    if (keyValuePair.Key.ToCharArray()[DIFF_DELTA_SUMMARY_BOOK] == bookGrouping.Key)
                    {
                        var list = keyValuePair.Value;
                        var sum = list.Sum(summary => summary.Delta);
                        if (DeltaSumByBook.ContainsKey(bookGrouping.Key))
                        {
                            DeltaSumByBook[bookGrouping.Key] += sum;
                        }
                        else
                        {
                            DeltaSumByBook[bookGrouping.Key] = sum;
                        }
                    }
                }
            }
            var bookAnalysisQuery = (from d in DeltaSumByBook
                select new {Book = d.Key, DeltaSum = d.Value}).OrderByDescending(x => x.DeltaSum);
            bookAnalysisQuery.ExportEnumerableByMethod(
                new ExportParameters
                {
                    ExportType = (ExportTypes)Enum.Parse(typeof(ExportTypes), exportMethod, true),
                    Path = DealReconciliationStepBase.ScenarioOutputDirectory,
                    FileName = "DiffDeltasByBook"
                });
        }

        protected void AnalyseAndExportDiffDeltasByServer(string exportMethod)
        {
            DeltaSumByServer = new Dictionary<string, decimal>();
            var serverQuery = DiffDeltaSummary.Keys.GroupBy(x => x.Replace("DiffDeltaSummary.csv", "").Replace("/", "").Substring(DIFF_DELTA_SUMMARY_SERVER_START_INDEX));
            foreach (IGrouping<string, string> grouping in serverQuery)
            {
                foreach (KeyValuePair<string, List<DiffDeltaSummary>> keyValuePair in DiffDeltaSummary)
                {
                    if (keyValuePair.Key.Substring(DIFF_DELTA_SUMMARY_SERVER_START_INDEX).Replace("DiffDeltaSummary.csv", "").Replace("/", "") == grouping.Key)
                    {
                        var list = keyValuePair.Value;
                        var sum = list.Sum(summary => summary.Delta);
                        if (DeltaSumByServer.ContainsKey(grouping.Key))
                        {
                            DeltaSumByServer[grouping.Key] += sum;
                        }
                        else
                        {
                            DeltaSumByServer[grouping.Key] = sum;
                        }
                    }
                }
            }
            var serverAnalysisQuery = (from d in DeltaSumByServer
                                     select new { Server = d.Key, DeltaSum = d.Value }).OrderByDescending(x => x.DeltaSum);
            serverAnalysisQuery.ExportEnumerableByMethod(
                new ExportParameters
                {
                    ExportType = (ExportTypes)Enum.Parse(typeof(ExportTypes), exportMethod, true),
                    Path = DealReconciliationStepBase.ScenarioOutputDirectory,
                    FileName = "DiffDeltasByServer"
                });
        }

        protected void AnalyseAndExportDiffDeltasBySymbol(string exportMethod)
        {
            DeltaSumBySymbol = new Dictionary<string, decimal>();
            var symbolQuery = DiffDeltaSummary.Keys.GroupBy(x => x.Replace("DiffDeltaSummary.csv","").Replace("/","").Substring(DIFF_DELTA_SUMMARY_SYMBOL_START_INDEX,DIFF_DELTA_SUMMARY_SYMBOL_END_INDEX));
            foreach (IGrouping<string, string> grouping in symbolQuery)
            {
                foreach (KeyValuePair<string, List<DiffDeltaSummary>> keyValuePair in DiffDeltaSummary)
                {
                    if (keyValuePair.Key.Substring(DIFF_DELTA_SUMMARY_SYMBOL_START_INDEX,DIFF_DELTA_SUMMARY_SYMBOL_END_INDEX) == grouping.Key )
                    {
                        var list = keyValuePair.Value;
                        var sum = list.Sum(summary => summary.Delta);
                        if (DeltaSumBySymbol.ContainsKey(grouping.Key))
                        {
                            DeltaSumBySymbol[grouping.Key] += sum;
                        }
                        else
                        {
                            DeltaSumBySymbol[grouping.Key] = sum;
                        }
                    }
                }
            }
            var symbolAnalysisQuery = (from d in DeltaSumBySymbol
                                       select new { Server = d.Key, DeltaSum = d.Value }).OrderByDescending(x => x.DeltaSum);
            symbolAnalysisQuery.ExportEnumerableByMethod(
                new ExportParameters
                {
                    ExportType = (ExportTypes)Enum.Parse(typeof(ExportTypes), exportMethod, true),
                    Path = DealReconciliationStepBase.ScenarioOutputDirectory,
                    FileName = "DiffDeltasBySymbol"
                });
        }

        public void AnalyzeAndExportUnknowns(string exportMethod)
        {
            var unknownsQuery = GetActualUnknowns().Select(x => new {Combination = x});
            unknownsQuery.ExportEnumerableByMethod(
                new ExportParameters
                {
                    ExportType = (ExportTypes)Enum.Parse(typeof(ExportTypes), exportMethod, true),
                    Path = DealReconciliationStepBase.ScenarioOutputDirectory,
                    FileName = "DiffDeltasUnknown"
                });
        }

        public List<string> GetActualUnknowns()
        {
            //TODO:- improve by using the Any() method on each list
            var actualUnknowns = (from KeyValuePair<string, List<DiffDeltaResult>> list in DiffDeltaList
                                  from DiffDeltaResult diff in list.Value
                                  where diff.HiSource == "Unknown"
                                  select list.Key).Distinct().ToList();
            return actualUnknowns;
        }

        protected void ResetDataContext()
        {
            SignalsCompareDataSnapOnCcDataContext.Dispose();
            SignalsCompareDataSnapOnCcDataContext = new SignalsCompareDataSnapOnCc().SignalsCompareDataSnapOnCcDataContext;
        }

    }
}
