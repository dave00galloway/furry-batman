using System.Collections.Generic;
using Alpari.QA.QDF.Test.Domain.DataContexts;
using Alpari.QA.QDF.Test.Domain.TypedDataTables;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.QDF;
using TechTalk.SpecFlow;

namespace Alpari.QA.Six06Console.Tests.Steps
{
    [Binding]
    public class Six06ConsoleQdfDbStepBase : StepCentral
    {
        public new static readonly string FullName = typeof (Six06ConsoleQdfDbStepBase).FullName;

        public Six06ConsoleQdfDbStepBase(GetTradesWithEventId getTradesWithEventId)
        {
            GetTradeswithEventIdDataContext = getTradesWithEventId.GetTradeswithEventIdDataContext;
        }

        protected GetTradeswithEventIDDataContext GetTradeswithEventIdDataContext { get; private set; }
        protected List<IGetTradeswithEventIdResult> GetTradesWithEventIdResultList { get; set; }
        public TradeWithEventIdDataTable TradeWithEventIdDataTable { get; set; }
    }
}