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
            this.RedisHost = redisHost;
            Connection = new RedisConnection(this.RedisHost);
            Connection.Open();
        }

        public RedisDataStore DealsStore { get; private set; }
        public List<Deal> RetrievedDeals { get; private set; }
        public RedisConnection Connection { get; private set; }
        public string RedisHost { get; private set; }

        /// <summary>
        ///     Query QDF using the deal paramerters specified.
        ///     Currently only the start and end times are in use for retreiveing deals from Redis as this is how the deal data is
        ///     indexed, but the rest of the parameters can be used to filter the returned data
        /// </summary>
        /// <param name="qdfDealParameters"></param>
        public void GetDealData(QdfDealParameters qdfDealParameters)
        {
            DealsStore = new RedisDataStore(Connection,
                new SortedSetBasedStorageStrategy(Connection, new JsonSerializer()));
            //might need to adjust the time slice, for now leaving as Day
            var deals = DealsStore.Load<Deal>(KeyConfig.KeyNamespaces.Deal,
                qdfDealParameters.ConvertedStartTime, qdfDealParameters.ConvertedEndTime, TimeSlice.Day);
            if (RetrievedDeals == null)
            {
                RetrievedDeals = deals.ToList();
            }
            else
            {
                RetrievedDeals.Concat(deals.ToList());
            }
        }

        public void OutputAllDeals(string fileNamePath)
        {
            var csvFile = new StringBuilder();
            var headers = String.Join(",", typeof (Deal).GetPropertyNamesAsList()); //.Select(x => x));
            csvFile.AppendLine(headers);
            foreach (var deal in RetrievedDeals)
            {
                csvFile.AppendLine(String.Join(",",
                    deal.GetObjectPropertyValuesAsList().Select(x => CsvParser.StringToCsvCell(x.ToString(CultureInfo.InvariantCulture)))));
            }
            File.WriteAllText(fileNamePath, csvFile.ToString());
        }
    }
}