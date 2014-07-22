using FluentAssertions;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.ProcessRunner.Tests.Steps
{
    [Binding]
    public class LaunchProcessSteps : LaunchProcessStepBase
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
            ProcessRunner.NewProcessStarted.Should().Be(true);
            ProcessRunner.Process.StartTime.Should().BeOnOrAfter(TestRunContext.DateTimeNow);
        }

        [Then(@"the standard output contains text ""(.*)""")]
        public void ThenTheStandardOutputContainsText(string expectedText)
        {
            ProcessRunner.StandardOutputList.Should().Contain(expectedText);
        }


    }
}


