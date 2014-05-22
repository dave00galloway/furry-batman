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
    public partial class SignalsCompareDataDataContext : ICompareData
    {
        /// <summary>
        /// Set the command timeout to infinity
        /// </summary>
        partial void OnCreated()
        {
            CommandTimeout = 0;
        }

        public T Data<T>() where T : ICompareDataTable
        {
            return (T) Convert.ChangeType(CompareDatas,typeof(T));
        }
    }

    // ReSharper disable once InconsistentNaming
    public partial class CompareData : ICompareDataTable
    {

    }
}
