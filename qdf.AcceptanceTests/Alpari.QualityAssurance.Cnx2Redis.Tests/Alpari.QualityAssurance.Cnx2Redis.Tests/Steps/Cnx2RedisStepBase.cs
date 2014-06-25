using System.Collections.Generic;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class Cnx2RedisStepBase : StepCentral
    {
        protected TestableDealDataTable CnxDealsAsTestableDealDataTable;
        protected TestableDealDataTable QdfDealsAsTestableDealDataTable;

        public Cnx2RedisStepBase(CnxTradeTableDataContext cnxTradeTableDataContext) : base(cnxTradeTableDataContext)
        {
        }

        protected static void GetCnxAndQdfDealsAsTestableDealDataTables(
            out TestableDealDataTable cnxDealsAsTestableDealDataTable,
            out TestableDealDataTable qdfDealsAsTestableDealDataTable)
        {
            IEnumerable<TestableDeal> cnxDealsAsQdfDeals =
                (ScenarioContext.Current["cnxTradeData"] as CnxTradeDataTable).MapCnxTradeDealsToQdfDeals();
            cnxDealsAsTestableDealDataTable =
                new TestableDealDataTable().ConvertIEnumerableToDataTable(cnxDealsAsQdfDeals,
                    "MySqlData",
                    new[] {"DealId"});
            qdfDealsAsTestableDealDataTable = new TestableDealDataTable().ConvertIEnumerableToDataTable(
                QdfDataRetrievalSteps.RedisConnectionHelper.RetrievedDeals.ConvertToTestableDeals(), "cnx-deals",
                new[] {"DealId"});
        }
    }
}