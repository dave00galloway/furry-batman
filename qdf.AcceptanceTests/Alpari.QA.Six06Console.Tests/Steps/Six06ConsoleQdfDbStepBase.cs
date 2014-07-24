using System.Collections.Generic;
using Alpari.QA.QDF.Test.Domain.DataContexts;
using TechTalk.SpecFlow;

namespace Alpari.QA.Six06Console.Tests.Steps
{
    [Binding]
    public class Six06ConsoleQdfDbStepBase : StepCentral
    {
        public new static readonly string FullName = typeof (Six06ConsoleQdfDbStepBase).FullName;

        public Six06ConsoleQdfDbStepBase(GetTradeswithEventIDDataContext getTradeswithEventIdDataContext)
        {
            GetTradeswithEventIdDataContext = getTradeswithEventIdDataContext;
        }

        protected GetTradeswithEventIDDataContext GetTradeswithEventIdDataContext { get; private set; }
        protected List<GetAutoTradeswithEventIDResult> GetTradesWithEventIdResultList { get; set; }
    }
}