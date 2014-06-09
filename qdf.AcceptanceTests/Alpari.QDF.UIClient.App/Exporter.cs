using System.IO;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QDF.UIClient.App
{
    public class Exporter
    {
        public Exporter(RedisConnectionHelper redisConnectionHelper)
        {
            RedisConnectionHelper = redisConnectionHelper;
        }

        public RedisConnectionHelper RedisConnectionHelper { get; set; }

        public void ExportDealsToCsv(string fileNamePath)
        {
            ClearPreviousCsvOutput(fileNamePath);
            RedisConnectionHelper.RetrievedDeals.EnumerableToCsv(fileNamePath, true);
        }

        public void ExportQuotesToCsv(string fileNamePath)
        {
            ClearPreviousCsvOutput(fileNamePath);
            RedisConnectionHelper.RetrievedQuotes.EnumerableToCsv(fileNamePath, true);
        }

        private static void ClearPreviousCsvOutput(string fileNamePath)
        {
            if (File.Exists(fileNamePath))
            {
                File.Delete(fileNamePath);
            }
        }

        public void SwitchRedisConnection(string environment)
        {
            RedisConnectionHelper.Connection.Close(false);
            RedisConnectionHelper = new RedisConnectionHelper(environment);
        }


    }
}