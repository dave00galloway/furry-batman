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

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class DealReconciliationSteps : DealReconciliationStepBase
    {
        public RedisConnectionHelper redisConnectionHelper { get; private set; }

        [Given(@"I have QDF Data")]
        public void GivenIHaveQDFData()
        {
            //ScenarioContext.Current.Pending();
            redisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings["redisHost"]);
            throw new NotImplementedException();
        }

        [Given(@"I have QDF Deal Data")]
        public void GivenIHaveQDFDealData(IEnumerable<QdfDealParameters> QdfDealParameters)
        {
            redisConnectionHelper = new RedisConnectionHelper(ConfigurationManager.AppSettings["redisHost"]);
            foreach (QdfDealParameters entry in QdfDealParameters)
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
