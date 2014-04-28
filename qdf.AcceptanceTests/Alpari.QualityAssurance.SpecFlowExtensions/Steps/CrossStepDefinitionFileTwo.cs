using Alpari.QualityAssurance.SpecFlowExtensions.Context;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class CrossStepDefinitionFileTwo : CrossStepDefinitionStepBase
    {
        [Given(@"I create an instance of step definition one from step definition two")]
        public void GivenICreateAnInstanceOfStepDefinitionOneFromStepDefinitionTwo()
        {
            CrossStepDefinitionFileOne stepDefOne = GetCrossStepDefinitionFileOne;
                // don't need to qualify this, but it's clearer if you do
            //using Alpari.QualityAssurance.SpecFlowExtensions.Context;
            stepDefOne.SetLazyProperty = TestRunContext.GenerateRandomStringFromFileName();
        }

        [When(@"I call a method in step definition two that calls the same method in step definition file one")]
        public void WhenICallAMethodInStepDefinitionTwoThatCallsTheSameMethodInStepDefinitionFileOne()
        {
            CrossStepDefinitionFileOne stepDefOne = GetCrossStepDefinitionFileOne;
                // don't need to qualify this, but it's clearer if you do
            string currentLazyPropertyValue = stepDefOne.LazyProperty;
            stepDefOne.GivenIHaveCalledAMethodWhichSetsALazyPropertyInStepDefinitionFileOne();
            string newLazyPropertyValue = stepDefOne.LazyProperty;
            ScenarioContext.Current["currentLazyPropertyValue"] = currentLazyPropertyValue;
            ScenarioContext.Current["newLazyPropertyValue"] = newLazyPropertyValue;

            #region syntactically the same as

            /*if (!ScenarioContext.Current.ContainsKey("newLazyPropertyValue"))
             *{
             * ScenarioContext.Current.Add("newLazyPropertyValue", newLazyPropertyValue);
             *}
             * but the direct accessor code is easier to read. may be marginally slower in some circumstances
             */

            #endregion
        }

        [Given(@"I call a method in step definition two that calls the same method in step definition file one")]
        public void GivenICallAMethodInStepDefinitionTwoThatCallsTheSameMethodInStepDefinitionFileOne()
        {
            WhenICallAMethodInStepDefinitionTwoThatCallsTheSameMethodInStepDefinitionFileOne();
        }
    }
}