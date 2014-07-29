using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;
using StepCentral = Alpari.QA.ProcessRunner.Tests.Steps.StepCentral;

namespace Alpari.QA.ProcessRunner.Tests.Hooks
{
    [Binding]
    public class LaunchProcessHooks
    {
        [BeforeScenario]
        public void BeforeScenario()
        {
            //TODO: implement logic that has to run before executing each scenario
        }

        [AfterScenario]
        public void AfterScenario()
        {
            if (ScenarioContext.Current.ContainsKey(StepCentral.PROCESS_RUNNER))
            {
                var processRunner = ScenarioContext.Current[StepCentral.PROCESS_RUNNER] as IProcessRunner;
                if (processRunner != null)
                {
                    processRunner.Dispose();
                }                
            }

        }

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            MasterStepBase.InstantiateTestRunContext();
        }
    }
}