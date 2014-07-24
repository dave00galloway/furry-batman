using System;
using FluentAssertions;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.ProcessRunner.Tests.Steps
{
    [Binding]
    public class LaunchProcessSteps : LaunchProcessStepBase
    {
        public new static readonly string FullName = typeof (LaunchProcessSteps).FullName;


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

        [When(@"I send the command ""(.*)"" to standard input")]
        public void WhenISendTheCommandToStandardInput(string input)
        {
            ProcessRunner.SendInput(input);
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
            //ProcessRunner.StandardOutputList.Any(x => x.Contains(expectedText)).Should().Be(true);
            //Thread.Sleep(5000);
            ProcessRunner.WaitForStandardOutputToContainText(expectedText, 5000);
            ProcessRunner.StandardOutputList.Should()
                .Contain(x => x.Contains(expectedText),
                    "ProcessRunner StandardOutputList Should contain at least one line containing text '{0}'",
                    expectedText);
            ProcessRunner.WaitForStandardOutputToContainText(expectedText, 5000);
            foreach (string line in ProcessRunner.StandardOutputList)
            {
                Console.WriteLine(line);
                if (line.Trim().Contains(expectedText.Trim()))
                {
                    return;
                }
            }
            throw new Exception(string.Format("ProcessRunner.StandardOutputList did not contain '{0}'", expectedText));
        }

        /// <summary>
        /// ToDo:- refactor by comnbining methods for StdErr/StdOut and parameterising to enable/disable output to test console, and to change timeouts
        /// </summary>
        /// <param name="expectedText"></param>
        [Then(@"the standard error output contains text ""(.*)""")]
        public void ThenTheStandardErrorOutputContainsText(string expectedText)
        {
            ProcessRunner.WaitForStandardErrorOutputToContainText(expectedText, 20000);
            ProcessRunner.StandardErrorOutputList.Should()
                //.Contain(x => x!= null && x.Contains(expectedText),
                .Contain(x => x.Contains(expectedText),
                    "ProcessRunner StandardErrorOutputList Should contain at least one line containing text '{0}'",
                    expectedText);
            ProcessRunner.WaitForStandardErrorOutputToContainText(expectedText, 5000);
            foreach (string line in ProcessRunner.StandardErrorOutputList)
            {
                Console.WriteLine(line);
                if (line.Trim().Contains(expectedText.Trim()))
                {
                    return;
                }
            }
            throw new Exception(string.Format("ProcessRunner.StandardErrorOutputList did not contain '{0}'", expectedText));
        }

    }
}