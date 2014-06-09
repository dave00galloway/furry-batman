namespace Alpari.QDF.UIClient.App.ControlHelpers
{
    public class ControlSetup
    {
        public ControlSetup(TradingServerControl tradingServerControl, BookControl bookControl,
            SymbolControl symbolControl, EnvironmentControl environmentControl,
            SupportedDataTypesControl supportedDataTypesControl)
        {
            TradingServerControl = tradingServerControl;
            BookControl = bookControl;
            SymbolControl = symbolControl;
            EnvironmentControl = environmentControl;
            SupportedDataTypesControl = supportedDataTypesControl;
        }

        public TradingServerControl TradingServerControl { get; private set; }
        public BookControl BookControl { get; private set; }
        public SymbolControl SymbolControl { get; private set; }
        public EnvironmentControl EnvironmentControl { get; private set; }
        public SupportedDataTypesControl SupportedDataTypesControl { get; private set; }
    }
}