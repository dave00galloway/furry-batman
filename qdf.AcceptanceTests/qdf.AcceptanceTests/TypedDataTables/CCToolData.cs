﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace qdf.AcceptanceTests.TypedDataTables
{
    /// <summary>
    /// with thanks to 
    /// http://www.codeproject.com/Articles/30490/How-to-Manually-Create-a-Typed-DataTable
    /// </summary>
    public class CCToolData : DataTable
    {
        public CCToolData()
        {
            Columns.Add(new DataColumn("ServerName", typeof(string)));
            Columns.Add(new DataColumn("PlatformId", typeof(int)));
            Columns.Add(new DataColumn("Id", typeof(int)));
            Columns.Add(new DataColumn("DatabaseName", typeof(string)));
            Columns.Add(new DataColumn("SymbolCode", typeof(string)));
            Columns.Add(new DataColumn("IsBookA", typeof(ulong)));
            Columns.Add(new DataColumn("BidPrice", typeof(decimal)));
            Columns.Add(new DataColumn("AskPrice", typeof(decimal)));
            Columns.Add(new DataColumn("Volume", typeof(decimal)));
            Columns.Add(new DataColumn("ContractSize", typeof(decimal)));
            Columns.Add(new DataColumn("UpdateDateTime", typeof(System.DateTime)));

        }

        public CCtoolRow this[int idx]
        {
            get { return (CCtoolRow)Rows[idx]; }
        }

        public void Add(CCtoolRow row)
        {
            Rows.Add(row);
        }

        public void Remove(CCtoolRow row)
        {
            Rows.Remove(row);
        }

        public CCtoolRow GetNewRow()
        {
            CCtoolRow row = (CCtoolRow)NewRow();

            return row;
        }

        protected override Type GetRowType()
        {
            return typeof(CCtoolRow);
        }

        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        {
            return new CCtoolRow(builder);
        }
    }

    public class CCtoolRow : DataRow
    {
        private DataRowBuilder builder;

        internal CCtoolRow(DataRowBuilder builder):base(builder)
        {
            this.builder = builder;
        }

        public string ServerName
        {
            get { return (string)base["ServerName"]; }
            set { base ["ServerName"] = value; }
        }

        public int PlatformId
        {
            get { return (int)base["PlatformId"]; }
            set { base["PlatformId"] = value; }
        }

        public int Id
        {
            get { return (int)base["Id"]; }
            set { base["Id"] = value; }
        }

        public string DatabaseName
        {
            get { return (string)base["DatabaseName"]; }
            set { base["DatabaseName"] = value; }
        }

        public string SymbolCode
        {
            get { return (string)base["SymbolCode"]; }
            set { base["SymbolCode"] = value; }
        }

        public ulong IsBookA
        {
            get { return (ulong)base["IsBookA"]; }
            set { base["IsBookA"] = value; }
        }

        public decimal BidPrice
        {
            get { return (decimal)base["BidPrice"]; }
            set { base["BidPrice"] = value; }
        }

        public decimal AskPrice
        {
            get { return (decimal)base["AskPrice"]; }
            set { base["AskPrice"] = value; }
        }

        public decimal Volume
        {
            get { return (decimal)base["Volume"]; }
            set { base["Volume"] = value; }
        }

        public decimal ContractSize
        {
            get { return (decimal)base["ContractSize"]; }
            set { base["ContractSize"] = value; }
        }

        public System.DateTime UpdateDateTime
        {
            get { return (System.DateTime)base["UpdateDateTime"]; }
            set { base["UpdateDateTime"] = value; }
        }
    }
}
