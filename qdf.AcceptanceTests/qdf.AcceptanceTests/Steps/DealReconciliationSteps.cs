using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class DealReconciliationSteps
    {
        // For additional details on SpecFlow step definitions see http://go.specflow.org/doc-stepdef

        [Given(@"I have QDF Data")]
        public void GivenIHaveQDFData()
        {
            //ScenarioContext.Current.Pending();
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

    }
}
