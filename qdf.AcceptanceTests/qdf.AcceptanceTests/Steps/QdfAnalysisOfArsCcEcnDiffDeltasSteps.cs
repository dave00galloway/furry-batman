using System;
using System.Collections.Generic;
using System.Globalization;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using qdf.AcceptanceTests.DataContexts;
using System.Linq;
using qdf.AcceptanceTests.Helpers;
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

        [When(@"I analyse the diff deltas by timeslice")]
        public void WhenIAnalyseTheDiffDeltasByTimeslice()
        {
            DiffDeltaFinder.AnalyseDiffDeltas(DiffDeltaParameters, SignalsCompareDataDataContext);
        }

        [Then(@"The diff delta analysis is output to ""(.*)""")]
        public void ThenTheDiffDeltaAnalysisIsOutputTo(string exportMethod)
        {
            List<DiffDeltaResult> diffDeltaQuery = DiffDeltaFinder.DiffDeltas.SelectMany(diffDelta => diffDelta.CompareData,
                (diffDelta, compareData) =>
                    new DiffDeltaResult
                    {
                        HiSource = diffDelta.HiSource.ToString(),
                        LoSource = diffDelta.LoSource.ToString(),
                        Diff = diffDelta.Diff,
                        Delta = diffDelta.Delta,
                        Id = compareData.Id,
                        Position = compareData.Position,
                        TimeStamp = compareData.TimeStamp
                    }).ToList();


            switch ((ExportTypes) Enum.Parse(typeof (ExportTypes), exportMethod))
            {
                case ExportTypes.Csv:
                    diffDeltaQuery.EnumerableToCsv(DealReconciliationStepBase.ScenarioOutputDirectory+"diffDeltas.csv", false);
                    break;
                case ExportTypes.Console:
                    throw new NotImplementedException();
                case ExportTypes.Database:
                    throw new NotImplementedException();

                    //case ExportTypes.Unknown:
                default:
                    throw new ArgumentException(exportMethod.ToString(CultureInfo.InvariantCulture));
            }
        }

        [Then(@"no diff delta is greater than (.*) percent of the mean position for the timeslice")]
        public void ThenNoDiffDeltaIsGreaterThanPercentOfTheMeanPositionForTheTimeslice(int p0)
        {
            ScenarioContext.Current.Pending();
        }
    }
}
