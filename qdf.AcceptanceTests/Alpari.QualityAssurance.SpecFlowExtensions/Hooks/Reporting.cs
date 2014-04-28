using System;
using System.Linq;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Hooks
{
    [Binding]
    public class Reporting
    {
        // For additional details on SpecFlow hooks see http://go.specflow.org/doc-hooks

        [BeforeScenario("textToXmlReconciliation")]
        public void BeforeScenario()
        {
            Console.WriteLine(ScenarioContext.Current.ScenarioInfo.Title);
            //TODO:- parameterise the replacement tag so that it's not Jira project specific!
            // string tags = JoinedTags().Replace("TES_", "TES-");
            Console.WriteLine("Tags:- @{0}", JoinedTags());
            Console.WriteLine("");
        }

        private static string JoinedTags()
        {
            return String.Join(", @", ScenarioContext.Current.ScenarioInfo.Tags.Select(x => x).ToArray());
        }
    }
}