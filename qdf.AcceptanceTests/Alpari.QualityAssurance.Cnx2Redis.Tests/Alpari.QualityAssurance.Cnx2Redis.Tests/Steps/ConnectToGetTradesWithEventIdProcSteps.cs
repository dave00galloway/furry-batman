using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using System;
using System.Linq;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class ConnectToGetTradesWithEventIdProcSteps : ConnectToGetTradesWithEventIdProcStepBase
    {
        new public static readonly string FullName = typeof(ConnectToGetTradesWithEventIdProcSteps).FullName; 
        public ConnectToGetTradesWithEventIdProcSteps(CnxTradeTableDataContext cnxTradeTableDataContext,
            GetTradeswithEventIDDataContext getTradeswithEventIdDataContext)
            : base(cnxTradeTableDataContext, getTradeswithEventIdDataContext)
        {
        }

        [Given(@"I have a connection to QDF\.GetTradeswithEventIDProc")]
        public void GivenIHaveAConnectionToQDF_GetTradeswithEventIDProc()
        {
            GetTradeswithEventIdDataContext.Should().NotBeNull();
        }

        [When(@"I call QDF\.GetTradeswithEventIDProc with ID (.*)")]
        public void WhenICallQDF_GetTradeswithEventIDProcWithID(int orderIdFrom)
        {
            GetTradesWithEventIdResultList = GetTradeswithEventIdDataContext.GetTradeswithEventID(orderIdFrom).ToList();
        }

        [When(@"I save the QDF\.GetTradeswithEventIDProc result as a datatable")]
        public void WhenISaveTheQDF_GetTradeswithEventIDProcResultAsADatatable()
        {
            TradeWithEventIdDataTable = new TradeWithEventIdDataTable().ConvertIEnumerableToDataTable(GetTradesWithEventIdResultList, "TradeWithEventId", new[] { "ExecId" });
        }

        [When(@"I save the TradeWithEventId with ExecId ""(.*)""")]
        public void WhenISaveTheTradeWithEventIdWithExecId(string execId)
        {
            TradeWithEventIdDataTableRow =
                TradeWithEventIdDataTable.Rows.Cast<TradeWithEventIdDataTableRow>().First(row => row.ExecId == execId);
            SelectedTradeWithEventIdTable = new TradeWithEventIdDataTable("TradeEventWithIdTable", new[] { "ExecId" });
            SelectedTradeWithEventIdTable.ImportRow(TradeWithEventIdDataTableRow);
            TradeWithEventIdDataTable = SelectedTradeWithEventIdTable;
        }

        [When(@"I save the qdf deal data as a TradeEventWithId datatable")]
        public void WhenISaveTheQdfDealDataAsATradeEventWithIdDatatable()
        {
            GetTradeswithEventIdResultList =
                QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals.ConvertToTradeEventWithIds();
            QdfDealsAsTradeWithEventIdDataTable =
                new TradeWithEventIdDataTable().ConvertIEnumerableToDataTable(GetTradeswithEventIdResultList, "QdfDeals", new[] { "ExecId" });
        }

        [When(@"I compare TradeWithEventId deals with the qdf deal data excluding these fields:")]
        public void WhenICompareTradeWithEventIdDealsWithTheQdfDealDataExcludingTheseFields(Table table)
        {
            var ignoredFieldsQuery = IgnoredFieldsQuery(table);
            var diffs = TradeWithEventIdDataTable.Compare(QdfDealsAsTradeWithEventIdDataTable, ignoredFieldsQuery, null, false, true);
            ScenarioContext.Current["diffs"] = diffs;
        }

        
        [Then(@"at least one order and event are returned")]
        public void ThenAtLeastOneOrderAndEventAreReturned()
        {
            GetTradesWithEventIdResultList.Count().Should().BeGreaterOrEqualTo(1);
        }

        [Then(@"the QDF\.GetTradeswithEventIDProc data table contains at least one result")]
        public void ThenTheQDF_GetTradeswithEventIDProcDataTableContainsAtLeastOneResult()
        {
            TradeWithEventIdDataTable.Rows.Count.Should().BeGreaterOrEqualTo(1);
        }

        [Then(@"the SelectedTradeWithEventIdTable contains (.*) row")]
        public void ThenTheSelectedTradeWithEventIdTableContainsRow(int expectedRowCount)
        {
            SelectedTradeWithEventIdTable.Rows.Count.Should().Be(expectedRowCount);
        }

        [Then(@"the SelectedTradeWithEventIdTable contains a TradeWithEventId with an ExecId of ""(.*)""")]
        public void ThenTheSelectedTradeWithEventIdTableContainsATradeWithEventIdWithAnExecIdOf(string execId)
        {
            SelectedTradeWithEventIdTable.Rows.Cast<TradeWithEventIdDataTableRow>()
                .Should()
                .Contain(x => x.ExecId == execId, String.Format("ExecId should be {0}", execId));
        }

        [Then(@"the QdfDealsAsTradeWithEventIdDataTable table contains (.*) row")]
        public void ThenTheQdfDealsAsTradeWithEventIdDataTableTableContainsRow(int expectedRowCount)
        {
            QdfDealsAsTradeWithEventIdDataTable.Rows.Count.Should().Be(expectedRowCount);
        }

        [Then(@"the QdfDealsAsTradeWithEventIdDataTable contains a TradeWithEventId with an ExecId of ""(.*)""")]
        public void ThenTheQdfDealsAsTradeWithEventIdDataTableContainsATradeWithEventIdWithAnExecIdOf(string execId)
        {
            QdfDealsAsTradeWithEventIdDataTable.Rows.Cast<TradeWithEventIdDataTableRow>()
                .Should()
                .Contain(x => x.ExecId == execId);
        }

        [Then(@"the TradeWithEventId deals should match the qdf deal data exactly")]
        public void ThenTheTradeWithEventIdDealsShouldMatchTheQdfDealDataExactly()
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            diffs.CheckForDifferences().Should().BeNullOrWhiteSpace();
        }
    }
}