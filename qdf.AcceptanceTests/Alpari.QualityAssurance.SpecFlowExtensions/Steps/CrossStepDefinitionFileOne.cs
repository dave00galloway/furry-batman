using Alpari.QualityAssurance.SpecFlowExtensions.Context;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class CrossStepDefinitionFileOne : CrossStepDefinitionFileOneStepBase
    {
        new public static readonly string FullName = typeof(CrossStepDefinitionFileOne).FullName;
        public string SetLazyProperty
        {
            set { LazyProperty = value; }
        }

        [Given(@"I have called a method which sets a lazy property in step definition file one")]
        public void GivenIHaveCalledAMethodWhichSetsALazyPropertyInStepDefinitionFileOne()
        {
            LazyProperty = TestRunContext.GenerateRandomStringFromFileName();
        }
    }
}