using qdf.AcceptanceTests.Helpers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;
using Alpari.QualityAssurance.SpecFlowExtensions;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class DealReconciliationSteps : DealReconciliationStepBase
    {
        public RedisConnectionHelper redisConnectionHelper { get; private set; }

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

            throw new NotImplementedException();
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

            throw new NotImplementedException();
        }


        [Given(@"I have CC data")]
        public void GivenIHaveCCData()
        {
            ScenarioContext.Current.Pending();
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
