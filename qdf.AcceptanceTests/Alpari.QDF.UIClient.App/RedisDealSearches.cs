using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QDF.UIClient.App
{
    public class RedisDealSearches
    {
        private readonly RedisConnectionHelper _redisConnectionHelper;

        public RedisDealSearches(RedisConnectionHelper redisConnectionHelper)
        {
            _redisConnectionHelper = redisConnectionHelper;
            TotalRetrievedDeals = new List<Deal>();
        }

        public IEnumerable<Deal> TotalRetrievedDeals { get; private set; }

        /// <summary>
        ///     Get the deal data for the specified time range and then apply filtering to set the final retrieved deals set
        /// </summary>
        /// <param name="dealSearchCriteria"></param>
        public void GetDealData(DealSearchCriteria dealSearchCriteria)
        {
            //set up the search parameters
            dealSearchCriteria.Resolve();

            //get the deals for the date range
            TotalRetrievedDeals = GetDealsForDateRange(dealSearchCriteria.DealSource,
                dealSearchCriteria.ConvertedStartTime,
                dealSearchCriteria.ConvertedEndTime, dealSearchCriteria.DealType);

            //filter the results using the search parameters
            _redisConnectionHelper.RetrievedDeals = FilterDealsBySearchCriteria(TotalRetrievedDeals, dealSearchCriteria);
        }

        private List<Deal> FilterDealsBySearchCriteria(IEnumerable<Deal> deals, DealSearchCriteria dealSearchCriteria)
        {
            //DebugPrintDeals(deals);
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
        /// <param name="dealSource"></param>
        /// <param name="startTimeStampInclusive"></param>
        /// <param name="endTimeStampExclusive"></param>
        /// <param name="dealType"></param>
        /// <returns></returns>
        private IEnumerable<Deal> GetDealsForDateRange(string dealSource, DateTime startTimeStampInclusive,
            DateTime endTimeStampExclusive, string dealType)
        {
            _redisConnectionHelper.DealsStore = new RedisDataStore(_redisConnectionHelper.Connection,
                new SortedSetBasedStorageStrategy(_redisConnectionHelper.Connection, new JsonSerializer()));
            IEnumerable<Deal> deals;
            if (dealType == "BookLessDeal")
            {
                deals = MapBookLessDealToDeal(_redisConnectionHelper.DealsStore.Load<BookLessDeal>(dealSource
                    ,startTimeStampInclusive, endTimeStampExclusive, TimeSlice.Day));
            }
            else
            {
                //might need to adjust the time slice, for now leaving as Day
                deals = _redisConnectionHelper.DealsStore.Load<Deal>(dealSource
                    //KeyConfig.KeyNamespaces.Deal // = "deals" not Deal!
                    ,
                    startTimeStampInclusive, endTimeStampExclusive, TimeSlice.Day);
            }
            return deals;
        }

        private IEnumerable<Deal> MapBookLessDealToDeal(IEnumerable<BookLessDeal> bookLessDeals)
        {
            var deals = new List<Deal>();
// ReSharper disable once LoopCanBeConvertedToQuery - easier to debug if left as for loop
            foreach (BookLessDeal bookLessDeal in bookLessDeals)
            {
                var deal = new Deal
                {
                    AccountGroup = bookLessDeal.AccountGroup,
                    BankPrice = bookLessDeal.BankPrice,
                    //Side = bookLessDeal.Side.GetTypeCode() == Side.Buy.GetTypeCode() ? Side.Buy : Side.Sell,
                    Side = bookLessDeal.Side.ToString() == Side.Buy.ToString() || bookLessDeal.Side.ToString() == Side.Sell.ToString()
                        ? (Side)bookLessDeal.Side.ParseEnum(typeof(Side))
                        : Side.Buy, //horrific assumption here, might actually need to send back BooklessDeals instead of Deals
                    Comment = bookLessDeal.Comment,
                    ClientId = bookLessDeal.ClientId,
                    ClientPrice = bookLessDeal.ClientPrice,
                    DealId = bookLessDeal.DealId,
                    Instrument = bookLessDeal.Instrument,
                    OrderId = bookLessDeal.OrderId,
                    Server = bookLessDeal.Server,
                    TimeStamp = bookLessDeal.TimeStamp,
                    Volume = bookLessDeal.Volume,
                    Book = bookLessDeal.Book == Book.A.ToString() || bookLessDeal.Book == Book.B.ToString()
                        ? (Book) bookLessDeal.Book.ParseEnum(typeof (Book))
                        : Book.None,
                    State = bookLessDeal.State.ToString().Parse<DealState>() ?? DealState.OpenNormal
                };
                //check to see if book was in the correct format after all...
                if (deal.Book == Book.None)
                {
                    short book;
                    deal.Book = Int16.TryParse(bookLessDeal.Book, out book)
                        ? (Book) book.ParseEnum(typeof (Book))
                        : Book.None;
                }
                deals.Add(deal);

            }

            return deals;
        }

        private static void DebugPrintDeals(IEnumerable<Deal> deals)
        {
            foreach (Deal deal in deals)
            {
                string dealstring = string.Format("{0} {1} {2} {3} {4} {5} {6} {7} {8} {9} {10} {11} {12} {13} {14}",
                    deal.TimeStamp, deal.DealId, deal.Server, deal.ClientId,
                    deal.OrderId, deal.Side, deal.State, deal.Instrument, deal.Volume,
                    deal.ClientPrice, deal.BankPrice, deal.Book, deal.AccountGroup, deal.Comment,
                    deal.Data);
                Console.WriteLine(dealstring);
            }
        }
    }
}