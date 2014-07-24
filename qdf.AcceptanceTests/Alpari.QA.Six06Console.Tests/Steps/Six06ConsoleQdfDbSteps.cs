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

        public Six06ConsoleQdfDbSteps(GetTradeswithEventIDDataContext getTradeswithEventIdDataContext)
            : base(getTradeswithEventIdDataContext)
        {
        }

        [Given(@"I have a connection to QDF\.GetTradeswithEventIDProc")]
        public void GivenIHaveAConnectionToQDF_GetTradeswithEventIDProc()
        {
            GetTradeswithEventIdDataContext.Should().NotBeNull();
        }

        [When(@"I call QDF\.GetAutoTradeswithEventID with ID (.*)")]
        public void WhenICallQDF_GetAutoTradeswithEventIDWithID(int p0)
        {
            GetTradesWithEventIdResultList = GetTradeswithEventIdDataContext.GetAutoTradeswithEventID(p0).ToList();
        }

        

        [When(@"I save the QDF\.GetAutoTradeswithEventID result as a datatable")]
        public void WhenISaveTheQDF_GetAutoTradeswithEventIDResultAsADatatable()
        {
            //todo - create interface in partial class of GetTradeswithEventIdDataContext and show that the result of all the methods implement the interface
            //TradeWithEventIdDataTable = new TradeWithEventIdDataTable().ConvertIEnumerableToDataTable(GetTradesWithEventIdResultList, "TradeWithEventId", new[] { "ExecId" });
        }

        public TradeWithEventIdDataTable TradeWithEventIdDataTable { get; set; }

        [Then(@"the QDF\.GetAutoTradeswithEventID data table contains at least one result")]
        public void ThenTheQDF_GetAutoTradeswithEventIDDataTableContainsAtLeastOneResult()
        {
            ScenarioContext.Current.Pending();
        }
    }
}