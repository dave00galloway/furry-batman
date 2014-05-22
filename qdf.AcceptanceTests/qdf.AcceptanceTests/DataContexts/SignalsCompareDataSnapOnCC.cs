using System;
using System.Data.Linq;

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
    public partial class SignalsCompareDataSnapOnCCDataContext : ICompareData
    {
        partial void OnCreated()
        {
            CommandTimeout = 0;
        }

        //public T Data<T>() where T : ICompareDataTable
        //{
        //    return (T) Convert.ChangeType(CompareDataSnapOnCCs,typeof(T));
        //}

        public Table<ICompareDataTable> Data()
        {
            throw new NotImplementedException();
        }
    }

// ReSharper disable once InconsistentNaming
    public partial class CompareDataSnapOnCC : ICompareDataTable
    {
         
    }
}
