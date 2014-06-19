using FluentAssertions;
using System;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QueryExecutionStatsSteps :StepCentral
    {
        private long _dealQuerySize;
        private string _dealSizeString;
        private decimal _executionTime;
        private int _dealCount;

        [Given(@"I start measuring the query")]
        public void GivenIStartMeasuringTheQuery()
        {
            RedisConnectionHelper.PerformanceStats.Start();
        }

        [When(@"I stop measuring the query")]
        public void WhenIStopMeasuringTheQuery()
        {
            RedisConnectionHelper.PerformanceStats.Stop();
        }


        [Then(@"the query execution time is recorded")]
        public void ThenTheQueryExecutionTimeIsRecorded()
        {
            GetExecutionTime();
            _executionTime.Should().BePositive("query end time should be greater than query end time");
        }

        [Then(@"the deal data size is recorded")]
        public void ThenTheDealDataSizeIsRecorded()
        {
            GetDealQuerySize();
            _dealQuerySize.Should().BePositive("the retrieved deals should take up some space in memory");
            _dealSizeString.Should().NotBeNullOrWhiteSpace();
        }

        [Then(@"the deal query speed in bytes per second is equal to the size of the query divided by the elapsed time")]
        public void ThenTheDealQuerySpeedInBytesPerSecondIsEqualToTheSizeOfTheQueryDividedByTheElapsedTime()
        {
            GetDealQuerySize();
            GetExecutionTime();
            var speedInBytesPerSecond = RedisConnectionHelper.PerformanceStats.DealQuerySpeedInBytesPerSecond;
            var speedAsString = RedisConnectionHelper.PerformanceStats.DealQuerySpeedInBytesPerSecondFormatted;
            Console.WriteLine("speedInBytesPerSecond {0}",speedInBytesPerSecond);
            Console.WriteLine("speedAsString {0}",speedAsString);
            speedInBytesPerSecond.Should().Be(_dealQuerySize/_executionTime);
            speedInBytesPerSecond.Should().BeGreaterOrEqualTo(0);
            speedAsString.Should().NotBeNullOrWhiteSpace();
        }

        [Then(@"the deal count is recorded")]
        public void ThenTheDealCountIsRecorded()
        {
            GetDealCount();
            _dealCount.Should().BePositive();
        }

        [Then(@"the deal query speed in deals per second is equal to the deal count divided by the elapsed time")]
        public void ThenTheDealQuerySpeedInDealsPerSecondIsEqualToTheDealCountDividedByTheElapsedTime()
        {
            GetDealCount();
            GetExecutionTime();
            var speedInDealsPerSecond = RedisConnectionHelper.PerformanceStats.DealQuerySpeedInDealsPerSecond;
            var speedAsString = RedisConnectionHelper.PerformanceStats.DealQuerySpeedInDealsPerSecondFormatted;
            Console.WriteLine("speedInDealsPerSecond {0}",speedInDealsPerSecond);
            Console.WriteLine("speedAsString {0}", speedAsString);
            speedInDealsPerSecond.Should().Be(_dealCount/_executionTime);
            speedInDealsPerSecond.Should().BeGreaterOrEqualTo(0);
            speedAsString.Should().NotBeNullOrWhiteSpace();
        }

        //TODO:- create a step base class and add these methods
        private void GetDealQuerySize()
        {
            Console.WriteLine("for small queries and when running a whole feature, the query size may be returned as 0. Run as a single scenario for a more accurate answer");
            _dealQuerySize = RedisConnectionHelper.PerformanceStats.DealQuerySize;
            _dealSizeString = RedisConnectionHelper.PerformanceStats.DealQuerySizeFormatted;
            Console.WriteLine("_dealQuerySize {0}",_dealQuerySize);
            Console.WriteLine("_dealSizeString {0}", _dealSizeString);
        }

        private void GetExecutionTime()
        {
            _executionTime = RedisConnectionHelper.PerformanceStats.ExecutionTime;
            Console.WriteLine("_executionTime {0}", _executionTime);
        }

        private void GetDealCount()
        {
            _dealCount = RedisConnectionHelper.PerformanceStats.DealCount;
            Console.WriteLine("_dealCount {0}",_dealCount);
        }

    }
}
