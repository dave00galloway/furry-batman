using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace qdf.AcceptanceTests.Steps.SelfTest
{
    [Binding]
    public class ReuseDealReconStepsSteps : DealReconciliationStepBase
    {
        [Given(@"I have connected to ""(.*)""")]
        public void GivenIHaveConnectedTo(string connectionName)
        {
            DealReconciliationSteps steps = StepCentral.DealReconciliationSteps;
            steps.GivenIHaveCreatedAConnectionTo(connectionName);
        }

    }
}
