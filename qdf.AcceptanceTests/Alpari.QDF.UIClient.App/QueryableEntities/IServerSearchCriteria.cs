using System.Collections.Generic;
using Alpari.QDF.Domain;

namespace Alpari.QDF.UIClient.App.QueryableEntities
{
    public interface IServerSearchCriteria
    {
        string Servers { get; set; }
        TradingServer Server { get; set; }
        List<TradingServer> TradingServerList { get; set; }
        char Separator { get; set; }
        void Resolve();
        void SetUpServers();
        void SafelyAddTradingServers(string serverName);
    }
}