using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using Alpari.QDF;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using BookSleeve;

namespace qdf.AcceptanceTests.Helpers
{
    public class RedisConnectionHelper
    {
        public RedisConnectionHelper(string redisHost)
        {
            this.redisHost = redisHost;
            connection = new RedisConnection(this.redisHost);
            connection.Open();
        }

        public RedisDataStore dealsStore { get; private set; }
        public List<Deal> retrievedDeals { get; private set; }
        public RedisConnection connection { get; private set; }
        public string redisHost { get; private set; }

        /// <summary>
        ///     Query QDF using the deal paramerters specified.
        ///     Currently only the start and end times are in use for retreiveing deals from Redis as this is how the deal data is
        ///     indexed, but the rest of the parameters can be used to filter the returned data
        /// </summary>
        /// <param name="qdfDealParameters"></param>
        public void GetDealData(QdfDealParameters qdfDealParameters)
        {
            dealsStore = new RedisDataStore(connection,
                new SortedSetBasedStorageStrategy(connection, new JsonSerializer()));
            //might need to adjust the time slice, for now leaving as Day
            var deals = dealsStore.Load<Deal>(KeyConfig.KeyNamespaces.Deal,
                qdfDealParameters.convertedStartTime, qdfDealParameters.convertedEndTime, TimeSlice.Day);
            if (retrievedDeals == null)
            {
                retrievedDeals = deals.ToList();
            }
            else
            {
                retrievedDeals.Concat(deals.ToList());
            }
        }

        public void OutputAllDeals(string fileNamePath)
        {
            var csvFile = new StringBuilder();
            var headers = String.Join(",", typeof (Deal).GetPropertyNamesAsList()); //.Select(x => x));
            csvFile.AppendLine(headers);
            foreach (var deal in retrievedDeals)
            {
                csvFile.AppendLine(String.Join(",",
                    deal.GetObjectPropertyValuesAsList().Select(x => CsvParser.StringToCsvCell(x.ToString(CultureInfo.InvariantCulture)))));
            }
            File.WriteAllText(fileNamePath, csvFile.ToString());
        }
    }
}