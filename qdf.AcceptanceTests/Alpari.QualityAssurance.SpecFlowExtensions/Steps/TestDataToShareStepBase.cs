using Alpari.QualityAssurance.SpecFlowExtensions.Specs;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class TestDataToShareStepBase : StepCentral
    {
        public TestDataToShareStepBase()
            : base(true)
        {
        }

        [BeforeScenario("DataSetup")]
        public void BeforeScenario()
        {
            //save the current Scenario and Feature contexts
            var featureContext = FeatureContext.Current;
            var scenarioContext = ScenarioContext.Current;

            var testDataToShareFeature = new TestDataToShareFeature();
            testDataToShareFeature.FeatureSetup();
            testDataToShareFeature.ScenarioSetup(new ScenarioInfo("setup", new string[] {}));
            testDataToShareFeature.SetupTestData();
            //problem - if these cleanup/teardowns aren't called then there is a warning in the output
            // if they are called, the present scenario is killed. May have to add an after sceanrio hook to call these cleanup/Teardowns to avoid a memory leak, and just live with the warnings.
            //TestDataToShareFeature.ScenarioCleanup();
            //TestDataToShareFeature.ScenarioTearDown();
            //TestDataToShareFeature.FeatureTearDown();
            TestRunContext["TestDataToShareFeature"] = testDataToShareFeature;

            //reanimate the contexts - todo - get the type of the feature from the feature context
            //FeatureContext.Current = featureContext; -- can't do this - read only
            //ScenarioContext.Current = scenarioContext; -- can't do this - read only
            var testDataToShareClientTwoFeature = new TestDataToShareClientTwoFeature();
            testDataToShareClientTwoFeature.FeatureSetup();
            testDataToShareClientTwoFeature.ScenarioSetup(scenarioContext.ScenarioInfo);
                //works, but calls the scenario setup which calls this event again!
        }

        [AfterScenario("DataSetup")]
        public void AfterScenario()
        {
            var testDataToShareFeature = (TestDataToShareFeature) TestRunContext["TestDataToShareFeature"];
            testDataToShareFeature.ScenarioCleanup();
            testDataToShareFeature.ScenarioTearDown();
            testDataToShareFeature.FeatureTearDown();
        }

        /// <summary>
        ///     Simulating setting up template base data and saving to Test Run Context
        ///     Real uses of this should have specific methods for setting up specific data templates and not rely on the name
        ///     parameter
        ///     THey should also set up data in subclasses of TestRunContext so that specific data types can be assigned to
        ///     properties as write once read many
        ///     Using a dictionary means the data an be overwritten, which is likely not the intended use of the templated data
        /// </summary>
        /// <param name="name"></param>
        /// <param name="data"></param>
        [Given(@"I have setup the following templated test data as ""(.*)"":")]
        public void GivenIHaveSetupTheFollowingTemplatedTestDataAs(string name, Table data)
        {
            TestRunContext[name] = DataTableOperations.GetTableAsList(data);
        }

        /// <summary>
        ///     This demonstrates that the testRunContext shouldn't be used in its default mode to store data that we don't want to
        ///     change throughout the entire test run
        ///     a subclass should be used with appropriate properties for such persisted data
        ///     Generally you don't want to assert in a given step either...
        /// </summary>
        /// <param name="name"></param>
        [Given(@"the Test Run Context does not contain templated data named ""(.*)""")]
        public void GivenTheTestRunContextDoesNotContainTemplatedDataNamed(string name)
        {
            if (TestRunContext.ContainsKey(name))
            {
                TestRunContext.Remove(name);
            }
            TestRunContext.Should().NotContainKey(name);
        }

        [Given(@"the Test Run Context does contain templated data named ""(.*)""")]
        public void GivenTheTestRunContextDoesContainTemplatedDataNamed(string name)
        {
            TestRunContext.Should().ContainKey(name);
        }


        [When(@"I create or retrieve the templated data named ""(.*)"" as ""(.*)""")]
        public void WhenICreateOrRetrieveTheTemplatedDataNamedAs(string baseName, string newName)
        {
            if (!TestRunContext.ContainsKey(baseName))
            {
                var testDataToShareFeature = new TestDataToShareFeature();
                testDataToShareFeature.FeatureSetup();
                testDataToShareFeature.ScenarioSetup(ScenarioContext.Current.ScenarioInfo);
                testDataToShareFeature.SetupTestData();
                //problem - if these cleanup/teardowns aren't called then there is a warning in the output
                // if they are called, the present scenario is killed. May have to add an after sceanrio hook to call these cleanup/Teardowns to avoid a memory leak, and just live with the warnings.
                //TestDataToShareFeature.ScenarioCleanup();
                //TestDataToShareFeature.ScenarioTearDown();
                //TestDataToShareFeature.FeatureTearDown();
            }
            ScenarioContext.Current[newName] = TestRunContext[baseName];
        }

        [Then(@"the templated data ""(.*)"" is the same as the templated data ""(.*)""")]
        public void ThenTheTemplatedDataIsTheSameAsTheTemplatedData(string source, string destination)
        {
            ScenarioContext.Current[source].ShouldBeEquivalentTo(ScenarioContext.Current[destination]);
        }
    }
}