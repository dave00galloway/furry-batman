using System.Collections.Generic;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.X64.Transforms
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
        public static LogFileSplitParams<int, int> LogFileSplitIntParametersTransform(this Table table)
        {
            return table.CreateInstance<LogFileSplitParams<int, int>>();
        }

        [StepArgumentTransformation]
        public static IEnumerable<LogFileSplitParams<int, int>> LogFileSplitIntParameterSetTransform(this Table table)
        {
            return table.CreateSet<LogFileSplitParams<int, int>>();
        }

        //public static void MyVoid()
        //{
            
        //}
    }
}