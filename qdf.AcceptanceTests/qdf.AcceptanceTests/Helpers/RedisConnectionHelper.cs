using Alpari.QDF;
using Alpari.QDF.Domain;
using BookSleeve;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;

namespace qdf.AcceptanceTests.Helpers
{
    public class RedisConnectionHelper
    {
        public RedisDataStore dealsStore { get; private set; }
        public IEnumerable<Deal> retrievedDeals { get; private set; }
        public RedisConnection connection { get; private set; }
        public string redisHost { get; private set; }
        public RedisConnectionHelper(string redisHost)
        {
            this.redisHost = redisHost;
            connection = new RedisConnection(this.redisHost);
            connection.Open();
        }

        /// <summary>
        /// Query QDF using the deal paramerters specified.
        /// Currently only the start and end times are in use for retreiveing deals from Redis as this is how the deal data is indexed, but the rest of the parameters can be used to filter the returned data
        /// </summary>
        /// <param name="entry"></param>
        public void GetDealData(QdfDealParameters qdfDealParameters)
        {
            dealsStore = new RedisDataStore(connection, new SortedSetBasedStorageStrategy(connection, new JsonSerializer()));
            //might need to adjust the time slice, for now leaving as Day
            var deals = dealsStore.Load<Deal>(KeyConfig.KeyNamespaces.Deal, qdfDealParameters.convertedStartTime, qdfDealParameters.convertedEndTime, TimeSlice.Day);
            if (retrievedDeals == null) 
            { 
                retrievedDeals = deals; 
            }
            else
            {
                retrievedDeals = retrievedDeals.Concat(deals); 
            }
        }

        public void OutputAllDeals(string fileNamePath)
        {
            StringBuilder csvFile = new StringBuilder();
            var headers = String.Join(",", TypeExtensions.GetPropertyNamesAsList(typeof(Deal)));//.Select(x => x));
            csvFile.AppendLine(headers);
            foreach (Deal deal in retrievedDeals)
            {
                csvFile.AppendLine(String.Join(",", TypeExtensions.GetObjectPropertyValuesAsList(deal).Select(x=>CsvParser.StringToCSVCell(x.ToString()))));
            }
            System.IO.File.WriteAllText(fileNamePath, csvFile.ToString());
        }
    }
}
