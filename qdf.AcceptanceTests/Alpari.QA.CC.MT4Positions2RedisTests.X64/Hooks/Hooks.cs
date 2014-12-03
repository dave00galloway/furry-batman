using Alpari.QualityAssurance.SpecFlowExtensions.Tests.Hooks;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.X64.Hooks
{
    [Binding]
    public class Hooks : SpecflowExtensionsTestsHooks
    {
        // For additional details on SpecFlow hooks see http://go.specflow.org/doc-hooks

        [BeforeScenario]
        public new void BeforeScenario()
        {
            base.BeforeScenario();
        }

    }
}
