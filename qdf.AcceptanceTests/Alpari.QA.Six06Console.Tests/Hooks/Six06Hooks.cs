using System.Configuration;
using System.IO;
using Alpari.QA.QDF.Test.Domain;
using Alpari.QA.QDF.Test.Domain.MT5;
using Alpari.QA.Six06Console.Tests.Steps;
using Alpari.QualityAssurance.SpecFlowExtensions.Hooks;
using TechTalk.SpecFlow;

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
            SetupMt5DealsDataContext();
        }

        private void SetupMt5DealsDataContext()
        {
            if (TagDependentAction(StepCentral.MT5_DEALS_CONTEXT))
            {
                var connectionString =
                    ConfigurationManager.ConnectionStrings[ConfigurationManager.AppSettings[StepCentral.MT5_DB]]
                        .ConnectionString;
                var context = new DealsDataContext(connectionString);
                if (ObjectContainer != null) ObjectContainer.RegisterInstanceAs(context);
            }
        }

        [AfterScenario]
        public void AfterScenario()
        {
            //TODO: implement logic that has to run after executing each scenario
        }
    }
}