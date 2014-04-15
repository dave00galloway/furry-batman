using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;
using NUnit.Framework;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class TextToXmlReconciliationSteps : CrossStepDefinitionStepBase
    {
        [When(@"I call a pending step")]
        public void WhenICallAPendingStep()
        {
            ScenarioContext.Current.Pending();
        }

        [When(@"I call a failing step")]
        public void WhenICallAFailingStep()
        {
            Assert.AreEqual(false, true);
        }

    }
}
