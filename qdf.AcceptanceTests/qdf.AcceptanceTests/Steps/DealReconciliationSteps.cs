using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
        public RedisConnectionHelper RedisConnectionHelper { get; private set; }
        public IDataContextSubstitute ContextSubstitute { get; private set; }
        public QdfDealParameters QdfDealParameters { get; private set; }
        public IEnumerable<QdfDealParameters> QdfDealParametersSet { get; private set; }

        /// <summary>
        ///     Clear the test output directory for the feature
        ///     to limit this set the tag to
        ///     //[BeforeFeature("CreateOutput")]
        ///     and apply tags to features
        /// </summary>
        [BeforeFeature]
        public static void BeforeFeature()
        {
            FeatureContext.Current["FeatureOutputDirectory"] = ConfigurationManager.AppSettings["reportRoot"] +
                                                               FeatureContext.Current.FeatureInfo.Title.Replace(" ", "") +
                                                               @"\";
            ((string) FeatureContext.Current["FeatureOutputDirectory"]).ClearOutputDirectory();
        }

        /// <summary>
        ///     Clear the test output directory for the feature
        ///     to limit this set the tag to
        ///     //[BeforeScenario("CreateOutput")]
        ///     and apply tags to features
        /// </summary>
        [BeforeScenario]
        public static void BeforeScenario()
        {
            ScenarioContext.Current["ScenarioOutputDirectory"] =
                (string) FeatureContext.Current["FeatureOutputDirectory"] +
                ScenarioContext.Current.ScenarioInfo.Title.Replace(" ", "") + @"\";
            ((string) ScenarioContext.Current["ScenarioOutputDirectory"]).ClearOutputDirectory();
        }

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
                RedisConnectionHelper.OutputAllDeals((string) ScenarioContext.Current["ScenarioOutputDirectory"] +
                                                     "AllDeals.csv");
            }
            catch (Exception e)
            {
                ConsoleLogger.ConsoleExceptionLogger(e);
            }
            //redisConnectionHelper.FilterDeals(qdfDealParameters);

            QdfDealParameters = qdfDealParameters;
        }

        [Given(@"I have QDF Deal Data for these parameter sets:")]
        public void GivenIHaveQdfDealDataForTheseParameterSets(IEnumerable<QdfDealParameters> qdfDealParameters)
        {
            RedisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings["redisHost"]);
            foreach (QdfDealParameters entry in qdfDealParameters)
            {
                SetupQdfDealQuery(entry);
                RedisConnectionHelper.GetDealData(entry);
            }
            QdfDealParametersSet = qdfDealParameters;
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
                ContextSubstitute.SelectDataAsDataTable(MySqlQueries.CcToolQuery(QdfDealParameters.ConvertedStartTime,
                    QdfDealParameters.ConvertedEndTime)).ConvertToTypedDataTable<CcToolData>();
            //get server and spread combos as a demo
            //CCToolDataContext.OutputCalculatedSpread(ccToolData);
            /*undecided whether to use properties for this data. 
             * with the QDF data, there always willbe some, 
             * but for the ars/cnx/ecn data there might or might not be 
             * maybe the base class should hold properties for QDF, and specialised subclasses should hold properties for comparing with the QDF data
             * */
            ScenarioContext.Current["ccToolData"] = ccToolData;
        }

        [When(@"I retrieve cc_tbl_position_section data from cc")]
        public void WhenIRetrieveCc_Tbl_Position_SectionDataFromCc()
        {
            //contextSubstitute = GetDataContextSubstituteForDB(MySqlDataContextSubstitute.CC);
            DataTable data = ContextSubstitute.SelectDataAsDataTable(MySqlQueries.cc_tbl_position_section());
            ScenarioContext.Current["cc_tbl_position_section"] = data;
        }


        [When(@"I compare QDF and CC data")]
        public void WhenICompareQdfAndCcData()
        {
            var aggregator = new QdfccDataReconciliation(ScenarioContext.Current["ccToolData"] as CcToolData,
                RedisConnectionHelper.RetrievedDeals);
            aggregator.AggregateQdfDeals();
            aggregator.AggregateCcToolData();
            ScenarioContext.Current.Pending();
        }

        [Then(@"the data should match")]
        public void ThenTheDataShouldMatch()
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"the cc_tbl_position_section data from cc has (.*) records")]
        public void ThenTheCc_Tbl_Position_SectionDataFromCcHasRecords(int expectedCount)
        {
            var data = (DataTable) ScenarioContext.Current["cc_tbl_position_section"];
            data.Rows.Should().HaveCount(expectedCount);
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