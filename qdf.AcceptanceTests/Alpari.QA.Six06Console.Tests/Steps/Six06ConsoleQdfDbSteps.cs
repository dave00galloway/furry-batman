using System.Linq;
using Alpari.QA.QDF.Test.Domain.DataContexts;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.QDF;
using Alpari.QA.Six06Console.Tests.DomainObjects;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.Six06Console.Tests.Steps
{
    [Binding]
    public class Six06ConsoleQdfDbSteps : Six06ConsoleQdfDbStepBase
    {
        public new static readonly string FullName = typeof (Six06ConsoleQdfDbSteps).FullName;

        public Six06ConsoleQdfDbSteps(GetTradesWithEventId getTradesWithEventId)
            : base(getTradesWithEventId)
        {
        }

        [Given(@"I have a connection to QDF\.GetTradeswithEventIDProc")]
        public void GivenIHaveAConnectionToQDF_GetTradeswithEventIDProc()
        {
            GetTradeswithEventIdDataContext.Should().NotBeNull();
        }

        [When(@"I call QDF\.GetAutoTradeswithEventID with ID (.*)")]
        public void WhenICallQDF_GetAutoTradeswithEventIDWithID(int startFromId)
        {
            GetTradesWithEventIdResultList =
                GetTradeswithEventIdDataContext.GetAutoTradeswithEventID<IGetTradeswithEventIdResult>(startFromId)
                    .ToList();
        }

        [When(@"I call QDF\.GetAutoTradeswithEventID with ID (.*) and save the result as a datatable")]
        public void WhenICallQDF_GetAutoTradeswithEventIDWithIDAndSaveTheResultAsADatatable(int startFromId)
        {
            WhenICallQDF_GetAutoTradeswithEventIDWithID(startFromId);
            WhenISaveTheQDF_GetAutoTradeswithEventIDResultAsADatatable();
        }

        [When(@"I save the QDF\.GetAutoTradeswithEventID result as a datatable")]
        public void WhenISaveTheQDF_GetAutoTradeswithEventIDResultAsADatatable()
        {
            TradeWithEventIdDataTable =
                new TradeWithEventIdDataTable().ConvertIEnumerableToDataTable(GetTradesWithEventIdResultList,
                    "TradeWithEventId", new[] {"OrderEventID"});
        }

        [When(@"I convert the trades with event ids to trades with deal and order ids")]
        public void WhenIConvertTheTradesWithEventIdsToTradesWithDealAndOrderIds()
        {
            ConvertedTradesWithEventIds =
                TradeWithEventIdDataTable.ConvertTradeWithEventIdDataTable(
                    Six06ConsoleAppSteps.OrderEventIdToDealMapping);
        }

        [When(@"I convert the trades with event ids to trades with deal and order ids if they exist")]
        public void WhenIConvertTheTradesWithEventIdsToTradesWithDealAndOrderIdsIfTheyExist()
        {
            ConvertedTradesWithEventIds =
                TradeWithEventIdDataTable.ConvertTradeWithEventIdDataTable(
                    Six06ConsoleAppSteps.OrderEventIdToDealMapping);
            ConvertedTradesWithEventIds =
                TradeWithEventIdDataTable.MapRemainingTradesWithEventIds(ConvertedTradesWithEventIds);
        }

        [Then(@"the QDF\.GetAutoTradeswithEventID data table contains at least one result")]
        public void ThenTheQDF_GetAutoTradeswithEventIDDataTableContainsAtLeastOneResult()
        {
            TradeWithEventIdDataTable.Rows.Count.Should().BeGreaterOrEqualTo(1);
        }

        [Then(@"all order events in the order event id to deal mapping dictionary are mapped to trades with event ids")]
        public void ThenAllOrderEventsInTheOrderEventIdToDealMappingDictionaryAreMappedToTradesWithEventIds()
        {
            CheckDealsHaveBeenMappedToOrderEventIds(Six06ConsoleAppSteps.OrderEventIdToDealMapping,
                ConvertedTradesWithEventIds);
        }

        [Then(@"at least one order event in the order event id to deal mapping dictionary is mapped to trades with event ids")]
        public void ThenAtLeastOneOrderEventInTheOrderEventIdToDealMappingDictionaryIsMappedToTradesWithEventIds()
        {
            ConvertedTradesWithEventIds.Rows.Cast<TradeWithEventIdWithDealAndOrderDataTableRow>()
                .Any(
                    x =>
                        Six06ConsoleAppSteps.OrderEventIdToDealMapping.Any(y => y.Key == x.OrderEventId)).Should().BeTrue();
        }
    }
}