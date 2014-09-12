using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App;
using Alpari.QDF.UIClient.App.QueryableEntities;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QdfQuoteQueryStepBase : StepCentral
    {
        new public static readonly string FullName = typeof(QdfQuoteQueryStepBase).FullName;

        public QdfQuoteQueryStepBase(RedisConnectionHelper redisConnectionHelper) : base(redisConnectionHelper)
        {
        }

        [StepArgumentTransformation]
        public static QuoteSearchCriteria QuoteSearchParametersTransform(Table table)
        {
            return table.CreateInstance<QuoteSearchCriteria>();
        }

        protected string GetVerificationErrorsForQuoteCounts(Table table)
        {
            return QuoteVerificationErrorsForInstrumentCounts(table, RedisConnectionHelper.RetrievedQuotes);
        }

    }
}
