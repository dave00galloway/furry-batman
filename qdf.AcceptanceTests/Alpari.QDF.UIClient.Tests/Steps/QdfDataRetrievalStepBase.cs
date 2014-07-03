using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.QueryableEntities;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QdfDataRetrievalStepBase : StepCentral
    {
        new public static readonly string FullName = typeof (QdfDataRetrievalStepBase).FullName;

        [StepArgumentTransformation]
        public static DealSearchCriteria DealSearchParametersTransform(Table table)
        {
            var dealSearchCriteria = table.CreateInstance<DealSearchCriteria>();
            dealSearchCriteria.SetConvertedTimes();
            return dealSearchCriteria;
        }

        protected string GetVerificationErrorsForServerCounts(Table table)
        {
            return VerificationErrorsForServerCounts(table, RedisConnectionHelper.RetrievedDeals);
        }

        protected string GetVerificationErrorsForSymbolCounts(Table table)
        {
            return VerificationErrorsForSymbolCounts(table, RedisConnectionHelper.RetrievedDeals);
        }
    }
}