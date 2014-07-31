using Alpari.QualityAssurance.SpecFlowExtensions.Annotations;
using System;
using System.Data;

namespace Alpari.QA.QDF.Test.Domain.TypedDataTables.QDF
{
    public class TradeWithEventIdWithDealAndOrderDataTable : TradeWithEventIdDataTable
    {
        public TradeWithEventIdWithDealAndOrderDataTable()
        {
            SetupColumns();
        }

        public TradeWithEventIdWithDealAndOrderDataTable(string tableName, string[] primaryKeys)
        {
            SetupColumns();
            TableName = tableName;
            SetPrimaryKey(primaryKeys);
        }

        [UsedImplicitly]
        public new TradeWithEventIdWithDealAndOrderDataTableRow this[int idx]
        {
            get { return (TradeWithEventIdWithDealAndOrderDataTableRow)Rows[idx]; }
        }

        [UsedImplicitly]
        public void Add(TradeWithEventIdWithDealAndOrderDataTableRow row)
        {
            Rows.Add(row);
        }

        [UsedImplicitly]
        public void Remove(TradeWithEventIdWithDealAndOrderDataTableRow row)
        {
            Rows.Remove(row);
        }

        [UsedImplicitly]
        public new TradeWithEventIdWithDealAndOrderDataTableRow GetNewRow()
        {
            var row = (TradeWithEventIdWithDealAndOrderDataTableRow)NewRow();
            return row;
        }

        protected override Type GetRowType()
        {
            return typeof(TradeWithEventIdWithDealAndOrderDataTableRow);
        }

        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        {
            return new TradeWithEventIdWithDealAndOrderDataTableRow(builder);
        }

        protected new virtual void SetupColumns()
        {
            Columns.Add(new DataColumn("deal", typeof(ulong)));
            Columns.Add(new DataColumn("login", typeof(ulong)));
            Columns.Add(new DataColumn("order", typeof(ulong)));
        }
    }

    public class TradeWithEventIdWithDealAndOrderDataTableRow : TradeWithEventIdDataTableRow
    {
        internal TradeWithEventIdWithDealAndOrderDataTableRow(DataRowBuilder builder) : base(builder)
        {
        }

        [UsedImplicitly]
        public ulong Deal
        {
            get { return (ulong)base["deal"]; }
            set { base["deal"] = value; }
        }

        [UsedImplicitly]
        public ulong Login
        {
            get { return (ulong)base["login"]; }
            set { base["login"] = value; }
        }

        [UsedImplicitly]
        public ulong Order
        {
            get { return (ulong)base["order"]; }
            set { base["order"] = value; }
        }
    }
}
