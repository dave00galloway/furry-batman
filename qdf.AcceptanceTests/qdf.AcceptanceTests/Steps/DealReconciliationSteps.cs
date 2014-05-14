using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using Alpari.QDF.Domain;
// using Alpari.QualityAssurance.SpecFlowExtensions.Context;
//using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
//using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using qdf.AcceptanceTests.DataContexts;
using qdf.AcceptanceTests.Helpers;
using qdf.AcceptanceTests.TypedDataTables;
using TechTalk.SpecFlow;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class DealReconciliationSteps : DealReconciliationStepBase
    {
        public new static readonly string FullName = typeof (DealReconciliationSteps).FullName;

        //private IEnumerable<QdfDealParameters> QdfDealParametersSet { get; set; }

        [Given(@"I have QDF Data")]
        public void GivenIHaveQdfData()
        {
            //ScenarioContext.Current.Pending();
            RedisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings["redisHost"]);
            throw new NotImplementedException();
        }

        [Given(@"I have QDF Deal Data")]
        public void GivenIHaveQdfDealData(QdfDealParameters qdfDealParameters)
        {
            LoadQdfDealsForParameters(qdfDealParameters);
            OutputQdfDeals(ScenarioOutputDirectory);
        }

        [Given(@"I have already loaded QDF deal data")]
        public void GivenIHaveAlreadyLoadedQdfDealData(QdfDealParameters qdfDealParameters)
        {
            if (!FeatureContext.Current.ContainsKey(QDF_DEAL_DATA))
            {
                LoadQdfDealsForParameters(qdfDealParameters);
                OutputQdfDeals(FeatureOutputDirectory);
                FeatureContext.Current[QDF_DEAL_DATA] = RedisConnectionHelper.RetrievedDeals;
            }
        }

        [Given(@"I have already loaded CCTool data")]
        public void GivenIHaveAlreadyLoadedCcToolData()
        {
            if (!FeatureContext.Current.ContainsKey(CC_TOOL_DATA_TABLE))
            {
                var ccToolData = LoadCcToolDailySnapshotData(QdfDealParameters.ConvertedStartTime, QdfDealParameters.ConvertedEndTime);
                OutputCcToolData(ccToolData, FeatureOutputDirectory);
                FeatureContext.Current[CC_TOOL_DATA_TABLE] = ccToolData;
            }
        }

        [Given(@"I have QDF Deal Data for these parameter sets:")]
        public void GivenIHaveQdfDealDataForTheseParameterSets(IEnumerable<QdfDealParameters> qdfDealParameters)
        {
            RedisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings["redisHost"]);
            QdfDealParameters[] qdfDealParametersSet = qdfDealParameters as QdfDealParameters[] ??
                                                       qdfDealParameters.ToArray();
            foreach (QdfDealParameters entry in qdfDealParametersSet)
            {
                SetupQdfDealQuery(entry);
                RedisConnectionHelper.GetDealData(entry);
            }
            //QdfDealParametersSet = qdfDealParametersSet;
            throw new NotImplementedException();
        }

        /// <summary>
        ///     possibly need to rename this to make it clear its a connection to a substitute data context
        /// </summary>
        /// <param name="dataContext"></param>
        [Given(@"I have created a connection to ""(.*)""")]
        public void GivenIHaveCreatedAConnectionTo(string dataContext)
        {
            ContextSubstitute = GetDataContextSubstitute(dataContext);
        }

        [Given(@"I have CC data")]
        public void GivenIHaveCcData()
        {
            var ccToolData = LoadCcToolDataForParameters();
            OutputCcToolData(ccToolData,ScenarioOutputDirectory);
        }

        [Given(@"I have loaded QDF deal data from ""(.*)""")]
        public void GivenIHaveLoadedQdfDealDataFrom(string fileNamePath)
        {
            ScenarioContext.Current[QDF_DEAL_DATA] = fileNamePath.CsvToList<Deal>(",", new[] {"Data"});
            ((IEnumerable<Deal>)ScenarioContext.Current[QDF_DEAL_DATA]).EnumerableToCsv(FeatureOutputDirectory +
                                                                                         ALL_QDF_DEALS_CSV, true, true);
        }

        [Given(@"I have already loaded QDF deal data from ""(.*)""")]
        public void GivenIHaveAlreadyLoadedQdfDealDataFrom(string fileNamePath)
        {
            if (FeatureContext.Current.ContainsKey(QDF_DEAL_DATA))
            {
                ScenarioContext.Current[QDF_DEAL_DATA] = FeatureContext.Current[QDF_DEAL_DATA];
            }
            else
            {
                GivenIHaveLoadedQdfDealDataFrom(fileNamePath);
                FeatureContext.Current[QDF_DEAL_DATA] = ScenarioContext.Current[QDF_DEAL_DATA];
            }
        }

        [Given(@"I have loaded CCTool data from ""(.*)""")]
        public void GivenIHaveLoadedCcToolDataFrom(string fileNamePath)
        {
            CcToolDataTable ccToolData =
                new CcToolDataTable().ConvertIEnumerableToDataTable(fileNamePath.CsvToList<CcToolData>(","),
                    CC_TOOL_DATA_TABLE, new[] { "Section", "ServerName", "SymbolCode", "IsBookA", "UpdateDateTime" });
            ScenarioContext.Current[CC_TOOL_DATA_TABLE] = ccToolData;
            ccToolData.ExportData(ExportTypes.Csv, new[] { string.Format("{0}{1}", FeatureOutputDirectory,CCTOOL_DATA_CSV) });
        }

        [Given(@"I have already loaded CCTool data from ""(.*)""")]
        public void GivenIHaveAlreadyLoadedCcToolDataFrom(string fileNamePath)
        {
            if (FeatureContext.Current.ContainsKey(CC_TOOL_DATA_TABLE))
            {
                ScenarioContext.Current[CC_TOOL_DATA_TABLE] = FeatureContext.Current[CC_TOOL_DATA_TABLE];
            }
            else
            {
                GivenIHaveLoadedCcToolDataFrom(fileNamePath);
                FeatureContext.Current[CC_TOOL_DATA_TABLE] = ScenarioContext.Current[CC_TOOL_DATA_TABLE];
            }
        }

        [Given(@"I have daily ccTool snapshot data from ""(.*)"" to ""(.*)""")]
        public void GivenIHaveDailyCcToolSnapshotDataFromTo(string startDate, string endDate)
        {
            var ccToolData = LoadCcToolDailySnapshotData(startDate, endDate);
            OutputCcToolDataIfNew(ccToolData);
        }

        [Given(@"I have already aggregated the QdfDeal Data and CcToolData by day")]
        public void GivenIHaveAlreadyAggregatedTheQdfDealDataAndCcToolDataByDay()
        {
            if (!FeatureContext.Current.ContainsKey("QdfccDataReconciliation"))
            {
                var aggregator = new QdfccDataReconciliation(ScenarioContext.Current[CC_TOOL_DATA_TABLE] as CcToolDataTable,
                    ScenarioContext.Current[QDF_DEAL_DATA] as List<Deal>, FeatureOutputDirectory);
                aggregator.AggregateQdfDealsByDay();
                aggregator.AggregateCcToolData();
                FeatureContext.Current["QdfccDataReconciliation"] = aggregator;
            }
        }

        [Given(@"I have already aggregated the QdfDeal Data and CcToolData")]
        public void GivenIHaveAlreadyAggregatedTheQdfDealDataAndCcToolData()
        {
            if (!FeatureContext.Current.ContainsKey("QdfccDataReconciliation"))
            {
                var aggregator = new QdfccDataReconciliation(ScenarioContext.Current[CC_TOOL_DATA_TABLE] as CcToolDataTable,
                    ScenarioContext.Current[QDF_DEAL_DATA] as List<Deal>, FeatureOutputDirectory);
                aggregator.AggregateQdfDeals();
                aggregator.AggregateCcToolData();
                FeatureContext.Current["QdfccDataReconciliation"] = aggregator;
            }
        }
        
        [When(@"I retrieve cc_tbl_position_section data from cc")]
        public void WhenIRetrieveCc_Tbl_Position_SectionDataFromCc()
        {
            DataTable data = ContextSubstitute.SelectDataAsDataTable(CcToolDataContext.cc_tbl_position_section(), MySqlQueryTimeout);
            ScenarioContext.Current["cc_tbl_position_section"] = data;
        }


        [When(@"I compare QDF and CC data")]
        public void WhenICompareQdfAndCcData()
        {
            var aggregator = new QdfccDataReconciliation(ScenarioContext.Current[CC_TOOL_DATA_TABLE] as CcToolDataTable,
                RedisConnectionHelper.RetrievedDeals, ScenarioOutputDirectory);
            aggregator.AggregateQdfDeals();
            aggregator.AggregateCcToolData();
        }

        [When(@"I compare the loaded QDF and CC data")]
        public void WhenICompareTheLoadedQdfAndCcData()
        {
            var aggregator = new QdfccDataReconciliation(ScenarioContext.Current[CC_TOOL_DATA_TABLE] as CcToolDataTable,
                ScenarioContext.Current[QDF_DEAL_DATA] as List<Deal>, ScenarioOutputDirectory);
            aggregator.AggregateQdfDeals();
            aggregator.AggregateCcToolData();
            var keys = new[] {"PositionName", "Book", "Instrument", "ServerId", "TimeStamp"};
            CcToolPositionDataTable ccToolPositionDataTable =
                new CcToolPositionDataTable().ConvertIEnumerableToDataTable(
                    aggregator.CcToolPositions.Where(x => x.ServerId != TradingServer.Unknown.ToString()),
                    "CcToolPositions",
                    keys);

            QdfPositionDataTable qdfPositionDataTable =
                new QdfPositionDataTable().ConvertIEnumerableToDataTable(aggregator.QdfDealPositions,
                    "QdfPositionDataTable", keys);
            var colsToExclude = new[] {"CcPositionCount", "Positions", "Position"};
            DataTableComparison diffs = ccToolPositionDataTable.Compare(qdfPositionDataTable, colsToExclude);
            ScenarioContext.Current["diffs"] = diffs;
        }


        [Then(@"the data should match")]
        public void ThenTheDataShouldMatch()
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            diffs.CheckForDifferences().Should().BeNullOrWhiteSpace();
        }

        [Then(@"the data should not match")]
        public void ThenTheDataShouldNotMatch()
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            diffs.CheckForDifferences().Should().NotBeNullOrWhiteSpace();
        }


        [Then(@"the cc_tbl_position_section data from cc has (.*) records")]
        public void ThenTheCc_Tbl_Position_SectionDataFromCcHasRecords(int expectedCount)
        {
            var data = (DataTable) ScenarioContext.Current["cc_tbl_position_section"];
            data.Rows.Should().HaveCount(expectedCount);
        }

        [Then(@"there are (.*) deals in AllQdfDeals and (.*) records in CcToolData")]
        public void ThenThereAreDealsInAllQdfDealsAndRecordsInCcToolData(int qdfDealCount, int ccToolDataCount)
        {
            (ScenarioContext.Current[QDF_DEAL_DATA] as List<Deal>).Should().HaveCount(qdfDealCount);
            ((CcToolDataTable) ScenarioContext.Current[CC_TOOL_DATA_TABLE]).Rows.Should().HaveCount(ccToolDataCount);

        }
    }
}