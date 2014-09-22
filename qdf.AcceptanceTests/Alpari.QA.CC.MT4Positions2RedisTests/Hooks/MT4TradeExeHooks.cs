using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QA.CC.MT4Positions2RedisTests.Steps;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Hooks
{
    [Binding]
    public class MT4TradeExeHooks
    {
        // For additional details on SpecFlow hooks see http://go.specflow.org/doc-hooks

        //[BeforeScenario]
        //public void BeforeScenario()
        //{
        //    //TODO: implement logic that has to run before executing each scenario
        //}

        [AfterScenario]
        public void AfterScenario()
        {
            if (StepCentral.Mt4TradeExeSteps.Mt4TradeRunner != null)
            {
                var mt4TradeRunner = StepCentral.Mt4TradeExeSteps.Mt4TradeRunner;
                Console.WriteLine("StdErr");
                foreach (string line in mt4TradeRunner.StandardErrorOutputList)
                {
                    Console.WriteLine(line);
                }
                Console.WriteLine("StdOut");
                foreach (string line in mt4TradeRunner.StandardOutputList)
                {
                    Console.WriteLine(line);
                }

                mt4TradeRunner.SendInput("exit");
                mt4TradeRunner.Dispose();
            }
        }
    }
}
