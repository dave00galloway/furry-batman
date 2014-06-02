using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using BookSleeve;
using qdf.AcceptanceTests.Helpers;

namespace Alpari.QDF.UIClient.App
{
    /// <summary>
    ///     warning - repeated this code in qdf.AcceptanceTests.Helpers
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

        ///// <summary>
        /////     Query QDF using the deal paramerters specified.
        /////     Currently only the start and end times are in use for retreiveing deals from Redis as this is how the deal data is
        /////     indexed, but the rest of the parameters can be used to filter the returned data
        ///// </summary>
        ///// <param name="qdfDealParameters"></param>
        //[Obsolete("Provided for backwards compatibility for deal reconciliation tests, use GetDealData(DealSearchCriteria dealSearchCriteria) instead")]
        //public void GetDealData(QdfDealParameters qdfDealParameters)
        //{
        //    IEnumerable<Deal> deals = GetDealsForDateRange(qdfDealParameters.ConvertedStartTime,
        //        qdfDealParameters.ConvertedEndTime);
        //    if (RetrievedDeals == null)
        //    {
        //        RetrievedDeals = deals.ToList();
        //    }
        //    else
        //    {
        //        RetrievedDeals.Concat(deals.ToList());
        //    }
        //}

        /// <summary>
        /// Get the deal data for the specified time range and then apply filtering to set the final retrieved deals set
        /// </summary>
        /// <param name="dealSearchCriteria"></param>
        public void GetDealData(DealSearchCriteria dealSearchCriteria)
        {
            //set up the search parameters
            dealSearchCriteria.Resolve();

            //get the deals for the date range
            IEnumerable<Deal> deals = GetDealsForDateRange(dealSearchCriteria.ConvertedStartTime,
                dealSearchCriteria.ConvertedEndTime);

            //filter the results using the search parameters
            RetrievedDeals = FilterDealsBySearchCriteria(deals, dealSearchCriteria);
        }

        private List<Deal> FilterDealsBySearchCriteria(IEnumerable<Deal> deals, DealSearchCriteria dealSearchCriteria)
        {
            return deals.ToList();
        }

        /// <summary>
        /// Will always have a date range, and while doing client side filtering, no other parameters are needed
        /// </summary>
        /// <param name="startTimeStampInclusive"></param>
        /// <param name="endTimeStampExclusive"></param>
        /// <returns></returns>
        private IEnumerable<Deal> GetDealsForDateRange(DateTime startTimeStampInclusive, DateTime endTimeStampExclusive)
        {
            DealsStore = new RedisDataStore(Connection,
                new SortedSetBasedStorageStrategy(Connection, new JsonSerializer()));
            //might need to adjust the time slice, for now leaving as Day
            IEnumerable<Deal> deals = DealsStore.Load<Deal>(KeyConfig.KeyNamespaces.Deal,
                startTimeStampInclusive, endTimeStampExclusive, TimeSlice.Day);
            return deals;
        }



        public void OutputAllDeals(string fileNamePath)
        {
            RetrievedDeals.EnumerableToCsv(fileNamePath, true);
        }
    }
}