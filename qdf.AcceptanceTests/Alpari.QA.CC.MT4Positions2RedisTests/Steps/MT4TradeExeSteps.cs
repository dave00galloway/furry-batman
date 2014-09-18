using System;
using Alpari.QA.ProcessRunner;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class Mt4TradeExeSteps : StepCentral
    {
        new public static readonly string FullName = typeof(Mt4TradeExeSteps).FullName;
        public IProcessStartInfoWrapper Mt4TradeProcessStartInfoWrapper { get; set; }
        public IProcessRunner Mt4TradeRunner { get; set; }

        [Given(@"I these parameters for MT4Trade:-")]
        public void GivenITheseParametersForMt4Trade(ProcessStartInfoWrapper processStartInfoWrapper)
        {
            Mt4TradeProcessStartInfoWrapper = processStartInfoWrapper;
        }

        [When(@"I launch MT4Trade")]
        public void WhenILaunchMt4Trade()
        {
            Mt4TradeRunner = new ProcessRunner.ProcessRunner(Mt4TradeProcessStartInfoWrapper);
        }

        [When(@"I send string ""(.*)"" to MT4Trade")]
        public void WhenISendStringToMt4Trade(string input)
        {
            Mt4TradeRunner.SendInput(input);
        }


        [Then(@"MT4Trade output contains ""(.*)""")]
        public void ThenMt4TradeOutputContains(string expectedText)
        {
            Mt4TradeRunner.WaitForStandardOutputToContainText(expectedText, 20000);
            Mt4TradeRunner.StandardOutputList.Should()
                //.Contain(x => x!= null && x.Contains(expectedText),
                .Contain(x => x.Contains(expectedText),
                    "ProcessRunner StandardOutputList Should contain at least one line containing text '{0}'",
                    expectedText);
            Mt4TradeRunner.WaitForStandardOutputToContainText(expectedText, 5000);
            foreach (string line in Mt4TradeRunner.StandardOutputList)
            {
                Console.WriteLine(line);
                if (line.Trim().Contains(expectedText.Trim()))
                {
                    return;
                }
            }
            throw new Exception(string.Format("ProcessRunner.StandardOutputList did not contain '{0}'", expectedText));
        }

    }
}