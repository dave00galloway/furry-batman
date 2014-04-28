using System;
using Alpari.QualityAssurance.SpecFlowExtensions.Context;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class ShareContextSteps : CrossStepDefinitionStepBase
    {
        private const string RandomFilename = "randomFileName";
        private const string TimeNowIs = "timeNowIs";

        [Given(@"I access the static object")]
        public void GivenIAccessTheStaticObject()
        {
            var timeNowIs = TestRunContext.StaticTime;
            var randomFileName = TestRunContext.StaticRandom;
            ScenarioContext.Current.Add(TimeNowIs, timeNowIs);
            ScenarioContext.Current.Add(RandomFilename, randomFileName);

            if (!FeatureContext.Current.ContainsKey(TimeNowIs))
            {
                FeatureContext.Current.Add(TimeNowIs, timeNowIs);
            }

            if (!FeatureContext.Current.ContainsKey(RandomFilename))
            {
                FeatureContext.Current.Add(RandomFilename, randomFileName);
            }
        }

        [When(@"I display the static object ""(.*)"" property")]
        public void WhenIDisplayTheStaticObjectProperty(string propertyName)
        {
            Console.WriteLine("propertyName {0} value is {1}", propertyName, ScenarioContext.Current[propertyName]);
        }

        [Then(@"the static object ""(.*)"" property matches the feature ""(.*)"" property")]
        public void ThenTheStaticObjectPropertyMatchesTheFeatureProperty(string propertyName, string featurePropertyName)
        {
            Assert.AreEqual(ScenarioContext.Current[propertyName], FeatureContext.Current[featurePropertyName]);
        }
    }
}