using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.CC.WebPortal.DAL.Repositories.Redis;
using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
using FluentAssertions;
using StackExchange.Redis;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class GetRedisPositionsSteps
    {
        public IRedisRepository RedisRepository { get; set; }
        public IList<Position> Positions { get; set; }
        public IList<TestablePosition> TestablePositions { get; set; }

        [Given(@"I have a connection to a redis repository on ""(.*)"" port (.*) db (.*)")]
        public void GivenIHaveAConnectionToARedisRepositoryOnPortDb(string host, int port, int db)
        {
            RedisRepository = new RedisRepository(host,port,db);
        }

        [When(@"I get all positions for server ""(.*)""")]
        public void WhenIGetAllPositionsForServer(string mtServerName)
        {
            Positions = RedisRepository.GetAllPositions(mtServerName).ToList();
        }

        [When(@"I convert open positions to testable positions")]
        public void WhenIConvertOpenPositionsToTestablePositions()
        {
            TestablePositions = Positions.ConvertPositionsToTestablePositions();
        }

        

        [Then(@"at least 1 position is for login (.*)")]
        public void ThenAtLeastPositionIsForLogin(int login)
        {
            Positions.Should().Contain(p => p.Login == login);
        }


        [Then(@"at least 1 position has an OpenTime of ""(.*)""")]
        public void ThenAtLeastPositionHasAnOpenTimeOf(DateTime openTime)
        {
            TestablePositions.Should().Contain(p => p.OpenTime == openTime);
        }
    }
}
