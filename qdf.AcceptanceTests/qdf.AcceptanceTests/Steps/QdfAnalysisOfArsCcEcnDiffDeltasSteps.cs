using System;
using FluentAssertions;
using qdf.AcceptanceTests.DataContexts;
using qdf.AcceptanceTests.Helpers;
using System.Collections.Generic;
using System.Linq;
using TechTalk.SpecFlow;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class QdfAnalysisOfArsCcEcnDiffDeltasSteps : QdfAnalysisOfArsCcEcnDiffDeltasStepBase
    {
        public new static readonly string FullName = typeof(QdfAnalysisOfArsCcEcnDiffDeltasSteps).FullName;
        

        public QdfAnalysisOfArsCcEcnDiffDeltasSteps(SignalsCompareData signalsCompareData, DiffDeltaFinder diffDeltaFinder)
            : base(signalsCompareData, diffDeltaFinder)
        {
        }


        [Given(@"I have connected to SignalsCompareData")]
        public void GivenIHaveConnectedToSignalsCompareData()
        {
            SignalsCompareDataDataContext.Should().NotBeNull();
        }

        [When(@"I query SignalsCompareData for server ""(.*)""")]
        public void WhenIQuerySignalsCompareDataForServer(string serverName)
        {
            var server =
                SignalsCompareDataDataContext.CompareDatas.Where(x => x.Server == serverName)
                    .Select(x => x.Server)
                    .First();
            ScenarioContext.Current["ServerName"] = server;

        }

        [Then(@"the server should be ""(.*)""")]
        public void ThenTheServerShouldBe(string serverName)
        {
            ScenarioContext.Current["ServerName"].ToString().Should().Be(serverName);
        }

        [Given(@"I want to analyse diff deltas by timeslice in")]
        public void GivenIWantToAnalyseDiffDeltasByTimesliceIn(DiffDeltaParameters diffDeltaParameters)
        {
            DiffDeltaParameters = diffDeltaParameters;
        }

        [Given(@"I want to analyse these diff deltas by timeslice in")]
        public void GivenIWantToAnalyseTheseDiffDeltasByTimesliceIn(List<DiffDeltaParameters> diffDeltaParameters)
        {
            DiffDeltaParameterList = diffDeltaParameters;
        }


        [When(@"I analyse the diff deltas by timeslice")]
        public void WhenIAnalyseTheDiffDeltasByTimeslice()
        {
            DiffDeltaFinder.AnalyseDiffDeltas(DiffDeltaParameters, SignalsCompareDataDataContext);
        }

        [When(@"I analyse the diff deltas by timeslice and output to ""(.*)""")]
        public void WhenIAnalyseTheDiffDeltasByTimesliceAndOutputTo(string exportMethod)
        {
            foreach (DiffDeltaParameters diffDeltaParameters in DiffDeltaParameterList)
            {
                var paramSetName = diffDeltaParameters.Book + diffDeltaParameters.Symbol + diffDeltaParameters.Server;
                DiffDeltaParameters = diffDeltaParameters;
                DiffDeltaFinder.AnalyseDiffDeltas(DiffDeltaParameters, SignalsCompareDataDataContext);
                List<DiffDeltaResult> diffDeltaQuery;
                List<DiffDeltaSummary> diffDeltaSummaryQuery;
                GetDeltaDiffsAndOutput(exportMethod, out diffDeltaQuery, out diffDeltaSummaryQuery, paramSetName + "DiffDeltaSummary", paramSetName+"DiffDeltas");
                DiffDeltaList.Add(diffDeltaQuery);
                DiffDeltaSummary.Add(diffDeltaSummaryQuery);
                GC.Collect();
            }
        }


        [Then(@"The diff delta analysis is output to ""(.*)""")]
        public void ThenTheDiffDeltaAnalysisIsOutputTo(string exportMethod)
        {
            List<DiffDeltaResult> diffDeltaQuery;
            List<DiffDeltaSummary> diffDeltaSummaryQuery;
            GetDeltaDiffsAndOutput(exportMethod, out diffDeltaQuery, out diffDeltaSummaryQuery);
        }

        [Then(@"no diff delta is greater than (.*) percent of the mean position for the timeslice")]
        public void ThenNoDiffDeltaIsGreaterThanPercentOfTheMeanPositionForTheTimeslice(int p0)
        {
            ScenarioContext.Current.Pending();
        }

        [Then(@"the number of parameter sets is (.*)")]
        public void ThenTheNumberOfParameterSetsIs(int expectedCount)
        {
            DiffDeltaParameterList.Should().HaveCount(expectedCount);
        }

    }
}
