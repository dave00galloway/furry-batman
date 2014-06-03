using Alpari.QDF.Domain;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using System.Collections.Generic;

namespace Alpari.QDF.UIClient.App.ControlHelpers
{
    public class TradingServerControl
    {
        public List<string> ServerList { get; set; }
        public TradingServerControl()
        {
            var values = EnumExtensions.GetValues<TradingServer>();
            ServerList = new List<string>();
            foreach (TradingServer tradingServer in values)
            {
                ServerList.Add(tradingServer.ToString());
            }
            ServerList.Sort();
        }

    }
}
