using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.CC.WebPortal.DAL.Repositories.Redis;
using Alpari.QA.QDF.Test.Domain.TypedDataTables.CapitalCalculation;
using FluentAssertions;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class GetRedisPositionsSteps : StepCentral
    {
        public new static readonly string FullName = typeof (GetRedisPositionsSteps).FullName;
        public IRedisRepository RedisRepository { get; set; }
        public IList<Position> Positions { get; set; }
        // public IList<TestablePosition> TestablePositions { get; set; }
        public IDictionary<string, PositionDataTable> PositionDataTableDictionary { get; set; }

        public GetRedisPositionsSteps(IDictionary<string, PositionDataTable> positionDataTableDictionary)
        {
            PositionDataTableDictionary = positionDataTableDictionary;
        }

        [Given(@"I have a connection to a redis repository on ""(.*)"" port (.*) db (.*) namespace (.*)")]
        public void GivenIHaveAConnectionToARedisRepositoryOnPortDb(string host, int port, int db, string keyNamespace)
        {
            RedisRepository = new RedisRepository(host, port, db, keyNamespace);
        }

        [When(@"I get all positions for server ""(.*)""")]
        public void WhenIGetAllPositionsForServer(string mtServerName)
        {
            Positions = RedisRepository.GetAllPositions(mtServerName).ToList();
            PositionDataTableDictionary[mtServerName] = new PositionDataTable(mtServerName,new []{"Order"}).ConvertIEnumerableToDataTable(Positions);
        }

        [When(@"I get all positions for server ""(.*)"" opened from '(.*)'")]
        public void WhenIGetAllPositionsForServerOpenedFrom(string mtServerName, DateTime openedFromTime)
        {
            Positions = RedisRepository.GetAllPositions(mtServerName)
                //.Where(p=>p.OpenTime.ConvertUnixTimeStampAsSeconds() >= openedFromTime).ToList();
                .Where(p => p.OpenTime >= openedFromTime).ToList();
            PositionDataTableDictionary[mtServerName] = new PositionDataTable(mtServerName, new[] { "Order" }).ConvertIEnumerableToDataTable(Positions);
        }


        //[When(@"I convert open positions to testable positions")]
        //public void WhenIConvertOpenPositionsToTestablePositions()
        //{
        //    TestablePositions = Positions.ConvertPositionsToTestablePositions();
        //}

        [Then(@"at least 1 position is for login (.*)")]
        public void ThenAtLeastPositionIsForLogin(int login)
        {
            Positions.Should().Contain(p => p.Login == login);
        }


        //[Then(@"at least 1 position has an OpenTime of ""(.*)""")]
        //public void ThenAtLeastPositionHasAnOpenTimeOf(DateTime openTime)
        //{
        //    TestablePositions.Should().Contain(p => p.OpenTime == openTime);
        //}
    }
}