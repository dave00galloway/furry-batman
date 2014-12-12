using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.UI.Tests.Hooks
{
    [Binding]
    public class ComparisonHooks : SpecFlowExtensionsHooks
    {
        [BeforeScenario]
        public void BeforeScenario()
        {
            MasterStepBase.SetupScenarioOutputDirectoryTimestampFirst();
        }

        [BeforeFeature]
        public static void BeforeFeature()
        {
            MasterStepBase.SetupFeatureOutputDirectoryTimestampFirst();
        }

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            MasterStepBase.InstantiateTestRunContext();
        }
    }
}