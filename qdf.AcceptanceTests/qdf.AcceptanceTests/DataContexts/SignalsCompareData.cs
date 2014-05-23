using System;

namespace qdf.AcceptanceTests.DataContexts
{
    /// <summary>
    /// wrapper class for SignalsCompareDataDataContext to allow BoDi to set up contexts via DI
    /// </summary>
    public class SignalsCompareData
    {
        public SignalsCompareDataDataContext SignalsCompareDataDataContext { get; private set; }

        public SignalsCompareData()
        {
            SignalsCompareDataDataContext = new SignalsCompareDataDataContext();
        }
    }

    /// <summary>
    /// Extensibility point of SignalsCompareDataDataContext
    /// </summary>
    public partial class SignalsCompareDataDataContext
    {
        //has to be a const to be used in a switch so can't do this:-
        //public const string FULL_NAME = typeof(SignalsCompareDataDataContext).FullName;
        public const string FULL_NAME = "qdf.AcceptanceTests.DataContexts.SignalsCompareDataDataContext";

        /// <summary>
        /// Set the command timeout to infinity
        /// </summary>
        partial void OnCreated()
        {
            CommandTimeout = 0;
        }
    }

    // ReSharper disable once InconsistentNaming
    public partial class CompareData : ICompareDataTable
    {

    }

}
