﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QDF.UIClient.App.ControlHelpers
{
    public class ControlSetup
    {
        public ControlSetup(TradingServerControl tradingServerControl, BookControl bookControl, SymbolControl symbolControl, EnvironmentControl environmentControl)
        {
            TradingServerControl = tradingServerControl;
            BookControl = bookControl;
            SymbolControl = symbolControl;
            EnvironmentControl = environmentControl;
        }

        public TradingServerControl TradingServerControl { get; private set; }
        public BookControl BookControl { get; private set; }
        public SymbolControl SymbolControl { get; private set; }
        public EnvironmentControl EnvironmentControl { get; private set; }
    }
}
