using System.Linq;
using Alpari.QA.QDF.Test.Domain.TypedDataTables;
using Alpari.QA.Six06Console.Tests.DomainObjects;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.Six06Console.Tests.Steps
{
    [Binding]
    public class Six06ConsoleAppSteps : Six06ConsoleAppStepBase
    {
        public new static readonly string FullName = typeof (Six06ConsoleAppSteps).FullName;


        [When(@"I parse the order events from the console into orders and deals")]
        public void WhenIParseTheOrderEventsFromTheConsoleIntoOrdersAndDeals()
        {
            //synchoronise on completed sql. throw error if not able to start or if there are no deals to pull
            LaunchProcessSteps.ThenTheStandardErrorOutputContainsText(ORDER_EVENT_ID_DELIMITER);
            LaunchProcessSteps.ThenTheStandardErrorOutputContainsText(CONSOLE_IDLE_MESSAGE);
            ParseStandardErrorOutputToOrderDealMapping();
        }

        [When(@"I launch the process and parse the order events from the console into orders and deals")]
        public void WhenILaunchTheProcessAndParseTheOrderEventsFromTheConsoleIntoOrdersAndDeals()
        {
            LaunchProcessSteps.WhenILaunchTheProcess();
            WhenIParseTheOrderEventsFromTheConsoleIntoOrdersAndDeals();
        }

        [Then(@"the order Event ID to deal mapping dictionary contains at least (.*) record")]
        public void ThenTheOrderEventIdToDealMappingDictionaryContainsAtLeastRecord(int minRecordCount)
        {
            OrderEventIdToDealMapping.Count.Should().BeGreaterOrEqualTo(minRecordCount);
        }

        [Then(@"the order Event ID to deal mapping dictionary contains all the deals returned by QDF\.GetAutoTradeswithEventID")]
        public void ThenTheOrderEventIDToDealMappingDictionaryContainsAllTheDealsReturnedByQDF_GetAutoTradeswithEventID()
        {
            var orderEventId = Six06ConsoleQdfDbSteps.TradeWithEventIdDataTable.Rows.Cast<TradeWithEventIdDataTableRow>()
                .Select(x => x.OrderEventId)
                .ToList();
            orderEventId.Should().BeEquivalentTo(OrderEventIdToDealMapping.Keys);
            OrderEventIdToDealMapping.Keys.Should()
                .BeEquivalentTo(orderEventId);
        }
    }
}