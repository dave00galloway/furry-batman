using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Alpari.QA.CC.UI.Tests.BusinessProcesses;
using Alpari.QA.CC.UI.Tests.POCO;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.UI.Tests.Steps
{
    [Binding]
    public class CcBookPositionComparisonSteps : StepCentral
    {
        private readonly List<ICcPositionTableComparison> _comparisons;

        public CcBookPositionComparisonSteps(List<ICcPositionTableComparison> comparisons)
        {
            _comparisons = comparisons;
        }


        [Given(@"I have the following cc comparison parameter sets:-")]
        public void GivenIHaveTheFollowingCcComparisonParameterSets(
            IList<CcComparisonParameters> comparisonParameters)
        {
            for (var i = 0; i < _comparisons.Count; i++)
            {
                _comparisons[i].CcComparisonParameters = comparisonParameters[i];
            }
        }

        [When(@"I monitor the current positions in parallel")]
        public void WhenIMonitorTheCurrentPositionsInParallel()
        {
            var tasks = new Task[2]
            {
                Task.Factory.StartNew(() => 
                    _comparisons.First().MonitorPositionsAndExport(new ExportParameters{
                            ExportType = ExportTypes.DataTableToCsv,
                            Path = ScenarioOutputDirectory,
                        }))
                ,
                Task.Factory.StartNew(
                    () => _comparisons.Last().MonitorPositionsAndExport(
                        new ExportParameters
                        {
                            ExportType = ExportTypes.DataTableToCsv,
                            Path = ScenarioOutputDirectory,
                        }))
            };

            Task.WaitAll(tasks);
        }
    }
}