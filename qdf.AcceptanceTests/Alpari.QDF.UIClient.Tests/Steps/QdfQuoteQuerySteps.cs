using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.QueryableEntities;
using FluentAssertions;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
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
            RedisConnectionHelper.RedisQuoteSearches.GetQuoteData(QuoteSearchCriteria);
        }

        [Then(@"no retrieved quote will have a timestamp outside ""(.*)"" to ""(.*)""")]
        public void ThenNoRetrievedQuoteWillHaveATimestampOutsideTo(DateTime startDateTime, DateTime endDateTime)
        {
            List<LevelQuote> priceQuotes = RedisConnectionHelper.RetrievedQuotes.OrderBy(x => x.TimeStamp).ToList();
            priceQuotes.First().TimeStamp.Should().BeOnOrAfter(startDateTime);
            priceQuotes.Last().TimeStamp.Should().BeOnOrBefore(endDateTime);
        }

        [Then(@"the count of retrieved quotes will be (.*)")]
        public void ThenTheCountOfRetrievedQuotesBe(int expectedCount)
        {
            RedisConnectionHelper.RetrievedQuotes.Should().HaveCount(expectedCount);
        }

        [Then(@"all retrieved quotes will be for symbol ""(.*)""")]
        public void ThenAllRetrievedQuotesWillBeForSymbol(string expectedSymbol)
        {
            RedisConnectionHelper.RetrievedQuotes.ForEach(x=>x.Instrument.Should().Be(expectedSymbol));
        }

        [Then(@"the quotes retrieved for each symbol will have the following counts")]
        public void ThenTheQuotesRetrievedForEachSymbolWillHaveTheFollowingCounts(Table table)
        {
            string verificationErrors = GetVerificationErrorsForQuoteCounts(table);
            Assert.IsEmpty(verificationErrors);
        }

    }
}
