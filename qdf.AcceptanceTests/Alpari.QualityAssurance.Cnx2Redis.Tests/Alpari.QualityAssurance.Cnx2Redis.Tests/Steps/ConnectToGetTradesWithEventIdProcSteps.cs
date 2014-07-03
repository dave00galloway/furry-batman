using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Text;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class ConnectToGetTradesWithEventIdProcSteps : ConnectToGetTradesWithEventIdProcStepBase
    {
        public ConnectToGetTradesWithEventIdProcSteps(CnxTradeTableDataContext cnxTradeTableDataContext, GetTradeswithEventIDDataContext getTradeswithEventIdDataContext) : base(cnxTradeTableDataContext, getTradeswithEventIdDataContext)
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

        [Then(@"at least one order and event are returned")]
        public void ThenAtLeastOneOrderAndEventAreReturned()
        {
            GetTradesWithEventIdResultList.Count().Should().BeGreaterOrEqualTo(1);
        }
    }
}
