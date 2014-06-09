using System;
using System.Collections.Generic;
using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using BookSleeve;

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

        /// <summary>
        ///     Get the deal data for the specified time range and then apply filtering to set the final retrieved deals set
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
            deals = FilterDealsByBook(deals, dealSearchCriteria);
            deals = FilterDealsBySymbol(deals, dealSearchCriteria);
            deals = FilterDealsByServer(deals, dealSearchCriteria);
            return deals.ToList();
        }

        private IEnumerable<Deal> FilterDealsByBook(IEnumerable<Deal> deals, DealSearchCriteria dealSearchCriteria)
        {
            if (dealSearchCriteria.Book != default (Book))
            {
                deals = deals.Where(x => x.Book == dealSearchCriteria.Book);
            }
            return deals;
        }

        private IEnumerable<Deal> FilterDealsBySymbol(IEnumerable<Deal> deals, DealSearchCriteria dealSearchCriteria)
        {
            if (dealSearchCriteria.Instrument != null)
            {
                deals = deals.Where(x => x.Instrument == dealSearchCriteria.Instrument);
            }
            else if (dealSearchCriteria.InstrumentList.Count > 0)
            {
                deals = deals.Where(x => dealSearchCriteria.InstrumentList.Contains(x.Instrument));
            }
            return deals;
        }

        private static IEnumerable<Deal> FilterDealsByServer(IEnumerable<Deal> deals,
            DealSearchCriteria dealSearchCriteria)
        {
            if (dealSearchCriteria.Server != default(TradingServer))
            {
                deals = deals.Where(x => x.Server == dealSearchCriteria.Server);
            }
            else if (dealSearchCriteria.TradingServerList.Count > 0)
            {
                deals = deals.Where(x => dealSearchCriteria.TradingServerList.Contains(x.Server));
            }
            return deals;
        }

        /// <summary>
        ///     Will always have a date range, and while doing client side filtering, no other parameters are needed
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