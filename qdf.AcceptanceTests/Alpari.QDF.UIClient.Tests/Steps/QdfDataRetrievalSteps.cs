using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QDF.UIClient.App;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QdfDataRetrievalSteps : QdfDataRetrievalStepBase
    {
        public new static readonly string FullName = typeof(QdfDataRetrievalSteps).FullName;


        [Given(@"I have the following search criteria for qdf deals")]
        public void GivenIHaveTheFollowingSearchCriteriaForQdfDeals(DealSearchCriteria dealSearchCriteria)
        {
            ScenarioContext.Current.Pending();
        }

        [When(@"I retrieve the qdf deal data")]
        public void WhenIRetrieveTheQdfDealData()
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"no retrieved deal will have a timestamp outside ""(.*)"" to ""(.*)""")]
        public void ThenNoRetrievedDealWillHaveATimestampOutsideTo(string p0, string p1)
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"the count of retrieved deals will be (.*)")]
        public void ThenTheCountOfRetrievedDealsWillBe(int p0)
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"all retrieved deals will have be for server ""(.*)""")]
        public void ThenAllRetrievedDealsWillHaveBeForServer(string p0)
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"the deals retrieved for each server will have the following counts")]
        public void ThenTheDealsRetrievedForEachServerWillHaveTheFollowingCounts(Table table)
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"all retrieved deals will have be for symbol ""(.*)""")]
        public void ThenAllRetrievedDealsWillHaveBeForSymbol(string p0)
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"the deals retrieved for each symbol will have the following counts")]
        public void ThenTheDealsRetrievedForEachSymbolWillHaveTheFollowingCounts(Table table)
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"all retrieved deals will have be for book ""(.*)""")]
        public void ThenAllRetrievedDealsWillHaveBeForBook(string p0)
        {
            ScenarioContext.Current.Pending();
        }

    }
}
