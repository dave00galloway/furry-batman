using System.Threading.Tasks;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Transforms
{
    [Binding]
    public static class LogFileSplitterTransforms
    {
        [StepArgumentTransformation]
        public static LogFileSplitParams<string,string> LogFileSplitParametersTransform(this Table table)
        {
            return table.CreateInstance<LogFileSplitParams<string,string>>();
        }

        [StepArgumentTransformation]
        public static LogFileSplitParams<int, int> LogFileSplitIntParametersTransform(Table table)
        {
            return table.CreateInstance<LogFileSplitParams<int, int>>();
        }
    }
}