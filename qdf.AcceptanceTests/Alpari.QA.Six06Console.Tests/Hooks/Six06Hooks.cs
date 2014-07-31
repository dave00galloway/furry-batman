using Alpari.QA.QDF.Test.Domain.DataContexts.MT5;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using System.Configuration;
using System.IO;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;
using StepCentral = Alpari.QA.Six06Console.Tests.Steps.StepCentral;

namespace Alpari.QA.Six06Console.Tests.Hooks
{
    [Binding]
    public class Six06Hooks : SpecFlowExtensionsHooks
    {
        [BeforeScenario]
        public void BeforeScenario()
        {
            File.Copy(StepCentral.FRESH606_POINT5_CONSOLE_CONFIG_CONSOLE_INI, StepCentral.WORKING606_POINT5_CONSOLE_INI, true);
            SetupObjectContainerAndTagsProperties();
            MasterStepBase.SetupScenarioOutputDirectoryTimestampFirst();
            SetupMt5DealsDataContext();
        }

        private void SetupMt5DealsDataContext()
        {
            if (TagDependentAction(StepCentral.MT5_DEALS_CONTEXT))
            {
                SetupMt5DealsContext();
            }
        }

        public static DealsDataContext SetupMt5DealsContext()
        {
            var connectionString =
                ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings[StepCentral.MT5_DB]]
                    .ConnectionString;
            var context = new DealsDataContext(connectionString, ConfigurationManager.AppSettings[StepCentral.MT5_DB]);
            if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(context);
            return context;
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

        [AfterScenario]
        public void AfterScenario()
        {
            //TODO: implement logic that has to run after executing each scenario
        }
    }
}