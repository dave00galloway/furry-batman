using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.QueryableEntities;
using FluentAssertions;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QdfDataRetrievalSteps : QdfDataRetrievalStepBase
    {
        public new static readonly string FullName = typeof (QdfDataRetrievalSteps).FullName;
        public DealSearchCriteria DealSearchCriteria { get; private set; }

        [Given(@"I have the following search criteria for qdf deals")]
        public void GivenIHaveTheFollowingSearchCriteriaForQdfDeals(DealSearchCriteria dealSearchCriteria)
        {
            DealSearchCriteria = dealSearchCriteria;
        }

        [When(@"I retrieve the qdf deal data")]
        public void WhenIRetrieveTheQdfDealData()
        {
            RedisConnectionHelper.GetDealData(DealSearchCriteria);
        }

        [Then(@"no retrieved deal will have a timestamp outside ""(.*)"" to ""(.*)""")]
        public void ThenNoRetrievedDealWillHaveATimestampOutsideTo(DateTime startDateTime, DateTime endDateTime)
        {
            List<Deal> dealsByTimestamp = RedisConnectionHelper.RetrievedDeals.OrderBy(x => x.TimeStamp).ToList();
            dealsByTimestamp.First().TimeStamp.Should().BeOnOrAfter(startDateTime);
            dealsByTimestamp.Last().TimeStamp.Should().BeOnOrBefore(endDateTime);
        }

        [Then(@"the count of retrieved deals will be (.*)")]
        public void ThenTheCountOfRetrievedDealsWillBe(int expectedCount)
        {
            RedisConnectionHelper.RetrievedDeals.Should().HaveCount(expectedCount);
        }

        [Then(@"all retrieved deals will have be for server ""(.*)""")]
        public void ThenAllRetrievedDealsWillHaveBeForServer(string expectedServer)
        {
            RedisConnectionHelper.RetrievedDeals.ForEach(
                x => x.Server.Should().Be(Enum.Parse(typeof (TradingServer), expectedServer)));
        }

        [Then(@"the deals retrieved for each server will have the following counts")]
        public void ThenTheDealsRetrievedForEachServerWillHaveTheFollowingCounts(Table table)
        {
            string verificationErrors = GetVerificationErrorsForServerCounts(table);
            Assert.IsEmpty(verificationErrors);
        }

        [Then(@"all retrieved deals will have be for symbol ""(.*)""")]
        public void ThenAllRetrievedDealsWillHaveBeForSymbol(string expectedSymbol)
        {
            RedisConnectionHelper.RetrievedDeals.ForEach(x => x.Instrument.Should().Be(expectedSymbol));
        }

        [Then(@"the deals retrieved for each symbol will have the following counts")]
        public void ThenTheDealsRetrievedForEachSymbolWillHaveTheFollowingCounts(Table table)
        {
            string verificationErrors = GetVerificationErrorsForSymbolCounts(table);
            Assert.IsEmpty(verificationErrors);
        }

        [Then(@"all retrieved deals will have be for book ""(.*)""")]
        public void ThenAllRetrievedDealsWillHaveBeForBook(string expectedBook)
        {
            RedisConnectionHelper.RetrievedDeals.ForEach(
                x => x.Book.Should().Be(Enum.Parse(typeof (Book), expectedBook)));
        }
    }
}