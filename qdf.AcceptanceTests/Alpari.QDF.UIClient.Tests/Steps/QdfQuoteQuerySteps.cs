using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QDF.UIClient.App.QueryableEntities;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QdfQuoteQuerySteps : QdfQuoteQueryStepBase
    {
        public new static readonly string FullName = typeof(QdfQuoteQuerySteps).FullName;
        private QuoteSearchCriteria QuoteSearchCriteria { get; set; }

        [Given(@"I have the following search criteria for qdf quotes")]
        public void GivenIHaveTheFollowingSearchCriteriaForQdfQuotes(QuoteSearchCriteria quoteSearchCriteria)
        {
            QuoteSearchCriteria = quoteSearchCriteria;
        }

        [When(@"I retrieve the qdf quote data")]
        public void WhenIRetrieveTheQdfQuoteData()
        {
            RedisConnectionHelper.GetQuoteData(QuoteSearchCriteria);
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
