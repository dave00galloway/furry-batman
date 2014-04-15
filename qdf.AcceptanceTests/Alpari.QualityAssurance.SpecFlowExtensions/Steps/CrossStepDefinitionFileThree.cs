using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class CrossStepDefinitionFileThree : CrossStepDefinitionStepBase
    {
        [Then(@"The current and new lazy property values are the same")]
        public void ThenTheCurrentAndNewLazyPropertyValuesAreTheSame()
        {
            Assert.AreEqual(ScenarioContext.Current["currentLazyPropertyValue"], ScenarioContext.Current["newLazyPropertyValue"]);
        }
    }
}
