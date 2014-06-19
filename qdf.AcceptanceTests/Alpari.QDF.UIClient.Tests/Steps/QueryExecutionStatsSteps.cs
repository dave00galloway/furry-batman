using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QDF.UIClient.App.ControlHelpers;
using Alpari.QDF.UIClient.Tests.Helpers;
using FluentAssertions;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QueryExecutionStatsSteps : StepCentral
    {
        private int _dealCount;
        private decimal _executionTime;
        private long _querySize;
        private string _querySizeString;
        private int _quoteCount;
        private int _totalDealCount;
        private int _totalQuoteCount;

        [Given(@"I start measuring the query")]
        [When(@"I start measuring the query")]
        public void GivenIStartMeasuringTheQuery()
        {
            RedisConnectionHelper.PerformanceStats.Start();
        }

        [Given(@"I have queried and displayed the deal query stats")]
        public void GivenIHaveQueriedAndDisplayedTheDealQueryStats()
        {
            GivenIStartMeasuringTheQuery();
            QdfDataRetrievalSteps.WhenIRetrieveTheQdfDealData();
            WhenIStopMeasuringTheQuery();
            ThenTheStatsForADealQueryAreDisplayed();
        }

        [When(@"I stop measuring the query")]
        public void WhenIStopMeasuringTheQuery()
        {
            RedisConnectionHelper.PerformanceStats.Stop();
        }

        [When(@"I reset the performance stats")]
        public void WhenIResetThePerformanceStats()
        {
            RedisConnectionHelper.ResetPerformanceStats();
        }


        [Then(@"the query execution time is recorded")]
        public void ThenTheQueryExecutionTimeIsRecorded()
        {
            GetExecutionTime();
            _executionTime.Should().BePositive("query end time should be greater than query end time");
        }

        [Then(@"the quote data size is recorded")]
        [Then(@"the deal data size is recorded")]
        public void ThenTheQueryDataSizeIsRecorded()
        {
            GetQuerySize();
            _querySize.Should().BeGreaterOrEqualTo(0);
            _querySizeString.Should().NotBeNullOrWhiteSpace();
        }

        [Then(@"the quote query speed in bytes per second is equal to the size of the query divided by the elapsed time"
            )]
        [Then(@"the deal query speed in bytes per second is equal to the size of the query divided by the elapsed time")
        ]
        public void ThenTheDealQuerySpeedInBytesPerSecondIsEqualToTheSizeOfTheQueryDividedByTheElapsedTime()
        {
            GetQuerySize();
            GetExecutionTime();
            decimal speedInBytesPerSecond =
                RedisConnectionHelper.PerformanceStats.QuerySpeedInBytesPerSecond;
            string speedAsString =
                RedisConnectionHelper.PerformanceStats.QuerySpeedInBytesPerSecondFormatted;
            Console.WriteLine("speedInBytesPerSecond {0}", speedInBytesPerSecond);
            Console.WriteLine("speedAsString {0}", speedAsString);
            speedInBytesPerSecond.Should().Be(_querySize/_executionTime);
            speedInBytesPerSecond.Should().BeGreaterOrEqualTo(0);
            speedAsString.Should().NotBeNullOrWhiteSpace();
        }

        [Then(@"the deal count is recorded")]
        public void ThenTheDealCountIsRecorded()
        {
            GetDealCount();
            _dealCount.Should().BePositive();
        }

        [Then(@"the quote count is recorded")]
        public void ThenTheQuoteCountIsRecorded()
        {
            GetQuoteCount();
            _quoteCount.Should().BePositive();
        }


        [Then(@"the total deal count is recorded")]
        public void ThenTheTotalDealCountIsRecorded()
        {
            GetTotalDealCount();
            _totalDealCount.Should().BePositive();
        }

        [Then(@"the total quote count is recorded")]
        public void ThenTheTotalQuoteCountIsRecorded()
        {
            GetTotalQuoteCount();
        }

        [Then(@"the deal query speed in deals per second is equal to the deal count divided by the elapsed time")]
        public void ThenTheDealQuerySpeedInDealsPerSecondIsEqualToTheDealCountDividedByTheElapsedTime()
        {
            GetDealCount();
            GetExecutionTime();
            decimal speedInDealsPerSecond =
                RedisConnectionHelper.PerformanceStats.DealQueryPerformance.DealQuerySpeedInDealsPerSecond;
            string speedAsString =
                RedisConnectionHelper.PerformanceStats.DealQueryPerformance.DealQuerySpeedInDealsPerSecondFormatted;
            Console.WriteLine("speedInDealsPerSecond {0}", speedInDealsPerSecond);
            Console.WriteLine("speedAsString {0}", speedAsString);
            speedInDealsPerSecond.Should().Be(_dealCount/_executionTime);
            speedInDealsPerSecond.Should().BeGreaterOrEqualTo(0);
            speedAsString.Should().NotBeNullOrWhiteSpace();
        }

        [Then(@"the quote query speed in quotes per second is equal to the quote count divided by the elapsed time")]
        public void ThenTheQuoteQuerySpeedInQuotesPerSecondIsEqualToTheQuoteCountDividedByTheElapsedTime()
        {
            GetQuoteCount();
            GetExecutionTime();
            decimal speedInQuotesPerSecond =
                RedisConnectionHelper.PerformanceStats.QuoteQueryPerformance.QuoteQuerySpeedInDealsPerSecond;
            string speedAsString =
                RedisConnectionHelper.PerformanceStats.QuoteQueryPerformance.QuoteQuerySpeedInDealsPerSecondFormatted;
            Console.WriteLine("speedInQuotesPerSecond {0}", speedInQuotesPerSecond);
            Console.WriteLine("speedAsString {0}", speedAsString);
            speedInQuotesPerSecond.Should().Be(_quoteCount/_executionTime);
            speedInQuotesPerSecond.Should().BeGreaterOrEqualTo(0);
            speedAsString.Should().NotBeNullOrWhiteSpace();
        }


        [Then(@"the deal query speed in total deals per second is equal to the deal count divided by the elapsed time")]
        public void ThenTheDealQuerySpeedInTotalDealsPerSecondIsEqualToTheDealCountDividedByTheElapsedTime()
        {
            GetTotalDealCount();
            GetExecutionTime();
            decimal speedInDealsPerSecond =
                RedisConnectionHelper.PerformanceStats.DealQueryPerformance.TotalDealQuerySpeedInDealsPerSecond;
            string speedAsString =
                RedisConnectionHelper.PerformanceStats.DealQueryPerformance.TotalDealQuerySpeedInDealsPerSecondFormatted;
            Console.WriteLine("speedInDealsPerSecond {0}", speedInDealsPerSecond);
            Console.WriteLine("speedAsString {0}", speedAsString);
        }

        [Then(@"the deal quote speed in total quotes per second is equal to the quote count divided by the elapsed time"
            )]
        public void ThenTheDealQuoteSpeedInTotalQuotesPerSecondIsEqualToTheQuoteCountDividedByTheElapsedTime()
        {
            GetTotalQuoteCount();
            GetExecutionTime();
            decimal speedInQuotesPerSecond =
                RedisConnectionHelper.PerformanceStats.QuoteQueryPerformance.TotalQuoteQuerySpeedInDealsPerSecond;
            string speedAsString =
                RedisConnectionHelper.PerformanceStats.QuoteQueryPerformance
                    .TotalQuoteQuerySpeedInDealsPerSecondFormatted;
            Console.WriteLine("speedInQuotesPerSecond {0}", speedInQuotesPerSecond);
            Console.WriteLine("speedAsString {0}", speedAsString);
            speedInQuotesPerSecond.Should().Be(_totalQuoteCount/_executionTime);
            speedInQuotesPerSecond.Should().BeGreaterOrEqualTo(0);
            speedAsString.Should().NotBeNullOrWhiteSpace();
        }

        [Then(@"the stats for a deal query are displayed")]
        public void ThenTheStatsForADealQueryAreDisplayed()
        {
            string[] retrievedStats = RedisConnectionHelper.PerformanceStats.GetStats(SupportedDataTypesControl.DEAL);
            string statsData;
            string reason;
            IList<string> enumerable = SetupStatsDataAndReason(retrievedStats, out statsData, out reason);
            enumerable.Any(retrievedStat => retrievedStat.Split(':')[0].Trim().Equals("ExecutionTime"))
                .Should()
                .BeTrue(reason);
            enumerable.Any(retrievedStat => retrievedStat.Split(':')[0].Trim().Equals("QuerySize"))
                .Should()
                .BeTrue(reason);
            enumerable.Any(retrievedStat => retrievedStat.Split(':')[0].Trim().Equals("Query Speed in bytes"))
                .Should()
                .BeTrue(reason);
            enumerable.Any(retrievedStat => retrievedStat.Split(':')[0].Trim().Equals("Query Speed in deals"))
                .Should()
                .BeTrue(reason);
            enumerable.Any(retrievedStat => retrievedStat.Split(':')[0].Trim().Equals("TotalDealCount"))
                .Should()
                .BeTrue(reason);
            enumerable.Any(retrievedStat => retrievedStat.Split(':')[0].Trim().Equals("Query Speed in total deals"))
                .Should()
                .BeTrue(reason);

            Console.WriteLine(statsData);
        }


        [Then(@"the stats for a quote query are displayed")]
        public void ThenTheStatsForAQuoteQueryAreDisplayed()
        {
            string[] retrievedStats =
                RedisConnectionHelper.PerformanceStats.GetStats(SupportedDataTypesControl.PRICE_QUOTE);
            string statsData;
            string reason;
            IList<string> enumerable = SetupStatsDataAndReason(retrievedStats, out statsData, out reason);
            enumerable.Any(retrievedStat => retrievedStat.Split(':')[0].Trim().Equals("ExecutionTime"))
                .Should()
                .BeTrue(reason);
            enumerable.Any(retrievedStat => retrievedStat.Split(':')[0].Trim().Equals("QuerySize"))
                .Should()
                .BeTrue(reason);
            enumerable.Any(retrievedStat => retrievedStat.Split(':')[0].Trim().Equals("Query Speed in bytes"))
                .Should()
                .BeTrue(reason);
        }

        [Then(@"the deal performance stats are:")]
        public void ThenTheDealPerformanceStatsAre(DealPerformanceStats dealPerformanceStats)
        {
            RedisConnectionHelper.PerformanceStats.ExecutionTime.Should().Be(dealPerformanceStats.ExecutionTime);
            RedisConnectionHelper.PerformanceStats.QuerySize.Should().Be(dealPerformanceStats.QuerySize);
            RedisConnectionHelper.PerformanceStats.QuerySizeFormatted.Should()
                .Be(dealPerformanceStats.QuerySizeFormatted);
            RedisConnectionHelper.PerformanceStats.QuerySpeedInBytesPerSecond.Should()
                .Be(dealPerformanceStats.QuerySpeedInBytesPerSecond);
            RedisConnectionHelper.PerformanceStats.QuerySpeedInBytesPerSecondFormatted.Should()
                .Be(dealPerformanceStats.QuerySpeedInBytesPerSecondFormatted);
            RedisConnectionHelper.PerformanceStats.DealQueryPerformance.DealCount.Should()
                .Be(dealPerformanceStats.DealCount);
            RedisConnectionHelper.PerformanceStats.DealQueryPerformance.TotalDealCount.Should()
                .Be(dealPerformanceStats.TotalDealCount);
            RedisConnectionHelper.PerformanceStats.DealQueryPerformance.DealQuerySpeedInDealsPerSecond.Should()
                .Be(dealPerformanceStats.DealQuerySpeedInDealsPerSecond);
            RedisConnectionHelper.PerformanceStats.DealQueryPerformance.DealQuerySpeedInDealsPerSecondFormatted.Should()
                .Be(dealPerformanceStats.DealQuerySpeedInDealsPerSecondFormatted);
            RedisConnectionHelper.PerformanceStats.DealQueryPerformance.TotalDealQuerySpeedInDealsPerSecond.Should()
                .Be(dealPerformanceStats.TotalDealQuerySpeedInDealsPerSecond);
            RedisConnectionHelper.PerformanceStats.DealQueryPerformance.TotalDealQuerySpeedInDealsPerSecondFormatted
                .Should().Be(dealPerformanceStats.TotalDealQuerySpeedInDealsPerSecondFormatted);
        }

        [StepArgumentTransformation]
        public static DealPerformanceStats DealSearchParametersTransform(Table table)
        {
            return table.CreateInstance<DealPerformanceStats>();
        }


        //TODO:- create a step base class and add these methods
        private void GetQuerySize()
        {
            Console.WriteLine(
                "for small queries and when running a whole feature, the query size may be returned as 0. Run as a single scenario for a more accurate answer");
            _querySize = RedisConnectionHelper.PerformanceStats.QuerySize;
            _querySizeString = RedisConnectionHelper.PerformanceStats.QuerySizeFormatted;
            Console.WriteLine("_querySize {0}", _querySize);
            Console.WriteLine("_querySizeString {0}", _querySizeString);
        }

        private void GetExecutionTime()
        {
            _executionTime = RedisConnectionHelper.PerformanceStats.ExecutionTime;
            Console.WriteLine("_executionTime {0}", _executionTime);
        }

        private void GetDealCount()
        {
            _dealCount = RedisConnectionHelper.PerformanceStats.DealQueryPerformance.DealCount;
            Console.WriteLine("_dealCount {0}", _dealCount);
        }

        private void GetQuoteCount()
        {
            _quoteCount = RedisConnectionHelper.PerformanceStats.QuoteQueryPerformance.QuoteCount;
            Console.WriteLine("_quoteCount {0}", _quoteCount);
        }

        private void GetTotalDealCount()
        {
            _totalDealCount = RedisConnectionHelper.PerformanceStats.DealQueryPerformance.TotalDealCount;
            Console.WriteLine("_totalDealCount {0}", _totalDealCount);
        }

        private void GetTotalQuoteCount()
        {
            _totalQuoteCount = RedisConnectionHelper.PerformanceStats.QuoteQueryPerformance.TotalQuoteCount;
            Console.WriteLine("_totalQuoteCount {0}", _totalQuoteCount);
        }

        private static IList<string> SetupStatsDataAndReason(IEnumerable<string> retrievedStats, out string statsData,
            out string reason)
        {
            IList<string> enumerable = retrievedStats as IList<string> ?? retrievedStats.ToList();
            statsData = String.Join("\r\n", enumerable);
            statsData = String.Format("\r\n \r\n {0} \r\n", statsData);
            reason = String.Format(" the stats report should contain this field but it doesn't. see {0} \r\n", statsData);
            return enumerable;
        }
    }
}