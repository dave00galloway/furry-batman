using System;
using Alpari.QA.QDF.Test.Domain.DataContexts.MT5;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.MT5;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.QDF;
using TechTalk.SpecFlow;

namespace Alpari.QA.Six06Console.Tests.Steps
{
    [Binding]
    public class Six06Mt5DbStepBase : StepCentral
    {
        public Six06Mt5DbStepBase(DealsDataContext dealsDataContext)
        {
            DealsDataContext = dealsDataContext;
        }

        public DealsDataContext DealsDataContext { get; set; }
        public ulong LoginId { get; set; }
        public ulong DealId { get; set; }
        public DealsDataTable Mt5Deals { get; set; }
        public TradeWithEventIdWithDealAndOrderDataTable ConvertedMt5Deals { get; set; }
        

        protected ulong GetHighestDealIdForLogin(ulong loginId)
        {
            var dealQueryTable = DealsDataContext.SelectDataAsDataTable(DealsDataContext.HighestDealForLogin(loginId));
            var dealId = (ulong)dealQueryTable.Rows[dealQueryTable.Rows.Count - 1]["deal"];
            Console.WriteLine(dealId); //debug message. seems daft not to tell the test runner what the deal id was!
            return dealId;
        }
    }
}