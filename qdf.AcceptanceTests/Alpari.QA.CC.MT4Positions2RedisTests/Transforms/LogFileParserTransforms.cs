using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Transforms
{
    [Binding]
    public class LogFileParserTransforms
    {
        [StepArgumentTransformation]
        public static LogFileParserParameters LogFileParserParametersTransform(Table table)
        {
            return table.CreateInstance<LogFileParserParameters>();
        }
    }
}