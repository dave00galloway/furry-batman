using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using System;
using System.Linq;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class Cnx2RedisSteps :Cnx2RedisStepBase
    {
        public Cnx2RedisSteps(CnxTradeTableDataContext cnxTradeTableDataContext) : base(cnxTradeTableDataContext)
        {
        }

        [Given(@"I have connected to the cnx trade table")]
        public void GivenIHaveConnectedToTheCnxTradeTable()
        {
            CnxTradeTableDataContext.MyConnection.Should().NotBeNull();
        }

        [When(@"I query cnx trade by trade id ""(.*)""")]
        public void WhenIQueryCnxTradeByTradeId(string tradeId)
        {
            var cnxTradeData = CnxTradeTableDataContext.SelectDataAsDataTable(QuerySingleTrade(tradeId)).ConvertToTypedDataTable<CnxTradeDataTable>();
            ScenarioContext.Current["cnxTradeData"] = cnxTradeData;
            ScenarioContext.Current["tradeId"] = tradeId;
        }

        [Then(@"the cnx trade has a login of ""(.*)""")]
        public void ThenTheCnxTradeHasALoginOf(string expectedLogin)
        {
            var cnxTradeData = ScenarioContext.Current["cnxTradeData"] as CnxTradeDataTable;
            var tradeId = ScenarioContext.Current["tradeId"] as string;
            if (cnxTradeData != null)
            {
                var query = (from CnxTradeDataTableRow row in cnxTradeData.Rows
                    where row.TradeId == tradeId
                    select row).ToList();
                query.First().Login.Should().Be(expectedLogin);

            }
            else
            {
                throw new Exception("no data found in cnxTradeData");
            }
        }

    }
}
