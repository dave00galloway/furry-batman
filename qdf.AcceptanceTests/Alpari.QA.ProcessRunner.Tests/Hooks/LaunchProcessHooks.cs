using System;
using System.Diagnostics;
using System.Threading;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;
using StepCentral = Alpari.QA.ProcessRunner.Tests.Steps.StepCentral;

namespace Alpari.QA.ProcessRunner.Tests.Hooks
{
    [Binding]
    public class LaunchProcessHooks
    {
        // For additional details on SpecFlow hooks see http://go.specflow.org/doc-hooks

        [BeforeScenario]
        public void BeforeScenario()
        {
            //TODO: implement logic that has to run before executing each scenario
        }

        [AfterScenario]
        public void AfterScenario()
        {
            var processStartInfoWrapper =
                ScenarioContext.Current[StepCentral.PROCESS_START_INFO_WRAPPER] as ProcessStartInfoWrapper;
            var processRunner = ScenarioContext.Current[StepCentral.PROCESS_RUNNER] as IProcessRunner;
            if (processRunner != null)
            {
                processRunner.Dispose();
                //GC.Collect(); //really shouldn't need this!
                //Thread.Sleep(new TimeSpan(0, 0, 0, 1));
                //    // adding a long timeout doesn't help, and you can clearly see the previous cmd windows open, excpt for the first one
                //GC.Collect(); //really shouldn't need this!
            }
        }

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            MasterStepBase.InstantiateTestRunContext();
        }
    }
}