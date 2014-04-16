using Alpari.QDF;
using BookSleeve;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace qdf.AcceptanceTests.Helpers
{
    public class RedisConnectionHelper
    {
        public RedisDataStore dealsStore { get; private set; }
        public RedisConnection connection { get; private set; }
        public string redisHost { get; private set; }
        public RedisConnectionHelper(string redisHost)
        {
            this.redisHost = redisHost;
            connection = new RedisConnection(this.redisHost);
            connection.Open();
            dealsStore = new RedisDataStore(connection, new SortedSetBasedStorageStrategy(connection, new JsonSerializer()));
        }
    }
}
