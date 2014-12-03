using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
using System.Collections.Generic;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Transforms
{
    [Binding]
    public class Mt4CompositeApiTransforms
    {
        [StepArgumentTransformation]
        public static Mt4TradeBulkLoadParameters Mt4TradeBulkLoadParametersTransform(Table table)
        {
            return table.CreateInstance<Mt4TradeBulkLoadParameters>();
        }

        [StepArgumentTransformation]
        public static IEnumerable<Mt4TradeBulkLoadParameters> Mt4TradeBulkLoadParameterSetTransform(Table table)
        {
            return table.CreateSet<Mt4TradeBulkLoadParameters>();
        }
    }
}
