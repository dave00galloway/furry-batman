using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QueryExecutionStatsSteps :StepCentral
    {
        //private new QdfDataRetrievalSteps QdfDataRetrievalSteps { get; set; }

        [Given(@"I start timing the query")]
        public void GivenIStartTimingTheQuery()
        {
            RedisConnectionHelper.PerformanceStats.Start();
        }

        [When(@"I stop timing the query")]
        public void WhenIStopTimingTheQuery()
        {
            RedisConnectionHelper.PerformanceStats.Stop();
        }

        [Then(@"the query execution time is recorded")]
        public void ThenTheQueryExecutionTimeIsRecorded()
        {
            var executionTime = RedisConnectionHelper.PerformanceStats.ExecutionTime;
            Console.WriteLine(executionTime);
            executionTime.Should().BePositive("query end time should be greater than query end time");
        }

    }
}
