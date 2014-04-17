using qdf.AcceptanceTests.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Data;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Alpari.QualityAssurance.SpecFlowExtensions;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using qdf.AcceptanceTests.DataContexts;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class DealReconciliationSteps : DealReconciliationStepBase
    {
        public RedisConnectionHelper redisConnectionHelper { get; private set; }
        public IDataContextSubstitute contextSubstitute { get; private set; }
        public QdfDealParameters qdfDealParameters { get; private set; }
        public IEnumerable<QdfDealParameters> qdfDealParametersSet { get; private set; }

        /// <summary>
        /// Clear the test output directory for the feature
        /// to limit this set the tag to 
        /// //[BeforeFeature("CreateOutput")]
        /// and apply tags to features
        /// </summary>
        [BeforeFeature]
        public static void BeforeFeature()
        {
            FeatureContext.Current["FeatureOutputDirectory"] = ConfigurationManager.AppSettings["reportRoot"] + FeatureContext.Current.FeatureInfo.Title.Replace(" ", "") + @"\";
            ((string)FeatureContext.Current["FeatureOutputDirectory"]).ClearOutputDirectory();
        }

        /// <summary>
        /// Clear the test output directory for the feature
        /// to limit this set the tag to 
        /// //[BeforeScenario("CreateOutput")]
        /// and apply tags to features
        /// </summary>
        [BeforeScenario]
        public static void BeforeScenario()
        {
            ScenarioContext.Current["ScenarioOutputDirectory"] = (string)FeatureContext.Current["FeatureOutputDirectory"] + ScenarioContext.Current.ScenarioInfo.Title.Replace(" ", "") + @"\";
            ((string)ScenarioContext.Current["ScenarioOutputDirectory"]).ClearOutputDirectory();
        }

        [Given(@"I have QDF Data")]
        public void GivenIHaveQDFData()
        {
            //ScenarioContext.Current.Pending();
            redisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings["redisHost"]);
            throw new NotImplementedException();
        }

        [Given(@"I have QDF Deal Data")]
        public void GivenIHaveQDFDealData(QdfDealParameters qdfDealParameters)
        {
            redisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings["redisHost"]);
            SetupQdfDealQuery(qdfDealParameters);
            redisConnectionHelper.GetDealData(qdfDealParameters);
            redisConnectionHelper.OutputAllDeals((string)ScenarioContext.Current["ScenarioOutputDirectory"] + "AllDeals.csv");
            //redisConnectionHelper.FilterDeals(qdfDealParameters);

            this.qdfDealParameters = qdfDealParameters;
        }

        [Given(@"I have QDF Deal Data for these parameter sets:")]
        public void GivenIHaveQDFDealDataForTheseParameterSets(IEnumerable<QdfDealParameters> qdfDealParameters)
        {
            redisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings["redisHost"]);
            foreach (QdfDealParameters entry in qdfDealParameters)
            {
                SetupQdfDealQuery(entry);
                redisConnectionHelper.GetDealData(entry);
            }
            this.qdfDealParametersSet = qdfDealParameters;
            throw new NotImplementedException();
        }

        /// <summary>
        /// possibly need to rename this to make it clear its a connection to a substitute data context
        /// </summary>
        /// <param name="dataContext"></param>
        [Given(@"I have created a connection to ""(.*)""")]
        public void GivenIHaveCreatedAConnectionTo(string dataContext)
        {
            contextSubstitute = GetDataContextSubstitute(dataContext);
        }

        [Given(@"I have CC data")]
        public void GivenIHaveCCData()
        {
            contextSubstitute = GetDataContextSubstituteForDB(MySqlDataContextSubstitute.CC);
            var ccEntries = contextSubstitute.SelectDataAsDataTable(MySqlQueries.CCToolQuery(qdfDealParameters.convertedStartTime, qdfDealParameters.convertedEndTime));
            var ccEntrySet = contextSubstitute.SelectDataAsDataSet(MySqlQueries.CCToolQuery(qdfDealParameters.convertedStartTime, qdfDealParameters.convertedEndTime));
            var ccEntryView = contextSubstitute.SelectDataAsDataView(MySqlQueries.CCToolQuery(qdfDealParameters.convertedStartTime, qdfDealParameters.convertedEndTime));
            //TODO: decide whether to use datatable or data set
            //TODO: implement for multiple qdfDealParameters 
            //if (qdfDealParametersSet != null) etc.

            var tableResult = from DataRow myRow in ccEntries.Rows
                              where myRow.Field<string>("DatabaseName").StartsWith("ars_")
                              select new
                              {
                                  Server = myRow.Field<string>("DatabaseName"),
                                  Spread = (myRow.Field<decimal>("BidPrice") - myRow.Field<decimal>("AskPrice"))
                              };

            foreach (var item in tableResult)
            {
                Console.WriteLine(string.Format("using table, Server Name is {0}, spread is {1}", item.Server, item.Spread.ToString()));
            }

            //foreach (var item in ccEntries.AsDataView())
            //{
            //    item.
            //}

            //foreach (var item in ccEntrySet)
            //{

            //}

            //foreach (var item in ccEntryView)
            //{
            //    Console.WriteLine("using view, Server Name is {0}",item.
            //}
        }

        [When(@"I compare QDF and CC data")]
        public void WhenICompareQDFAndCCData()
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"the data should match")]
        public void ThenTheDataShouldMatch()
        {
            ScenarioContext.Current.Pending();
        }

        [AfterScenario]
        public void Teardown()
        {
            if (redisConnectionHelper != null)
            {
                //try
                //{
                //removed try/catch as might as well see full stack trace - this is likely to be the last operation
                redisConnectionHelper.connection.Close(true);
                //}
                //catch (Exception e)
                //{
                //    Console.WriteLine(e.Message);
                //}
            }
        }
    }
}
