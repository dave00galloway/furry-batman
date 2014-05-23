using System.Globalization;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using qdf.AcceptanceTests.DataContexts;
using qdf.AcceptanceTests.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using TechTalk.SpecFlow;

namespace qdf.AcceptanceTests.Steps
{
    /// <summary>
    ///     Horrendous code duplication here as the same data needs to be retrieved from a different table in the same data
    ///     base. if the database was different, a different conection parameter could be sent and then all the code would
    ///     work. Creating an abstract base class and mapping the columns also works, but forces retrieval of all data in the
    ///     table. If it is likely that the same data is going to be needed from a different table in the same database, then
    ///     the IDataContextSubstitute approach should be used instead
    /// </summary>
    [Binding, Scope(Tag = "SnapOnCc")]
    public class QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcSteps : QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcStepBase
    {
        public new static readonly string FullName = typeof(QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcSteps).FullName;

        public QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCcSteps(SignalsCompareDataSnapOnCc signalsCompareDataSnapOnCc,
            DiffDeltaFinder diffDeltaFinder)
            : base(signalsCompareDataSnapOnCc, diffDeltaFinder)
        {
        }


        [Given(@"I have connected to SignalsCompareData")]
        public void GivenIHaveConnectedToSignalsCompareData()
        {
            SignalsCompareDataSnapOnCcDataContext.Should().NotBeNull();
        }

        [When(@"I query SignalsCompareData for server ""(.*)""")]
        public void WhenIQuerySignalsCompareDataForServer(string serverName)
        {
            string server =
                SignalsCompareDataSnapOnCcDataContext.CompareDataSnapOnCCs.Where(x => x.Server == serverName)
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
            DiffDeltaFinder.AnalyseDiffDeltas(DiffDeltaParameters, SignalsCompareDataSnapOnCcDataContext);
        }

        [When(@"I analyse the diff deltas by timeslice and output to ""(.*)""")]
        public void WhenIAnalyseTheDiffDeltasByTimesliceAndOutputTo(string exportMethod)
        {
            foreach (DiffDeltaParameters diffDeltaParameters in DiffDeltaParameterList)
            {
                string paramSetName = diffDeltaParameters.Book + diffDeltaParameters.Symbol + diffDeltaParameters.Server;
                DiffDeltaParameters = diffDeltaParameters;
                DiffDeltaFinder.AnalyseDiffDeltas(DiffDeltaParameters, SignalsCompareDataSnapOnCcDataContext);
                List<DiffDeltaResult> diffDeltaQuery;
                List<DiffDeltaSummary> diffDeltaSummaryQuery;
                GetDeltaDiffsAndOutput(exportMethod, out diffDeltaQuery, out diffDeltaSummaryQuery,
                    paramSetName + "DiffDeltaSummary", paramSetName + "DiffDeltas");
                DiffDeltaList.Add(diffDeltaQuery);
                DiffDeltaSummary.Add(paramSetName,diffDeltaSummaryQuery);

                ResetDataContext();
                //GC.Collect(); doesn't help!
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


        [Then(@"I can summarise the analysis and output the result to ""(.*)""")]
        public void ThenICanSummariseTheAnalysisAndOutputTheResultTo(string exportMethod)
        {
            AnalyseAndExportDiffDeltasByCombination(exportMethod);
            AnalyseAndExportDiffDeltasByBook(exportMethod);
        }


    }
}
