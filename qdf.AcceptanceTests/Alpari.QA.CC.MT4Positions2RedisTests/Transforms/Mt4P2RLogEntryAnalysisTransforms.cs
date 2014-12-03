using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
using System.Collections.Generic;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Transforms
{
    [Binding]
    public class Mt4P2RLogEntryAnalysisTransforms
    {
        [StepArgumentTransformation]
        public static IEnumerable<Mt4TradeBulkLoadParameters> Mt4TradeBulkLoadParameterSetTransform(Table table)
        {
            return table.CreateSet<Mt4TradeBulkLoadParameters>();
        }
    }
}
