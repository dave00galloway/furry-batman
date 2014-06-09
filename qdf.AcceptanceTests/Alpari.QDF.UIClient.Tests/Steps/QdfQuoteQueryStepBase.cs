using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QDF.UIClient.App.QueryableEntities;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class QdfQuoteQueryStepBase : StepCentral
    {
        public static readonly string FullName = typeof(QdfQuoteQueryStepBase).FullName;

        [StepArgumentTransformation]
        public static QuoteSearchCriteria QuoteSearchParametersTransform(Table table)
        {
            return table.CreateInstance<QuoteSearchCriteria>();
        }
    }
}
