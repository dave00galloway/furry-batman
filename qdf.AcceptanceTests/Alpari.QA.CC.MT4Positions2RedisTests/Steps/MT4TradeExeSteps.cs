using System;
using System.Threading;
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

        [Given(@"I have these parameters for MT4Trade:-")]
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

        [When(@"I load (.*) trades with these parameters ""(.*)"" with MT4Trade")]
        public void WhenILoadTradesWithTheseParametersWithMt4Trade(int numTrades, string input)
        {
            for (int i = 0; i < numTrades; i++)
            {
                Mt4TradeRunner.SendInput(input);
                //Console.WriteLine(i);
            }

            //Thread.Sleep(5000);
            //while (!Mt4TradeRunner.Process.Responding)
            //{
            //    Console.WriteLine("waiting...");
            //    Thread.Sleep(5);
            //}
        }


        [Then(@"MT4Trade output contains ""(.*)""")]
        public void ThenMt4TradeOutputContains(string expectedText)
        {
            Mt4TradeRunner.WaitForStandardOutputToContainText(expectedText, 30000);
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