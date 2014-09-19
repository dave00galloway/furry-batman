using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Transforms
{
    [Binding]
    public class Mt4DotNetWrapperTransforms
    {
        [StepArgumentTransformation]
        public static Mt4ApiConnectionParameters Mt4ClientConnectionParametersTransform(Table table)
        {
            return table.CreateInstance<Mt4ApiConnectionParameters>();
        }
    }
}
