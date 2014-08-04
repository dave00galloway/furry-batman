using System;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Steps;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Hooks
{
    [Binding]
    public class WebClientHooks : SpecFlowExtensionsHooks
    {
        // For additional details on SpecFlow hooks see http://go.specflow.org/doc-hooks

        //[BeforeScenario]
        //public void BeforeScenario()
        //{
        //    //TODO: implement logic that has to run before executing each scenario
        //}

        [AfterScenario]
        public void AfterScenario()
        {
            if(TagDependentAction("WebClient"))
            {
                try
                {
                    StepCentral.Cnx2RedisStepCentral.CnxHubAdminWebClientSteps.LogOut();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                }
            }
        }
    }
}
