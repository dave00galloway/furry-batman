using System.IO;
using System.Linq;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Tests.Steps
{
    [Binding]
    public class CombineLogFileSteps : StepCentral
    {
        public CombineLogFileParameters CombineLogFileParameters { get; set; }

        [Given(@"I have the following log file join parameters:-")]
        public void GivenIHaveTheFollowingLogFileJoinParameters(CombineLogFileParameters joinParams)
        {
            CombineLogFileParameters = joinParams;
            CombineLogFileParameters.OutputFile = ScenarioOutputDirectory + CombineLogFileParameters.OutputFile;
        }

        [When(@"I join the log files")]
        public void WhenIJoinTheLogFiles()
        {
            CombineLogFileParameters.JoinFiles();
        }

        [Then(@"the output file should contain (.*) lines")]
        public void ThenTheOutputFileShouldContainLines(int expectedLineCount)
        {
            File.ReadLines(CombineLogFileParameters.OutputFile).Should().HaveCount(expectedLineCount);
        }
    }
}