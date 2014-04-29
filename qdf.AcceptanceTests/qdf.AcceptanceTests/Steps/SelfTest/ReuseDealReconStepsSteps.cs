using TechTalk.SpecFlow;

namespace qdf.AcceptanceTests.Steps.SelfTest
{
    [Binding]
    public class ReuseDealReconStepsSteps : DealReconciliationStepBase
    {
        [Given(@"I have connected to ""(.*)""")]
        public void GivenIHaveConnectedTo(string connectionName)
        {
            DealReconciliationSteps steps = DealReconciliationSteps;
            DealReconciliationStepBase stepBase = DealReconciliationStepBase;
            ScenarioContext.Current["holdThis"] = stepBase;
            steps.GivenIHaveCreatedAConnectionTo(connectionName);
        }

    }
}
