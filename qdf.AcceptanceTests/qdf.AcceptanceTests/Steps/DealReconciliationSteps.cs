using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using Alpari.QDF.Domain;
// using Alpari.QualityAssurance.SpecFlowExtensions.Context;
using Alpari.QualityAssurance.SpecFlowExtensions.DataContexts;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
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

        private RedisConnectionHelper RedisConnectionHelper { get; set; }
        private IDataContextSubstitute ContextSubstitute { get; set; }
        private QdfDealParameters QdfDealParameters { get; set; }
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
            RedisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings["redisHost"]);
            SetupQdfDealQuery(qdfDealParameters);
            RedisConnectionHelper.GetDealData(qdfDealParameters);
            //added a try catch here to cope with changes in QDF Deal format
            try
            {
                RedisConnectionHelper.OutputAllDeals(ScenarioOutputDirectory +
                                                     "AllQdfDeals.csv");
            }
            catch (Exception e)
            {
                e.ConsoleExceptionLogger();
            }
            //redisConnectionHelper.FilterDeals(qdfDealParameters);

            QdfDealParameters = qdfDealParameters;
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
            ContextSubstitute = GetDataContextSubstituteForDb(CcToolDataContext.Cc);
            //TODO: implement for multiple qdfDealParameters 
            //if (qdfDealParametersSet != null) etc.

            var ccToolData =
                ContextSubstitute.SelectDataAsDataTable(CcToolDataContext.CcToolQuery(QdfDealParameters.ConvertedStartTime,
                    QdfDealParameters.ConvertedEndTime), MySqlQueryTimeout).ConvertToTypedDataTable<CcToolDataTable>();
            ccToolData.ExportData(ExportTypes.Csv, new[] {string.Format("{0}CcToolData.csv", FeatureOutputDirectory)});

            //get server and spread combos as a demo
            //CCToolDataContext.OutputCalculatedSpread(ccToolData);
            /*undecided whether to use properties for this data. 
             * with the QDF data, there always willbe some, 
             * but for the ars/cnx/ecn data there might or might not be 
             * maybe the base class should hold properties for QDF, and specialised subclasses should hold properties for comparing with the QDF data
             * */
            ScenarioContext.Current["CcToolDataTable"] = ccToolData;
        }

        [Given(@"I have loaded QDF deal data from ""(.*)""")]
        public void GivenIHaveLoadedQdfDealDataFrom(string fileNamePath)
        {
            ScenarioContext.Current["QDFDealData"] = fileNamePath.CsvToList<Deal>(",", new[] {"Data"});
            ((IEnumerable<Deal>)ScenarioContext.Current["QDFDealData"]).EnumerableToCsv(FeatureOutputDirectory +
                                                                                         "AllQdfDeals.csv", true, true);
        }

        [Given(@"I have already loaded QDF deal data from ""(.*)""")]
        public void GivenIHaveAlreadyLoadedQdfDealDataFrom(string fileNamePath)
        {
            if (FeatureContext.Current.ContainsKey("QDFDealData"))
            {
                ScenarioContext.Current["QDFDealData"] = FeatureContext.Current["QDFDealData"];
            }
            else
            {
                GivenIHaveLoadedQdfDealDataFrom(fileNamePath);
                FeatureContext.Current["QDFDealData"] = ScenarioContext.Current["QDFDealData"];
            }
        }

        [Given(@"I have loaded CCTool data from ""(.*)""")]
        public void GivenIHaveLoadedCcToolDataFrom(string fileNamePath)
        {
            CcToolDataTable ccToolData =
                new CcToolDataTable().ConvertIEnumerableToDataTable(fileNamePath.CsvToList<CcToolData>(","),
                    "CcToolDataTable", new[] { "Section", "ServerName", "SymbolCode", "IsBookA", "UpdateDateTime" });
            ScenarioContext.Current["CcToolDataTable"] = ccToolData;
            ccToolData.ExportData(ExportTypes.Csv, new[] { string.Format("{0}CcToolData.csv", FeatureOutputDirectory) });
        }

        [Given(@"I have already loaded CCTool data from ""(.*)""")]
        public void GivenIHaveAlreadyLoadedCcToolDataFrom(string fileNamePath)
        {
            if (FeatureContext.Current.ContainsKey("CcToolDataTable"))
            {
                ScenarioContext.Current["CcToolDataTable"] = FeatureContext.Current["CcToolDataTable"];
            }
            else
            {
                GivenIHaveLoadedCcToolDataFrom(fileNamePath);
                FeatureContext.Current["CcToolDataTable"] = ScenarioContext.Current["CcToolDataTable"];
            }
        }

        [Given(@"I have daily ccTool snapshot data from ""(.*)"" to ""(.*)""")]
        public void GivenIHaveDailyCcToolSnapshotDataFromTo(string startDate, string endDate)
        {
            ContextSubstitute = GetDataContextSubstituteForDb(CcToolDataContext.Cc);
            if (FeatureContext.Current.ContainsKey("CcToolDataTableDailySnapshots"))
            {
                ScenarioContext.Current["CcToolDataTableDailySnapshots"] = FeatureContext.Current["CcToolDataTableDailySnapshots"];
            }
            else
            {
                ScenarioContext.Current["CcToolDataTableDailySnapshots"] = GetDailySnapshotDataFromDateRange(startDate,
                    endDate, ContextSubstitute);
                FeatureContext.Current["CcToolDataTableDailySnapshots"] = ScenarioContext.Current["CcToolDataTableDailySnapshots"];
            }
        }

        [Given(@"I have already aggregated the QdfDeal Data and CcToolData")]
        public void GivenIHaveAlreadyAggregatedTheQdfDealDataAndCcToolData()
        {
            if (!FeatureContext.Current.ContainsKey("QdfccDataReconciliation"))
            {
                var aggregator = new QdfccDataReconciliation(ScenarioContext.Current["CcToolDataTable"] as CcToolDataTable,
                    ScenarioContext.Current["QDFDealData"] as List<Deal>, FeatureOutputDirectory);
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
            var aggregator = new QdfccDataReconciliation(ScenarioContext.Current["CcToolDataTable"] as CcToolDataTable,
                RedisConnectionHelper.RetrievedDeals, ScenarioOutputDirectory);
            aggregator.AggregateQdfDeals();
            aggregator.AggregateCcToolData();
        }

        [When(@"I compare the loaded QDF and CC data")]
        public void WhenICompareTheLoadedQdfAndCcData()
        {
            var aggregator = new QdfccDataReconciliation(ScenarioContext.Current["CcToolDataTable"] as CcToolDataTable,
                ScenarioContext.Current["QDFDealData"] as List<Deal>, ScenarioOutputDirectory);
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
            (ScenarioContext.Current["QDFDealData"] as List<Deal>).Should().HaveCount(qdfDealCount);
            ((CcToolDataTable) ScenarioContext.Current["CcToolDataTable"]).Rows.Should().HaveCount(ccToolDataCount);

        }


        [AfterScenario]
        public void Teardown()
        {
            if (RedisConnectionHelper != null)
            {
                //try
                //{
                //removed try/catch as might as well see full stack trace - this is likely to be the last operation
                RedisConnectionHelper.Connection.Close(true);
                //}
                //catch (Exception e)
                //{
                //    Console.WriteLine(e.Message);
                //}
            }
        }
    }
}