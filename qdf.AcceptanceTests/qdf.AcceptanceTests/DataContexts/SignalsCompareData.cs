using Alpari.QualityAssurance.SpecFlowExtensions.Annotations;

namespace qdf.AcceptanceTests.DataContexts
{
    /// <summary>
    /// wrapper class for SignalsCompareDataDataContext to allow BoDi to set up contexts via DI
    /// </summary>
    [UsedImplicitly]
    public class SignalsCompareData
    {
        public SignalsCompareDataDataContext SignalsCompareDataDataContext { get; private set; }

        public SignalsCompareData()
        {
            SignalsCompareDataDataContext = new SignalsCompareDataDataContext();
        }
    }
}
