using System;
using System.Collections.Generic;
using System.Data;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Annotations;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables
{
    public class TestableDealDataTable : TypedDataTable
    {
        public TestableDealDataTable()
        {
// ReSharper disable once DoNotCallOverridableMethodsInConstructor
            SetupColumns();
        }

        [UsedImplicitly]
        public TestableDealDataTableRow this[int idx]
        {
            get { return (TestableDealDataTableRow) Rows[idx]; }
        }

        [UsedImplicitly]
        public void Add(TestableDealDataTableRow row)
        {
            Rows.Add(row);
        }

        [UsedImplicitly]
        public void Remove(TestableDealDataTableRow row)
        {
            Rows.Remove(row);
        }

        [UsedImplicitly]
        public TestableDealDataTableRow GetNewRow()
        {
            var row = (TestableDealDataTableRow) NewRow();

            return row;
        }

        protected override Type GetRowType()
        {
            return typeof (TestableDealDataTableRow);
        }

        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        {
            return new TestableDealDataTableRow(builder);
        }

        [UsedImplicitly]
        public TestableDealDataTable ConvertIEnumerableToDataTable(IEnumerable<TestableDeal> enumeratedObjects)
        {
            return SetupDataTable(enumeratedObjects, this);
        }

        [UsedImplicitly]
        public TestableDealDataTable ConvertIEnumerableToDataTable(IEnumerable<TestableDeal> enumeratedObjects,
            string tableName,
            string[] primaryKeys)
        {
            TableName = tableName;
            SetPrimaryKey(primaryKeys);
            return SetupDataTable(enumeratedObjects, this);
        }

        private static TestableDealDataTable SetupDataTable(IEnumerable<TestableDeal> enumeratedObjects,
            TestableDealDataTable ccToolDataTable)
        {
            foreach (TestableDeal deal in enumeratedObjects)
            {
                ccToolDataTable.Rows.Add(new object[]
                {
                    deal.AccountGroup, deal.BankPrice, deal.Book, deal.ClientId, deal.ClientPrice, deal.Comment,
                    deal.DealId, deal.Instrument, deal.OrderId, deal.Server, deal.Side, deal.State,
                    deal.TimeStamp.Truncate(TimeSpan.FromSeconds(1)), deal.Volume
                }
                    );
            }
            ccToolDataTable.AcceptChanges();
            return ccToolDataTable;
        }

        protected override void SetupColumns()
        {
            Columns.Add(new DataColumn("AccountGroup", typeof(string)));
            Columns.Add(new DataColumn("BankPrice", typeof(decimal)));
            Columns.Add(new DataColumn("Book", typeof(Book)));
            Columns.Add(new DataColumn("ClientId", typeof(string)));
            Columns.Add(new DataColumn("ClientPrice", typeof(decimal)));
            Columns.Add(new DataColumn("Comment", typeof(string)));
            Columns.Add(new DataColumn("DealId", typeof(string)));
            Columns.Add(new DataColumn("Instrument", typeof(string)));
            Columns.Add(new DataColumn("OrderId", typeof(string)));
            Columns.Add(new DataColumn("Server", typeof(TradingServer)));
            Columns.Add(new DataColumn("Side", typeof(TestableSide)));
            Columns.Add(new DataColumn("State", typeof(DealState)));
            Columns.Add(new DataColumn("TimeStamp", typeof(DateTime)));
            Columns.Add(new DataColumn("Volume", typeof(decimal)));
        }
    }

    public class TestableDealDataTableRow : DataRow
    {
        internal TestableDealDataTableRow([NotNull] DataRowBuilder builder) : base(builder)
        {
        }

        [UsedImplicitly]
        public string AccountGroup
        {
            get { return (string)base["AccountGroup"]; }
            set { base["AccountGroup"] = value; }
        }

        [UsedImplicitly]
        public decimal BankPrice
        {
            get { return (decimal) base["BankPrice"]; }
            set { base["BankPrice"] = value; }
        }

        [UsedImplicitly]
        public Book Book
        {
            get { return (Book) base["Book"]; }
            set { base["Book"] = value; }
        }

        [UsedImplicitly]
        public string ClientId
        {
            get { return (string) base["ClientId"]; }
            set { base["ClientId"] = value; }
        }

        [UsedImplicitly]
        public decimal ClientPrice
        {
            get { return (decimal) base["ClientPrice"]; }
            set { base["ClientPrice"] = value; }
        }

        [UsedImplicitly]
        public string Comment
        {
            get { return (string)base["Comment"]; }
            set { base["Comment"] = value; }
        }

        [UsedImplicitly]
        public string DealId
        {
            get { return (string) base["DealId"]; }
            set { base["DealId"] = value; }
        }

        [UsedImplicitly]
        public string Instrument
        {
            get { return (string) base["Instrument"]; }
            set { base["Instrument"] = value; }
        }

        [UsedImplicitly]
        public string OrderId
        {
            get { return (string)base["OrderId"]; }
            set { base["OrderId"] = value; }
        }

        [UsedImplicitly]
        public TradingServer Server
        {
            get { return (TradingServer) base["Server"]; }
            set { base["Server"] = value; }
        }

        [UsedImplicitly]
        public TestableSide TestableSide
        {
            get { return (TestableSide)base["Side"]; }
            set { base["Side"] = value; }
        }

        [UsedImplicitly]
        public DealState DealState
        {
            get { return (DealState)base["DealState"]; }
            set { base["DealState"] = value; }
        }

        [UsedImplicitly]
        public DateTime TimeStamp
        {
            get { return (DateTime)base["TimeStamp"]; }
            set { base["TimeStamp"] = value; }
        }

        [UsedImplicitly]
        public decimal Volume
        {
            get { return (decimal)base["Volume"]; }
            set { base["Volume"] = value; }
        }

    }
}