using System.IO;
using Alpari.QA.Six06Console.Tests.Steps;
using TechTalk.SpecFlow;

namespace Alpari.QA.Six06Console.Tests.Hooks
{
    [Binding]
    public class Six06Hooks
    {
        [BeforeScenario]
        public void BeforeScenario()
        {
            File.Copy(StepCentral.FRESH606_POINT5_CONSOLE_CONFIG_CONSOLE_INI, StepCentral.WORKING606_POINT5_CONSOLE_INI, true);
        }

        [AfterScenario]
        public void AfterScenario()
        {
            //TODO: implement logic that has to run after executing each scenario
        }
    }
}