﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Linq;
using System.Linq;
using System.Runtime.CompilerServices;

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

        public Table<ICompareDataTable> Data()
        {
            Table<CompareData> compareData = GetTable<CompareData>();
            Table<ICompareDataTable> data = GetTable <ICompareDataTable>();

            foreach (ICompareDataTable record in compareData)
            {
                ICompareDataTable newRecord = new CompareData();
                newRecord.Book = record.Book;
                newRecord.Id = record.Id;
                newRecord.Position = record.Position;
                newRecord.Section = record.Section;
                newRecord.Server = record.Server;
                newRecord.Source = record.Source;
                newRecord.Symbol = record.Symbol;
                newRecord.TimeStamp = record.TimeStamp;
                data.InsertOnSubmit(newRecord);
            }
            return data;
        }
    }

    // ReSharper disable once InconsistentNaming
    public partial class CompareData : ICompareDataTable
    {

    }
}
