using System;
using Alpari.QA.QDF.Test.Domain.WebClients;
using Alpari.QDF.ConversionRateData.Steps;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using TechTalk.SpecFlow;

namespace Alpari.QDF.ConversionRateData.Hooks
{
    [Binding]
    public class WebClientHooks : SpecFlowExtensionsHooks
    {
        protected const string WEBCLIENT_TAG = "WebClient";

        [BeforeScenario]
        public void BeforeScenario()
        {
            if (ObjectContainer == null)
            {
                SetupObjectContainerAndTagsProperties();
            }
            if (TagDependentAction(WEBCLIENT_TAG))
            {
                try
                {
                    SetupCurrenexHubAdminWebClient();
                }
                catch (Exception e)
                {
                    e.ConsoleExceptionLogger();
                }
            }
        }

        public static CurrenexHubAdminWebClient SetupCurrenexHubAdminWebClient()
        {
            var currenexHubAdminWebClient = CurrenexHubAdminWebClient.Create();
            if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(currenexHubAdminWebClient);
            return currenexHubAdminWebClient;
        }

        [AfterScenario]
        public void AfterScenario()
        {
            if(TagDependentAction(WEBCLIENT_TAG))
            {
                try
                {
                    StepCentral.ConversionRateDataSteps.LogOut();
                    StepCentral.ConversionRateDataSteps.CurrenexHubAdminWebClient.Dispose();
                }
                catch (Exception e)
                {
                    e.ConsoleExceptionLogger();
                }
            }
        }
    }
}
