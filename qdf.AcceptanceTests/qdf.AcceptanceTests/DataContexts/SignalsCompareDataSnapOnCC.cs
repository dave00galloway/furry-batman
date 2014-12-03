namespace qdf.AcceptanceTests.DataContexts
{
    /// <summary>
    /// wrapper class for SignalsCompareDataSnapOnCCDataContext to allow BoDi to set up contexts via DI
    /// </summary>
    public class SignalsCompareDataSnapOnCc
    {
        public SignalsCompareDataSnapOnCCDataContext SignalsCompareDataSnapOnCcDataContext { get; private set; }

        public SignalsCompareDataSnapOnCc()
        {
            SignalsCompareDataSnapOnCcDataContext = new SignalsCompareDataSnapOnCCDataContext();
        }
    }

    
// ReSharper disable once InconsistentNaming
    /// <summary>
    /// 
    /// </summary>
    public partial class SignalsCompareDataSnapOnCCDataContext
    {
        //has to be a const to be used in a switch so can't do this:-
        //public const string FULL_NAME = typeof(SignalsCompareDataSnapOnCCDataContext).FullName;
        public const string FULL_NAME = "qdf.AcceptanceTests.DataContexts.SignalsCompareDataSnapOnCCDataContext";

        partial void OnCreated()
        {
            CommandTimeout = 0;
        }
    }

    // ReSharper disable once InconsistentNaming
    public partial class CompareDataSnapOnCC : ICompareDataTable
    {

    }

}
