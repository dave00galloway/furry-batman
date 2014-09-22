using Alpari.QA.CC.MT4Positions2RedisTests.Steps;
using AlpariUK.Mt4.Wrapper;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Hooks
{
    [Binding]
    public class Mt4ApiHooks
    {
        //[BeforeScenario]
        //public void BeforeScenario()
        //{
        //    //TODO: implement logic that has to run before executing each scenario
        //}

        [AfterScenario]
        public void AfterScenario()
        {
            if (StepCentral.Mt4DotNetManagerWrapperSteps.Manager != null)
            {
                Manager manager = StepCentral.Mt4DotNetManagerWrapperSteps.Manager;
                manager.Disconnect();
                manager.Dispose();
            }
        }
    }
}