using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
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
    }
}
