using Alpari.QA.QDF.Test.Domain.DataContexts;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.QDF;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using System.Collections.Generic;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class ConnectToGetTradesWithEventIdProcStepBase : StepCentral
    {
        new public static readonly string FullName = typeof(ConnectToGetTradesWithEventIdProcStepBase).FullName; 
        protected GetTradeswithEventIDDataContext GetTradeswithEventIdDataContext { get; private set; }
        protected List<GetTradeswithEventIDResult> GetTradesWithEventIdResultList { get; set; }
        protected TradeWithEventIdDataTable TradeWithEventIdDataTable { get; set; }
        protected TradeWithEventIdDataTableRow TradeWithEventIdDataTableRow { get; set; }
        protected TradeWithEventIdDataTable SelectedTradeWithEventIdTable { get; set; }
        protected List<GetTradeswithEventIDResult> GetTradeswithEventIdResultList { get; set; }
        protected TradeWithEventIdDataTable QdfDealsAsTradeWithEventIdDataTable { get; set; }

        public ConnectToGetTradesWithEventIdProcStepBase(CnxTradeTableDataContext cnxTradeTableDataContext, GetTradeswithEventIDDataContext getTradeswithEventIdDataContext)
            : base(cnxTradeTableDataContext)
        {
            GetTradeswithEventIdDataContext = getTradeswithEventIdDataContext;
        }
    }
}