using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Tests.Transforms
{
    [Binding]
    public static class LogFileParameterTransforms
    {
        [StepArgumentTransformation]
        public static CombineLogFileParameters CombineLogFileParametersTransform(Table table)
        {
            return table.CreateInstance<CombineLogFileParameters>();
        }
        
    }


}
