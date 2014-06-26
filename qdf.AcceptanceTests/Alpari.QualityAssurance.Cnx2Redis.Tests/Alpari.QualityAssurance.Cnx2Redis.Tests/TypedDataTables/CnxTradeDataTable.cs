using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Annotations;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables
{
    [DesignerCategory("")]
    public class CnxTradeDataTable : TypedDataTable
    {
        public CnxTradeDataTable()
        {
// ReSharper disable once DoNotCallOverridableMethodsInConstructor
            SetupColumns();
        }

        [UsedImplicitly]
        public CnxTradeDataTableRow this[int idx]
        {
            get { return (CnxTradeDataTableRow) Rows[idx]; }
        }

        [UsedImplicitly]
        public void Add(CnxTradeDataTableRow row)
        {
            Rows.Add(row);
        }

        [UsedImplicitly]
        public void Remove(CnxTradeDataTableRow row)
        {
            Rows.Remove(row);
        }

        [UsedImplicitly]
        public CnxTradeDataTableRow GetNewRow()
        {
            var row = (CnxTradeDataTableRow) NewRow();

            return row;
        }

        protected override Type GetRowType()
        {
            return typeof (CnxTradeDataTableRow);
        }

        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        {
            return new CnxTradeDataTableRow(builder);
        }
        # region replace methods with ones taking a plainer enumerable type rather thana data row
        //[UsedImplicitly]
        //public CnxTradeDataTable ConvertIEnumerableToDataTable(IEnumerable<CnxTradeDataTableRow> enumeratedObjects)
        //{
        //    return SetupDataTable(enumeratedObjects, this);
        //}

        //[UsedImplicitly]
        //public CnxTradeDataTable ConvertIEnumerableToDataTable(IEnumerable<CnxTradeDataTableRow> enumeratedObjects,
        //    string tableName,
        //    string[] primaryKeys)
        //{
        //    TableName = tableName;
        //    SetPrimaryKey(primaryKeys);
        //    return SetupDataTable(enumeratedObjects, this);
        //}

        //private static CnxTradeDataTable SetupDataTable(IEnumerable<CnxTradeDataTableRow> enumeratedObjects,
        //    CnxTradeDataTable ccToolDataTable)
        //{
        //    foreach (CnxTradeDataTableRow cnxTradeDataTableRow in enumeratedObjects)
        //    {
        //        ccToolDataTable.Rows.Add(new object[]
        //        {
        //            cnxTradeDataTableRow.SecurityId, cnxTradeDataTableRow.Price, cnxTradeDataTableRow.SpotRate,
        //            cnxTradeDataTableRow.SpotRateHubToMaker, cnxTradeDataTableRow.AmountCcy1,
        //            cnxTradeDataTableRow.AmountCcy2, cnxTradeDataTableRow.Side, cnxTradeDataTableRow.OrderId,
        //            cnxTradeDataTableRow.Login, cnxTradeDataTableRow.TradeId, cnxTradeDataTableRow.LinkedTradeId,
        //            cnxTradeDataTableRow.TransactTime, cnxTradeDataTableRow.TradeDate, cnxTradeDataTableRow.SettlDate,
        //            cnxTradeDataTableRow.Party1Role, cnxTradeDataTableRow.Party1Name, cnxTradeDataTableRow.Party2Role,
        //            cnxTradeDataTableRow.Party2Name, cnxTradeDataTableRow.Comment, cnxTradeDataTableRow.ServerId,
        //            cnxTradeDataTableRow.GiveupStatus,
        //            cnxTradeDataTableRow.Book, cnxTradeDataTableRow.Hub, cnxTradeDataTableRow.ClientOrderId,
        //            cnxTradeDataTableRow.TradedCcy, cnxTradeDataTableRow.CounterCcy, cnxTradeDataTableRow.Aggressor,
        //            cnxTradeDataTableRow.TradeType, cnxTradeDataTableRow.ForwardPoints, cnxTradeDataTableRow.SwapPoints,
        //            cnxTradeDataTableRow.FarAmountccy1, cnxTradeDataTableRow.FarAmountccy2,
        //            cnxTradeDataTableRow.FarSettlDate, cnxTradeDataTableRow.TradeReportId,
        //            cnxTradeDataTableRow.ReconcilStatus, cnxTradeDataTableRow.Id
        //        }
        //            );
        //    }
        //    ccToolDataTable.AcceptChanges();
        //    return ccToolDataTable;
        //}
        #endregion

        protected override void SetupColumns()
        {
            Columns.Add(new DataColumn("security_id", typeof (ulong)));
            Columns.Add(new DataColumn("price", typeof (double)));
            Columns.Add(new DataColumn("spotrate", typeof (double)));
            Columns.Add(new DataColumn("spotratehubtomaker", typeof (double)));
            Columns.Add(new DataColumn("amountccy1", typeof (double)));
            Columns.Add(new DataColumn("amountccy2", typeof (double)));
            Columns.Add(new DataColumn("side", typeof (string)));
            Columns.Add(new DataColumn("order_id", typeof (string)));
            Columns.Add(new DataColumn("login", typeof (string)));
            Columns.Add(new DataColumn("trade_id", typeof (string)));
            Columns.Add(new DataColumn("linked_trade_id", typeof (string)));
            Columns.Add(new DataColumn("transact_time", typeof (DateTime)));
            Columns.Add(new DataColumn("trade_date", typeof (DateTime)));
            Columns.Add(new DataColumn("settl_date", typeof (DateTime)));
            Columns.Add(new DataColumn("party_1_role", typeof (uint)));
            Columns.Add(new DataColumn("party_1_name", typeof (string)));
            Columns.Add(new DataColumn("party_2_role", typeof (uint)));
            Columns.Add(new DataColumn("party_2_name", typeof (string)));
            Columns.Add(new DataColumn("comment", typeof (string)));
            Columns.Add(new DataColumn("server_id", typeof (uint)));
            Columns.Add(new DataColumn("giveup_status", typeof (byte)));
            Columns.Add(new DataColumn("book", typeof (string)));
            Columns.Add(new DataColumn("hub", typeof (string)));
            Columns.Add(new DataColumn("client_order_id", typeof (string)));
            Columns.Add(new DataColumn("traded_ccy", typeof (string)));
            Columns.Add(new DataColumn("counter_ccy", typeof (string)));
            Columns.Add(new DataColumn("aggressor", typeof (bool)));
            Columns.Add(new DataColumn("trade_type", typeof (long)));
            Columns.Add(new DataColumn("forward_points", typeof (double)));
            Columns.Add(new DataColumn("swap_points", typeof (double)));
            Columns.Add(new DataColumn("far_amountccy1", typeof (double)));
            Columns.Add(new DataColumn("far_amountccy2", typeof (double)));
            Columns.Add(new DataColumn("far_settl_date", typeof (DateTime)));
            Columns.Add(new DataColumn("trade_report_id", typeof (uint)));
            Columns.Add(new DataColumn("reconcil_status", typeof (bool)));
            Columns.Add(new DataColumn("id", typeof (long)));
        }
    }

    public class CnxTradeDataTableRow : DataRow
    {
        internal CnxTradeDataTableRow(DataRowBuilder builder) : base(builder)
        {
        }

        [UsedImplicitly]
        public ulong SecurityId
        {
            get { return (ulong) base["security_id"]; }
            set { base["security_id"] = value; }
        }

        [UsedImplicitly]
        public double Price
        {
            get { return (double) base["price"]; }
            set { base["price"] = value; }
        }

        [UsedImplicitly]
        public double SpotRate
        {
            get { return (double) base["spotrate"]; }
            set { base["spotrate"] = value; }
        }

        [UsedImplicitly]
        public double SpotRateHubToMaker
        {
            get { return (double) base["spotratehubtomaker"]; }
            set { base["spotratehubtomaker"] = value; }
        }

        [UsedImplicitly]
        public double AmountCcy1
        {
            get { return (double) base["amountccy1"]; }
            set { base["amountccy1"] = value; }
        }

        [UsedImplicitly]
        public double AmountCcy2
        {
            get { return (double) base["amountccy2"]; }
            set { base["amountccy2"] = value; }
        }

        [UsedImplicitly]
        public string Side
        {
            get { return (string) base["side"]; }
            set { base["side"] = value; }
        }

        [UsedImplicitly]
        public string OrderId
        {
            get
            {
                try
                {
                    return (string) base["order_id"];
                }
                catch (Exception)
                {
                    OrderId = "";
                    return "";
                }
            }
            set { base["order_id"] = value; }
        }

        [UsedImplicitly]
        public string Login
        {
            get { return (string) base["login"]; }
            set { base["login"] = value; }
        }

        [UsedImplicitly]
        public string TradeId
        {
            get { return (string) base["trade_id"]; }
            set { base["trade_id"] = value; }
        }

        [UsedImplicitly]
        public string LinkedTradeId
        {
            get { return (string) base["linked_trade_id"]; }
            set { base["linked_trade_id"] = value; }
        }

        [UsedImplicitly]
        public DateTime TransactTime
        {
            get { return (DateTime) base["transact_time"]; }
            set { base["transact_time"] = value; }
        }

        [UsedImplicitly]
        public DateTime TradeDate
        {
            get { return (DateTime) base["trade_date"]; }
            set { base["trade_date"] = value; }
        }

        [UsedImplicitly]
        public DateTime SettlDate
        {
            get { return (DateTime) base["settl_date"]; }
            set { base["settl_date"] = value; }
        }

        [UsedImplicitly]
        public uint Party1Role
        {
            get { return (uint) base["party_1_role"]; }
            set { base["party_1_role"] = value; }
        }

        [UsedImplicitly]
        public string Party1Name
        {
            get { return (string) base["party_1_name"]; }
            set { base["party_1_name"] = value; }
        }


        [UsedImplicitly]
        public uint Party2Role
        {
            get { return (uint) base["party_2_role"]; }
            set { base["party_2_role"] = value; }
        }

        [UsedImplicitly]
        public string Party2Name
        {
            get { return (string) base["party_2_name"]; }
            set { base["party_2_name"] = value; }
        }

        [UsedImplicitly]
        public string Comment
        {
            get { return (string) base["comment"]; }
            set { base["comment"] = value; }
        }

        [UsedImplicitly]
        public uint ServerId
        {
            get { return (uint) base["server_id"]; }
            set { base["server_id"] = value; }
        }

        [UsedImplicitly]
        public byte GiveupStatus
        {
            get { return (byte) base["giveup_status"]; }
            set { base["giveup_status"] = value; }
        }

        /// <summary>
        /// returns a 0 string if returning a book throws an exception to reperesent a "None" book
        /// might be an idea to adjust the query at the db end to return a 0 string instead of null...
        /// </summary>
        [UsedImplicitly]
        public string Book
        {
            get
            {
                try
                {
                    return (string) base["book"];
                }
                catch (Exception)
                {
                    Book = "0";
                    return "";
                }
            }
            set
            {
                base["book"] = value;
            }
        }

        [UsedImplicitly]
        public string Hub
        {
            get { return (string) base["hub"]; }
            set { base["hub"] = value; }
        }

        [UsedImplicitly]
        public string ClientOrderId
        {
            get { return (string) base["client_order_id"]; }
            set { base["client_order_id"] = value; }
        }

        [UsedImplicitly]
        public string TradedCcy
        {
            get { return (string) base["traded_ccy"]; }
            set { base["traded_ccy"] = value; }
        }

        [UsedImplicitly]
        public string CounterCcy
        {
            get { return (string) base["counter_ccy"]; }
            set { base["counter_ccy"] = value; }
        }

        [UsedImplicitly]
        public bool Aggressor
        {
            get { return (bool) base["aggressor"]; }
            set { base["aggressor"] = value; }
        }

        [UsedImplicitly]
        public long TradeType
        {
            get { return (long)base["trade_type"]; }
            set { base["trade_type"] = value; }
        }

        [UsedImplicitly]
        public double ForwardPoints
        {
            get { return (double) base["forward_points"]; }
            set { base["forward_points"] = value; }
        }

        [UsedImplicitly]
        public double SwapPoints
        {
            get { return (double) base["swap_points"]; }
            set { base["swap_points"] = value; }
        }

        [UsedImplicitly]
        public double FarAmountccy1
        {
            get { return (double) base["far_amountccy1"]; }
            set { base["far_amountccy1"] = value; }
        }

        [UsedImplicitly]
        public double FarAmountccy2
        {
            get { return (double) base["far_amountccy2"]; }
            set { base["far_amountccy2"] = value; }
        }

        [UsedImplicitly]
        public DateTime FarSettlDate
        {
            get { return (DateTime) base["far_settl_date"]; }
            set { base["far_settl_date"] = value; }
        }

        [UsedImplicitly]
        public uint TradeReportId
        {
            get { return (uint) base["trade_report_id"]; }
            set { base["trade_report_id"] = value; }
        }

        [UsedImplicitly]
        public bool ReconcilStatus
        {
            get { return (bool) base["reconcil_status"]; }
            set { base["reconcil_status"] = value; }
        }

        [UsedImplicitly]
        public long Id
        {
            get { return (long) base["id"]; }
            set { base["id"] = value; }
        }
    }
}