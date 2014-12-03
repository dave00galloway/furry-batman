using Alpari.QA.QDF.Test.Domain.DataContexts.CC;
using System.Collections.Generic;
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

        [StepArgumentTransformation]
        public static IEnumerable<CapitalCalculationSnapshotParameters> CcSnapshotParameterSetTransform(Table table)
        {
            return table.CreateSet<CapitalCalculationSnapshotParameters>();
        }
    }
}
