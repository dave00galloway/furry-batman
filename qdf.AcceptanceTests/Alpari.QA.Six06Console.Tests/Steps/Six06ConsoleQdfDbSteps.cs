using System.Collections.Generic;
using System.Linq;
using Alpari.QA.QDF.Test.Domain.DataContexts;
using Alpari.QA.QDF.Test.Domain.TypedDataTables;
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
            GetTradesWithEventIdResultList = GetTradeswithEventIdDataContext.GetAutoTradeswithEventID<GetTradeswithEventIDResult>(startFromId).ToList();
        }

        

        [When(@"I save the QDF\.GetAutoTradeswithEventID result as a datatable")]
        public void WhenISaveTheQDF_GetAutoTradeswithEventIDResultAsADatatable()
        {
            TradeWithEventIdDataTable = new TradeWithEventIdDataTable().ConvertIEnumerableToDataTable(GetTradesWithEventIdResultList, "TradeWithEventId", new[] { "ExecId" });
        }

        [Then(@"the QDF\.GetAutoTradeswithEventID data table contains at least one result")]
        public void ThenTheQDF_GetAutoTradeswithEventIDDataTableContainsAtLeastOneResult()
        {
            TradeWithEventIdDataTable.Rows.Count.Should().BeGreaterOrEqualTo(1);
        }
    }
}