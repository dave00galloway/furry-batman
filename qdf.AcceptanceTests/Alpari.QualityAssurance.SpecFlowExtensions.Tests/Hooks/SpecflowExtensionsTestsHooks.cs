using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Tests.Hooks
{
    [Binding]
    public class SpecflowExtensionsTestsHooks : SpecFlowExtensionsHooks
    {

        [BeforeScenario]
        public void BeforeScenario()
        {
            SetupObjectContainerAndTagsProperties();
            MasterStepBase.InstantiateTestRunContext();
            MasterStepBase.SetupFeatureOutputDirectoryTimestampFirst();
            MasterStepBase.SetupScenarioOutputDirectoryTimestampFirst();
        }

        //[AfterScenario]
        //public void AfterScenario()
        //{
        //    //TODO: implement logic that has to run after executing each scenario
        //}
    }
}
