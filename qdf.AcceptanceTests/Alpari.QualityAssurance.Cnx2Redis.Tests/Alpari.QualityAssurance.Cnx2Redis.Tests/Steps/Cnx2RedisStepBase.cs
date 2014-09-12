using System.Collections.Generic;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Steps
{
    [Binding]
    public class Cnx2RedisStepBase : StepCentral
    {
        public new static readonly string FullName = typeof(Cnx2RedisStepBase).FullName; 
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
                QDF.UIClient.Tests.Steps.StepCentral.RedisConnectionHelper.RetrievedDeals.ConvertToTestableDeals(), "cnx-deals",
                new[] {"DealId"});
        }

        [StepArgumentTransformation]
        public static ExportParameters QuoteSearchParametersTransform(Table table)
        {
            var parameters = table.CreateInstance<ExportParameters>();
            if (parameters.ExportType == ExportTypes.Csv || parameters.ExportType == ExportTypes.DataTableToCsv)
            {
                parameters.Path = ScenarioOutputDirectory;
            }
            return parameters;
        }
    }
}