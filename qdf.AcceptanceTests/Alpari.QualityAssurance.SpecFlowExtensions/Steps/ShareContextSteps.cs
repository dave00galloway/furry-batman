using System;
using Alpari.QualityAssurance.SpecFlowExtensions.Context;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class ShareContextSteps : CrossStepDefinitionStepBase
    {
        private static readonly string RANDOM_FILENAME = "randomFileName";
        private static readonly string TIME_NOW_IS = "timeNowIs";

        [Given(@"I access the static object")]
        public void GivenIAccessTheStaticObject()
        {
            var timeNowIs = TestRunContext.StaticTime;
            var randomFileName = TestRunContext.StaticRandom;
            ScenarioContext.Current.Add(TIME_NOW_IS, timeNowIs);
            ScenarioContext.Current.Add(RANDOM_FILENAME, randomFileName);

            if (!FeatureContext.Current.ContainsKey(TIME_NOW_IS))
            {
                FeatureContext.Current.Add(TIME_NOW_IS, timeNowIs);
            }

            if (!FeatureContext.Current.ContainsKey(RANDOM_FILENAME))
            {
                FeatureContext.Current.Add(RANDOM_FILENAME, randomFileName);
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