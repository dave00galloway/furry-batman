using System.IO;
using TechTalk.SpecFlow;

namespace Alpari.QA.Six06Console.Tests.Hooks
{
    [Binding]
    public class Six06Hooks
    {
        [BeforeScenario]
        public void BeforeScenario()
        {
            File.Copy(@"AUT\QDF\606.5Console\Config\606.5Console.ini", @"AUT\QDF\606.5Console\606.5Console.ini", true);
        }

        [AfterScenario]
        public void AfterScenario()
        {
            //TODO: implement logic that has to run after executing each scenario
        }
    }
}