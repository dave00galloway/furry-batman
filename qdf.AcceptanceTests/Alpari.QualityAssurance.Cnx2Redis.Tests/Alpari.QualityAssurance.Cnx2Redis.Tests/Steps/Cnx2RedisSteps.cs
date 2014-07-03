using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.NunitTextReportParser;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class Cnx2RedisSteps : Cnx2RedisStepBase
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
            var cnxTradeData =
                CnxTradeTableDataContext.SelectDataAsDataTable(CnxTradeTableDataContext.QuerySingleTrade(tradeId))
                    .ConvertToTypedDataTable<CnxTradeDataTable>();
            ScenarioContext.Current["cnxTradeData"] = cnxTradeData;
            ScenarioContext.Current["tradeId"] = tradeId;
        }

        [When(@"I query cnx trade by trade id for these trade ids:")]
        public void WhenIQueryCnxTradeByTradeIdForTheseTradeIds(Table tradeIdsTable)
        {
            List<string> idsQuery = tradeIdsTable.Rows.Select(row => row["DealId"]).ToList();
            string idsAsList = String.Format("('{0}')", String.Join("','", idsQuery));
            var cnxTradeData =
                CnxTradeTableDataContext.SelectDataAsDataTable(CnxTradeTableDataContext.QueryTradesById(idsAsList))
                    .ConvertToTypedDataTable<CnxTradeDataTable>();
            ScenarioContext.Current["cnxTradeData"] = cnxTradeData;
        }

        /// <summary>
        /// TODO:- rename method to "I query cnx trade by trade date from"
        /// </summary>
        /// <param name="from"></param>
        /// <param name="to"></param>
        [When(@"I query cnx trade by trade id from ""(.*)"" to ""(.*)""")]
        public void WhenIQueryCnxTradeByTradeIdFromTo(DateTime from, DateTime to)
        {
            var cnxTradeData =
                CnxTradeTableDataContext.SelectDataAsDataTable(CnxTradeTableDataContext.QueryTradesByDateTime(from,to))
                    .ConvertToTypedDataTable<CnxTradeDataTable>();
            ScenarioContext.Current["cnxTradeData"] = cnxTradeData;
        }

        [When(@"I query cnx trade by using the same deal search criteria")]
        public void WhenIQueryCnxTradeByUsingTheSameDealSearchCriteria()
        {
            var criteria = QdfDataRetrievalSteps.DealSearchCriteria;
            var cnxTradeData =
                CnxTradeTableDataContext.SelectDataAsDataTable(CnxTradeTableDataContext.QueryTradesByDateTime(criteria.ConvertedStartTime, criteria.ConvertedEndTime))
                    .ConvertToTypedDataTable<CnxTradeDataTable>();
            ScenarioContext.Current["cnxTradeData"] = cnxTradeData;
        }



        [When(@"I compare the cnx trade deals with the qdf deal data")]
        public void WhenICompareTheCnxTradeDealsWithTheQdfDealData()
        {
            GetCnxAndQdfDealsAsTestableDealDataTables(out CnxDealsAsTestableDealDataTable, out QdfDealsAsTestableDealDataTable);
            var diffs = CnxDealsAsTestableDealDataTable.Compare(QdfDealsAsTestableDealDataTable,null,null,false,true);
            ScenarioContext.Current["diffs"] = diffs;
        }

        [When(@"I compare the cnx trade deals with the qdf deal data excluding these fields:")]
        public void WhenICompareTheCnxTradeDealsWithTheQdfDealDataExcludingTheseFields(Table table)
        {
            var ignoredFieldsQuery = table.Rows.Select(row => row["ExcludedFields"]).ToArray();
            GetCnxAndQdfDealsAsTestableDealDataTables(out CnxDealsAsTestableDealDataTable, out QdfDealsAsTestableDealDataTable);
            var diffs = CnxDealsAsTestableDealDataTable.Compare(QdfDealsAsTestableDealDataTable, ignoredFieldsQuery,null,false,true);
            ScenarioContext.Current["diffs"] = diffs;
        }

        [Then(@"the cnx trade has a login of ""(.*)""")]
        public void ThenTheCnxTradeHasALoginOf(string expectedLogin)
        {
            var cnxTradeData = ScenarioContext.Current["cnxTradeData"] as CnxTradeDataTable;
            var tradeId = ScenarioContext.Current["tradeId"] as string;
            if (cnxTradeData != null)
            {
                List<CnxTradeDataTableRow> query = (from CnxTradeDataTableRow row in cnxTradeData.Rows
                    where row.TradeId == tradeId
                    select row).ToList();
                query.First().Login.Should().Be(expectedLogin);
            }
            else
            {
                throw new Exception("no data found in cnxTradeData");
            }
        }

        [Then(@"the cnx trade deals should match the qdf deal data exactly")]
        public void ThenTheCnxTradeDealsShouldMatchTheQdfDealDataExactly()
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            diffs.CheckForDifferences().Should().BeNullOrWhiteSpace();
        }

        [Then(@"the cnx trade deals should contain the same deals as the qdf deal data")]
        public void ThenTheCnxTradeDealsShouldContainTheSameDealsAsTheQdfDealData()
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            diffs.QueryDifferences(0,"missing");
            diffs.QueryDifferences(0, "extra");
        }

        [Then(@"the cnx trade data should contain (.*) ""(.*)""")]
        public void ThenTheCnxTradeDataShouldContain(int diffCount, string diffType)
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            diffs.QueryDifferences(diffCount, diffType);
        }

        [Then(@"the cnx trade data should contain (.*) ""(.*)"" in the ""(.*)"" column")]
        public void ThenTheCnxTradeDataShouldContainInTheColumn(int diffCount, string diffType, string column)
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            diffs.FieldDifferences.Rows.Should().HaveCount(diffCount); //and
            foreach (DataRow row in diffs.FieldDifferences.Rows)
            {
                row["column"].Should().Be(column);
            }
        }

        [Then(@"the cnx trade deals should match the qdf deal data exactly :-")]
        public void ThenTheCnxTradeDealsShouldMatchTheQdfDealDataExactly(ExportParameters exportParameters)
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            diffs.CheckForDifferences(exportParameters).Should().BeNullOrWhiteSpace();
        }

        [Then(@"the cnx trade data should contain (.*) ""(.*)"" :-")]
        public void ThenTheCnxTradeDataShouldContain(int diffCount, string diffType, ExportParameters exportParameters)
        {
            var diffs = (DataTableComparison)ScenarioContext.Current["diffs"];
            diffs.QueryDifferences(diffCount,diffType,exportParameters);
        }

    }
}