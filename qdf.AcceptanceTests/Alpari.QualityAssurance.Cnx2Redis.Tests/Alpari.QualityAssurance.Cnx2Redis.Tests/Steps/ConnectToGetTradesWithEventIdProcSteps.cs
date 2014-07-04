using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables;
using FluentAssertions;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class ConnectToGetTradesWithEventIdProcSteps : ConnectToGetTradesWithEventIdProcStepBase
    {
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
            TradeWithEventIdDataTable = new TradeWithEventIdDataTable().ConvertIEnumerableToDataTable(GetTradesWithEventIdResultList);
        }

        [When(@"I save the TradeWithEventId with ExecId ""(.*)""")]
        public void WhenISaveTheTradeWithEventIdWithExecId(string execId)
        {
            TradeWithEventIdDataTableRow =
                TradeWithEventIdDataTable.Rows.Cast<TradeWithEventIdDataTableRow>().First(row => row.ExecId == execId);
            SelectedTradeWithEventIdTable = new TradeWithEventIdDataTable();
            SelectedTradeWithEventIdTable.ImportRow(TradeWithEventIdDataTableRow);
        }

        [When(@"I save the qdf deal data as a TradeEventWithId datatable")]
        public void WhenISaveTheQdfDealDataAsATradeEventWithIdDatatable()
        {
            GetTradeswithEventIdResultList =
                QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals.ConvertToTradeEventWithIds();
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

    }
}