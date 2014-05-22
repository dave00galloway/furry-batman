using System;

namespace qdf.AcceptanceTests.DataContexts
{
    /// <summary>
    /// Interface that the CompareData Contexts must adhere to
    /// </summary>
    public interface ICompareData
    {
        T Data<T>() where T : ICompareDataTable;
    }

    /// <summary>
    /// Interface that the data in the tables of the Compare Data COntexts must adhere to
    /// </summary>
    public interface ICompareDataTable
    {
        long Id { get; set; }

        string Server { get; set; }

        string Symbol { get; set; }

        decimal Position { get; set; }

        DateTime TimeStamp { get; set; }

        string Source { get; set; }

        string Book { get; set; }

        string Section { get; set; }
    }
}
