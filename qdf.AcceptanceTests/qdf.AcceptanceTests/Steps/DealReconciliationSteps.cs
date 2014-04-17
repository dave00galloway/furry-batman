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
using qdf.AcceptanceTests.TypedDataTables;

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
            //TODO: implement for multiple qdfDealParameters 
            //if (qdfDealParametersSet != null) etc.

            CCToolData ccToolData = contextSubstitute.SelectDataAsDataTable(MySqlQueries.CCToolQuery(qdfDealParameters.convertedStartTime, qdfDealParameters.convertedEndTime)).ConvertToTypedDataTable <CCToolData>();
            //get server and spread combos as a demo
            CCToolDataContext.OutputCalculatedSpread(ccToolData);
            /*undecided whether to use properties for this data. 
             * with the QDF data, there always willbe some, 
             * but for the ars/cnx/ecn data there might or might not be 
             * maybe the base class should hold properties for QDF, and specialised subclasses should hold properties for comparing with the QDF data
             * */
            ScenarioContext.Current["ccToolData"] = ccToolData;
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
