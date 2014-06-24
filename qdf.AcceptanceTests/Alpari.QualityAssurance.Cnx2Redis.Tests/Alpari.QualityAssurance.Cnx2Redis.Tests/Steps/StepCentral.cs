using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        protected CnxTradeTableDataContext CnxTradeTableDataContext { get; private set; }

        public StepCentral(CnxTradeTableDataContext cnxTradeTableDataContext)
        {
            CnxTradeTableDataContext = cnxTradeTableDataContext;
        }

        protected static string QuerySingleTrade(string tradeId)
        {
            return String.Format("SELECT * FROM auktest_hedge.trade WHERE trade_id = '{0}'", tradeId);
        }
    }
}
