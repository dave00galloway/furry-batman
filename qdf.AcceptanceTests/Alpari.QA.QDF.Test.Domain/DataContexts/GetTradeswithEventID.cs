namespace Alpari.QA.QDF.Test.Domain.DataContexts
{
    /// <summary>
    /// wrapper class for SignalsCompareDataDataContext to allow BoDi to set up contexts via DI
    /// </summary>
    public class GetTradesWithEventId
    {
        public GetTradeswithEventIDDataContext GetTradeswithEventIdDataContext { get; private set;}

        public GetTradesWithEventId()
        {
            GetTradeswithEventIdDataContext = new GetTradeswithEventIDDataContext();
        }
    }
}
