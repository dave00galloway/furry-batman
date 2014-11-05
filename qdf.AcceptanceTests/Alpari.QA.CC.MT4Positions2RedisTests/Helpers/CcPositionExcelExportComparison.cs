using Alpari.QA.QDF.Test.Domain.TypedDataTables.CapitalCalculation;
using LinqToExcel;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    public static class CcPositionExcelExportComparison
    {
        public static ClientPositionDataTable ClientPositionDataTable(this ComparisonDetails comparisonDetails,
            out ClientPositionDataTable arsData)
        {
            var redisExcel = ExcelQueryFactory(comparisonDetails.RedisPositionsFile);
            var arsExcel = ExcelQueryFactory(comparisonDetails.ArsPositionsFile);
            var redisData =
                new ClientPositionDataTable().ConvertIEnumerableToDataTable(redisExcel.Worksheet<ClientPosition>(0),
                    "redis data", new[] {"Login", "Ticket"});
            arsData = new ClientPositionDataTable().ConvertIEnumerableToDataTable(arsExcel.Worksheet<ClientPosition>(0),
                "ars data", new[] {"Login", "Ticket"});
            return redisData;
        }

        private static ExcelQueryFactory ExcelQueryFactory(string comparsionDetails)
        {
            var excel = new ExcelQueryFactory
            {
                FileName = comparsionDetails
            };
            excel.AddMapping<ClientPosition>(x => x.ServerName, "Server Name");
            excel.AddMapping<ClientPosition>(x => x.SectionId, "Section");
            excel.AddMapping<ClientPosition>(x => x.BaseVolume, "Volume");
            return excel;
        }

        public class ComparisonDetails
        {
            public string RedisPositionsFile { get; set; }
            public string ArsPositionsFile { get; set; }
        }
    }
}