using System.Collections.Generic;
using System.Data.Linq;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables;
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