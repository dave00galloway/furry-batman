using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Alpari.QA.ProcessRunner;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.ProcessRunner.Tests.Steps
{
    [Binding]
    public class LaunchProcessSteps
    {
        public ProcessStartInfoWrapper ProcessStartInfoWrapper { get; set; }
        public IProcessRunner ProcessRunner { get; set; }

        [StepArgumentTransformation]
        public static ProcessStartInfoWrapper IncludedLoginsTransform(Table table)
        {
            return table.CreateInstance<ProcessStartInfoWrapper>();
        }

        [Given(@"I have the following process parameters")]
        public void GivenIHaveTheFollowingProcessParameters(ProcessStartInfoWrapper processStartInfoWrapper)
        {
            ProcessStartInfoWrapper = processStartInfoWrapper;
        }

        [When(@"I launch the process")]
        public void WhenILaunchTheProcess()
        {
            ProcessRunner = new ProcessRunner(ProcessStartInfoWrapper);
        }

        [Then(@"the process is launched ok")]
        public void ThenTheProcessIsLaunchedOk()
        {
            ScenarioContext.Current.Pending();
        }

    }
}


