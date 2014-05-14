using TechTalk.SpecFlow;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class QdfAnalysisOfArsCcEcnDiffDeltasSteps : QdfAnalysisOfArsCcEcnDiffDeltasStepBase
    {
        public new static readonly string FullName = typeof(QdfAnalysisOfArsCcEcnDiffDeltasSteps).FullName;

        [Given(@"I want to analyse diff deltas by timeslice in")]
        public void GivenIWantToAnalyseDiffDeltasByTimesliceIn(Table table)
        {
            ScenarioContext.Current.Pending();
        }

        [When(@"I analyse the diff deltas by timeslice")]
        public void WhenIAnalyseTheDiffDeltasByTimeslice()
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"The diff delta analysis is output to ""(.*)""")]
        public void ThenTheDiffDeltaAnalysisIsOutputTo(string p0)
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"no diff delta is greater than (.*) percent of the mean position for the timeslice")]
        public void ThenNoDiffDeltaIsGreaterThanPercentOfTheMeanPositionForTheTimeslice(int p0)
        {
            ScenarioContext.Current.Pending();
        }
    }
}
