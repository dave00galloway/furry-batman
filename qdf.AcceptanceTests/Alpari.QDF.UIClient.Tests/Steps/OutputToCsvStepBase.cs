using System.Collections.Generic;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class OutputToCsvStepBase : StepCentral
    {
        public static readonly string FullName = typeof (OutputToCsvStepBase).FullName;

        protected internal OutputToCsvStepBase()
        {
            Exporter = new Exporter(RedisConnectionHelper);
        }

        protected Exporter Exporter { get; private set; }
        protected List<Deal> ImportedDeals { get; set; }

        protected string GetVerificationErrorsForSymbolCounts(Table table)
        {
            return VerificationErrorsForSymbolCounts(table, ImportedDeals);
        }

        protected string GetVerificationErrorsForServerCounts(Table table)
        {
            return VerificationErrorsForServerCounts(table, ImportedDeals);
        }
    }
}