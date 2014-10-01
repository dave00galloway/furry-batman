using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QA.QDF.Test.Domain.DataContexts.CC;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Transforms
{
    [Binding]
    public class CapitalCalculationSnapshotParametersTransform
    {
        [StepArgumentTransformation]
        public static CapitalCalculationSnapshotParameters CcSnapshotParametersTransform(Table table)
        {
            return table.CreateInstance<CapitalCalculationSnapshotParameters>();
        }

        //[StepArgumentTransformation]
        //public static Mt4TradeBulkLoadParameters Mt4TradeBulkLoadParametersTransform(Table table)
        //{
        //    return table.CreateInstance<Mt4TradeBulkLoadParameters>();
        //}
    }
}
