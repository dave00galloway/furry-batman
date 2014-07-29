using Alpari.QA.QDF.Test.Domain.MT5;
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
        public int LoginId { get; set; }
        public ulong DealId { get; set; }

        protected ulong GetHighestDealIdForLogin(int loginId)
        {
            var dealQueryTable = DealsDataContext.SelectDataAsDataTable(DealsDataContext.HighestDealForLogin(loginId));
            return (ulong)dealQueryTable.Rows[dealQueryTable.Rows.Count - 1]["deal"];
        }
    }
}