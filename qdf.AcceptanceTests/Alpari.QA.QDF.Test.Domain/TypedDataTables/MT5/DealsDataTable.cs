using Alpari.QualityAssurance.SpecFlowExtensions.Annotations;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using System;
using System.Data;

namespace Alpari.QA.QDF.Test.Domain.TypedDataTables.MT5
{
    /// <summary>
    ///     Typed Data table holding selected data from MT5.Deals table for matching with
    ///     IGetTradeswithEventIDResult comparisons
    /// </summary>
    public class DealsDataTable : TypedDataTable
    {
        public DealsDataTable()
        {
// ReSharper disable DoNotCallOverridableMethodsInConstructor
            SetupColumns();
        }

        public DealsDataTable(string tableName, string[] primaryKeys)
        {
            SetupColumns();
            TableName = tableName;
            SetPrimaryKey(primaryKeys);
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        [UsedImplicitly]
        public DealsDataRow this[int idx]
        {
            get { return (DealsDataRow) Rows[idx]; }
        }

        [UsedImplicitly]
        public void Add(DealsDataRow row)
        {
            Rows.Add(row);
        }

        [UsedImplicitly]
        public void Remove(DealsDataRow row)
        {
            Rows.Remove(row);
        }

        [UsedImplicitly]
        public DealsDataRow GetNewRow()
        {
            var row = (DealsDataRow) NewRow();

            return row;
        }

        protected override Type GetRowType()
        {
            return typeof (DealsDataRow);
        }

        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        {
            return new DealsDataRow(builder);
        }

        protected override void SetupColumns()
        {
            Columns.Add(new DataColumn("deal", typeof (ulong)));
            Columns.Add(new DataColumn("login", typeof (ulong)));
            Columns.Add(new DataColumn("order", typeof (ulong)));
            Columns.Add(new DataColumn("action", typeof (uint)));
            Columns.Add(new DataColumn("timestamp", typeof (DateTime)));
            Columns.Add(new DataColumn("symbol", typeof (string)));
            Columns.Add(new DataColumn("price", typeof (decimal)));
            Columns.Add(new DataColumn("volume", typeof(ulong)));
            Columns.Add(new DataColumn("comment", typeof (string)));
        }
    }

    public class DealsDataRow : DataRow
    {
        internal DealsDataRow(DataRowBuilder builder) : base(builder)
        {
        }

        [UsedImplicitly]
        public ulong Deal
        {
            get { return (ulong) base["deal"]; }
            set { base["deal"] = value; }
        }

        [UsedImplicitly]
        public ulong Login
        {
            get { return (ulong) base["login"]; }
            set { base["login"] = value; }
        }

        [UsedImplicitly]
        public ulong Order
        {
            get { return (ulong) base["order"]; }
            set { base["order"] = value; }
        }

        [UsedImplicitly]
        public uint Action
        {
            get { return (uint) base["action"]; }
            set { base["action"] = value; }
        }

        [UsedImplicitly]
        public DateTime TimeStamp
        {
            get { return (DateTime) base["timestamp"]; }
            set { base["timestamp"] = value; }
        }

        [UsedImplicitly]
        public string Symbol
        {
            get { return (string) base["symbol"]; }
            set { base["symbol"] = value; }
        }

        [UsedImplicitly]
        public decimal Price
        {
            get { return (decimal) base["price"]; }
            set { base["price"] = value; }
        }

        [UsedImplicitly]
        public ulong Volume
        {
            get { return (ulong)base["volume"]; }
            set { base["volume"] = value; }
        }

        [UsedImplicitly]
        public string Comment
        {
            get { return (string) base["comment"]; }
            set { base["comment"] = value; }
        }
    }
}
