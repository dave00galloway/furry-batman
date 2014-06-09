using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.QueryableEntities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using BookSleeve;
using System;
using System.Collections.Generic;

namespace Alpari.QDF.UIClient.App
{
    /// <summary>
    ///     warning - repeated this code in qdf.AcceptanceTests.Helpers
    /// </summary>
    public class RedisConnectionHelper
    {
        private readonly RedisDealSearches _redisDealSearches;

        public RedisConnectionHelper(string redisHost)
        {
            RedisHost = redisHost;
            Connection = new RedisConnection(RedisHost);
            Connection.Open();
            _redisDealSearches = new RedisDealSearches(this);
        }

        public RedisDataStore DealsStore { get; set; }
        public List<Deal> RetrievedDeals { get; set; }
        public RedisDataStore QuoteStore { get; set; }
        public List<PriceQuote> RetrievedQuotes { get; set; }
        public RedisConnection Connection { get; set; }
        public string RedisHost { get; private set; }

        public RedisDealSearches RedisDealSearches
        {
            get { return _redisDealSearches; }
        }

        public void GetQuoteData(QuoteSearchCriteria quoteSearchCriteria)
        {
            //set up the search parameters
            quoteSearchCriteria.Resolve();

            //get the deals for the date range
            IEnumerable<PriceQuote> quotes = GetQuotesForDateRange(quoteSearchCriteria.ConvertedStartTime,
                quoteSearchCriteria.ConvertedEndTime);

            //filter the results using the search parameters
            RetrievedQuotes = FilterQuotesBySearchCriteria(quotes, quoteSearchCriteria);
        }

        private List<PriceQuote> FilterQuotesBySearchCriteria(IEnumerable<PriceQuote> quotes, QuoteSearchCriteria quoteSearchCriteria)
        {
            //foreach (PriceQuote priceQuote in quotes)
            //{
            //    Console.WriteLine(priceQuote.ToSafeString());
            //}
            
            return quotes.ToList();
        }

        private IEnumerable<PriceQuote> GetQuotesForDateRange(DateTime convertedStartTime, DateTime convertedEndTime)
        {
            QuoteStore = new RedisDataStore(Connection,
                            new SortedSetBasedStorageStrategy(Connection, new ProtoBufSerializer()));
            var priceQuotes = QuoteStore.Load<PriceQuote>(KeyConfig.KeyNamespaces.PriceQuote, convertedStartTime, convertedEndTime, TimeSpan.FromMinutes(10));
            //DateTime start = DateTime.UtcNow;
            //IEnumerable<PriceQuote> priceQuotes = QuoteStore.Load<PriceQuote>(KeyConfig.KeyNamespaces.PriceQuote, start.AddMinutes(-59), start, TimeSpan.FromMinutes(10));
            //foreach (PriceQuote priceQuote in priceQuotes)
            //{
            //    Console.WriteLine(priceQuote.ToSafeString());
            //}
            return priceQuotes;
        }

        
    }
}