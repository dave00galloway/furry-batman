using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App.Annotations;

namespace Alpari.QDF.UIClient.App
{
    /// <summary>
    /// Extension of Deal to set up parameters for filtering query results
    /// </summary>
    [UsedImplicitly]
    public class DealSearchCriteria : Deal
    {
        public DateTime ConvertedStartTime { get; set; }
        public DateTime ConvertedEndTime { get; set; }
        public List<Book> BookList { get; private set; }
        public List<string> InstrumentList { get; private set; }
        public List<TradingServer> TradingServers { get; private set; }

    }
}
