using System.Collections.Generic;
using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using BookSleeve;
using qdf.AcceptanceTests.Helpers;

namespace Alpari.QDF.UIClient.App
{
    /// <summary>
    /// warning - repeated this code in qdf.AcceptanceTests.Helpers
    /// </summary>
    public class RedisConnectionHelper
    {
        public RedisConnectionHelper(string redisHost)
        {
            RedisHost = redisHost;
            Connection = new RedisConnection(RedisHost);
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
            IEnumerable<Deal> deals = DealsStore.Load<Deal>(KeyConfig.KeyNamespaces.Deal,
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
            RetrievedDeals.EnumerableToCsv(fileNamePath,true);
        }
    }
}