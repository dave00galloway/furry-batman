using System;
using System.Configuration;
using Alpari.QA.QDF.Test.Domain.DataContexts.MT5;
using Alpari.QA.QDF.Test.Domain.WebClients;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Steps;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Hooks
{
    [Binding]
    public class WebClientHooks : SpecFlowExtensionsHooks
    {
        protected const string WEBCLIENT_TAG = "WebClient";
        protected const string CNX_HUBADMIN_CERTIFICATE = "cnxHubAdminCertificate";
        protected const string CNX_HUBADMIN_PASSWORD = "cnxHubAdminPassword";
        protected const string CNX_HUBADMIN_URL = "cnxHubAdminUrl";

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
            // create a new instance of WebClient
            var currenexHubAdminWebClient = new CurrenexHubAdminWebClient(ConfigurationManager.AppSettings[CNX_HUBADMIN_CERTIFICATE],
                ConfigurationManager.AppSettings[CNX_HUBADMIN_PASSWORD],
                 ConfigurationManager.AppSettings[CNX_HUBADMIN_URL]);
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
                    StepCentral.CnxHubAdminWebClientSteps.LogOut();
                    StepCentral.CnxHubAdminWebClientSteps.CurrenexHubAdminWebClient.Dispose();
                }
                catch (Exception e)
                {
                    e.ConsoleExceptionLogger();
                }
            }
        }
    }
}
