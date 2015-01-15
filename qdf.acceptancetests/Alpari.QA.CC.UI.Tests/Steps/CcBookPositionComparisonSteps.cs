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

        [When(@"I configure the position pages")]
        public void WhenIConfigureThePositionPages()
        {
            //Do Nothing - setting the parameters in
            //this.GivenIHaveTheFollowingCcComparisonParameterSets(new []{new CcComparisonParameters()});
            //opens the pages and configures the comparisons already. 
            //Debateble whether this is good design or not - do we expose the page object to the step def directly as a property of the comparison process object, or do we add a method to the process object which we then have to call even if we aren't testing the configuration?
            // decided to expose the pages as read only properties. possible pandora's box...
            // the configure method first does a check, and if all is well, does nothing, but if configuration is needed, it will perfrom it.
            foreach (var comparison in _comparisons)
            {
                //TODO:- add a parallel task method in ICcPositionTableComparison - if we do that we can close the 'Pandora's box' and make the page objects private again
                comparison.CurrentPositionsPage.ConfigurePositionTable(comparison.CcComparisonParameters);
                comparison.NewPositionsPage.ConfigurePositionTable(comparison.CcComparisonParameters);
            }
        }

        [Then(@"the position pages have this configuration:-")]
        public void ThenThePositionPagesHaveThisConfiguration(
            IList<CcComparisonParameters> comparisonParameters)
        {
            foreach (var comparison in _comparisons)
            {
                //TODO:- add a parallel task method in ICcPositionTableComparison
                comparison.CurrentPositionsPage.CheckComparisonParameters(comparison.CcComparisonParameters);
                comparison.NewPositionsPage.CheckComparisonParameters(comparison.CcComparisonParameters);
            }
        }


        [When(@"I monitor the current positions in parallel")]
        public void WhenIMonitorTheCurrentPositionsInParallel()
        {
            var tasks = new[]
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