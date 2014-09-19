using System.Collections.Generic;
using System.Linq;
using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
using Alpari.QA.CC.MT4Positions2RedisTests.Transforms;
using AlpariUK.Mt4.Wrapper;
using AlpariUK.Mt4.Wrapper.Enums;
using AlpariUK.Mt4.Wrapper.Types;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class Mt4DotNetManagerWrapperSteps : StepCentral
    {
        public new static readonly string FullName = typeof (Mt4DotNetManagerWrapperSteps).FullName;
        public Manager Manager { get; private set; }

        [Given(@"I have connected to the MT4 Manger API:-")]
        public void GivenIHaveConnectedToTheMtMangerApi(Mt4ApiConnectionParameters connectionParameters)
        {
            Manager = new Manager(connectionParameters.Server, connectionParameters.Login,
                connectionParameters.Password);
            Manager.Connect();
        }

        [When(@"I query open positions for user ""(.*)""")]
        public void WhenIQueryOpenPositionsForUser(int login)
        {
            List<TradeRecord> positions =
                Manager.TradesRequest()
                    .Where(t => t.Login == login
                                && (t.Cmd != TradeCommand.OP_BALANCE || t.Cmd != TradeCommand.OP_CREDIT))
                    .ToList();
        }
    }
}