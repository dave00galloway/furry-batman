using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QdfQuoteQuerySteps : QdfQuoteQueryStepBase
    {
        public new static readonly string FullName = typeof(QdfQuoteQuerySteps).FullName;

        [Given(@"I have the following search criteria for qdf quotes")]
        public void GivenIHaveTheFollowingSearchCriteriaForQdfQuotes(Table table)
        {
            ScenarioContext.Current.Pending();
        }

        [When(@"I retrieve the qdf quote data")]
        public void WhenIRetrieveTheQdfQuoteData()
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"no retrieved quote will have a timestamp outside ""(.*)"" to ""(.*)""")]
        public void ThenNoRetrievedQuoteWillHaveATimestampOutsideTo(string p0, string p1)
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"the count of retrieved deals quotes be (.*)")]
        public void ThenTheCountOfRetrievedDealsQuotesBe(int p0)
        {
            ScenarioContext.Current.Pending();
        }

    }
}
