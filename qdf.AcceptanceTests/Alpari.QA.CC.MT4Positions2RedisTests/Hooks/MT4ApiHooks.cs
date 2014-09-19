using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QA.CC.MT4Positions2RedisTests.Steps;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Hooks
{
    [Binding]
    public class MT4ApiHooks
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
            if (StepCentral.Mt4DotNetManagerWrapperSteps.Manager != null)
            {
                var manager = StepCentral.Mt4DotNetManagerWrapperSteps.Manager;
                manager.Disconnect();
                manager.Dispose();
            }
        }
    }
}
