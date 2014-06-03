using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QDF.UIClient.App.ControlHelpers
{
    public class ControlSetup
    {
        public ControlSetup(TradingServerControl tradingServerControl)
        {
            TradingServerControl = tradingServerControl;
        }

        public TradingServerControl TradingServerControl { get; set; }
    }
}
