using System.Collections.Generic;
using System.Data.Linq;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class ConnectToGetTradesWithEventIdProcStepBase : StepCentral
    {
        public GetTradeswithEventIDDataContext GetTradeswithEventIdDataContext { get; set; }
        public List<GetTradeswithEventIDResult> GetTradesWithEventIdResultList { get; set; }

        public ConnectToGetTradesWithEventIdProcStepBase(CnxTradeTableDataContext cnxTradeTableDataContext, GetTradeswithEventIDDataContext getTradeswithEventIdDataContext)
            : base(cnxTradeTableDataContext)
        {
            GetTradeswithEventIdDataContext = getTradeswithEventIdDataContext;
        }
    }
}