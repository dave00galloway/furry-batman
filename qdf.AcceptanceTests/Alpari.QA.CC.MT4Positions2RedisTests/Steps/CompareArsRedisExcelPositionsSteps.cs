using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.CapitalCalculation;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class CompareArsRedisExcelPositionsSteps : StepCentral
    {
        [When(@"I compare cc redis and cc ars client position data from xlsx:-")]
        public void WhenICompareCcRedisAndCcArsClientPositionDataFromXlsx_(Table table)
        {
            var comparisonDetails = table.CreateInstance<CcPositionExcelExportComparison.ComparisonDetails>();
            ClientPositionDataTable arsData;
            var redisData = comparisonDetails.ClientPositionDataTable(out arsData);
            ScenarioContext.Current["diffs"] = redisData.Compare(arsData, new[] {"ServerName", "ServerId"});
        }
    }
}