using System;
using Alpari.QA.QDF.Test.Domain.WebClients;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;
using StepCentral = Alpari.QDF.ConversionRateData.Steps.StepCentral;

namespace Alpari.QDF.ConversionRateData.Hooks
{
    [Binding]
    public class WebClientHooks : SpecFlowExtensionsHooks
    {
        protected const string WEBCLIENT_TAG = "WebClient";

        [BeforeScenario]
        public void BeforeScenario()
        {
            MasterStepBase.SetupScenarioOutputDirectoryTimestampFirst();
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

        /// <summary>
        ///     Clear the test output directory for the feature
        ///     to limit this set the tag to
        ///     //[BeforeFeature("CreateOutput")]
        ///     and apply tags to features
        /// </summary>
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
