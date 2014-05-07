using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using qdf.AcceptanceTests.Annotations;
using qdf.AcceptanceTests.Helpers;

namespace qdf.AcceptanceTests.TypedDataTables
{
    public class QdfDealPosition : IAnalyzeablePosition
    {
        public string PositionName { get; set; }

        public Book Book { get; set; }

        public string Instrument { get; set; }

        public string ServerId
        {
            get { return Enum.ToObject(typeof (TradingServer), Server).ToString(); }
            set { Server = (TradingServer) Enum.Parse(typeof (TradingServer), value); }
        }

        public TradingServer Server { get; set; }

        public DateTime TimeStamp { get; set; }

        public List<Deal> QdfDeals { get; set; }

        /// <summary>
        ///     QdfDealCount is used when outputting deals to csv so the count of the deals for the position can be obtained
        /// </summary>
        [UsedImplicitly]
        public int QdfDealCount
        {
            get { return QdfDeals.Count(); }
        }

        public decimal Position { get; private set; }

        /// <summary>
        ///     CumulativePosition is used when outputting deals to csv and may be used as a comparison
        /// </summary>
        public decimal CumulativePosition { [UsedImplicitly] get; set; }

        public decimal PositionDelta { get; set; }

        public void CalculatePosition()
        {
            QdfDeals.ForEach(delegate(Deal deal) { Position += deal.Volume*(deal.Side == Side.Buy ? 1 : -1); });
        }
    }

    [DesignerCategory("")]
    public class QdfPositionDataTable : TypedDataTable
    {
        public QdfPositionDataTable()
        {
            SetupColumns();
        }

        protected override sealed void SetupColumns()
        {
            Columns.Add(new DataColumn("PositionName", typeof (string)));
            Columns.Add(new DataColumn("Book", typeof (Book)));
            Columns.Add(new DataColumn("Instrument", typeof (string)));
            Columns.Add(new DataColumn("ServerId", typeof (string)));
            Columns.Add(new DataColumn("TradingServer", typeof (TradingServer)));
            Columns.Add(new DataColumn("TimeStamp", typeof (DateTime)));
            Columns.Add(new DataColumn("QdfDeals", typeof (List<Deal>)));
            Columns.Add(new DataColumn("QdfDealCount", typeof (int)));
            Columns.Add(new DataColumn("Position", typeof (decimal)));
            Columns.Add(new DataColumn("CumulativePosition", typeof (decimal)));
            Columns.Add(new DataColumn("PositionDelta", typeof (decimal)));
        }

        [UsedImplicitly]
        public QdfPositionRow this[int idx]
        {
            get { return (QdfPositionRow) Rows[idx]; }
        }

        [UsedImplicitly]
        public void Add(QdfPositionRow row)
        {
            Rows.Add(row);
        }

        [UsedImplicitly]
        public void Remove(QdfPositionRow row)
        {
            Rows.Remove(row);
        }

        [UsedImplicitly]
        public QdfPositionRow GetNewRow()
        {
            var row = (QdfPositionRow) NewRow();

            return row;
        }

        protected override Type GetRowType()
        {
            return typeof (QdfPositionRow);
        }

        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        {
            return new QdfPositionRow(builder);
        }

        public QdfPositionDataTable ConvertIEnumerableToDataTable(IEnumerable<QdfDealPosition> enumeratedObjects)
        {
            return SetupDataTable(enumeratedObjects, this);
        }

        public QdfPositionDataTable ConvertIEnumerableToDataTable(IEnumerable<QdfDealPosition> enumeratedObjects,
            string tableName,
            string[] primaryKeys)
        {
            TableName = tableName;
            SetPrimaryKey(primaryKeys);
            return SetupDataTable(enumeratedObjects, this);
        }

        private static QdfPositionDataTable SetupDataTable(IEnumerable<QdfDealPosition> enumeratedObjects,
            QdfPositionDataTable dataTable)
        {
            foreach (QdfDealPosition position in enumeratedObjects)
            {
                dataTable.Rows.Add(new object[]
                {
                    position.PositionName, position.Book, position.Instrument, position.ServerId,
                    position.Server, position.TimeStamp, position.QdfDeals, position.QdfDealCount,
                    position.Position, position.CumulativePosition, position.PositionDelta
                }
                    );
            }
            dataTable.AcceptChanges();
            return dataTable;
        }
    }

    public class QdfPositionRow : DataRow
    {
        protected internal QdfPositionRow([NotNull] DataRowBuilder builder) : base(builder)
        {
        }

        [UsedImplicitly]
        public string PositionName
        {
            get { return (string)base["PositionName"]; }
            set { base["PositionName"] = value; }
        }

        [UsedImplicitly]
        public Book Book
        {
            get { return (Book)base["Book"]; }
            set { base["Book"] = value; }
        }

        [UsedImplicitly]
        public string Instrument
        {
            get { return (string)base["Instrument"]; }
            set { base["Instrument"] = value; }
        }

        [UsedImplicitly]
        public string ServerId
        {
            get { return (string)base["ServerId"]; }
            set { base["ServerId"] = value; }
        }

        [UsedImplicitly]
        public TradingServer Server
        {
            get { return (TradingServer)base["Server"]; }
            set { base["Server"] = value; }
        }

        [UsedImplicitly]
        public DateTime TimeStamp
        {
            get { return (DateTime)base["TimeStamp"]; }
            set { base["TimeStamp"] = value; }
        }

        [UsedImplicitly]
        public List<Deal> QdfDeals
        {
            get { return (List<Deal>)base["QdfDeals"]; }
            set { base["QdfDeals"] = value; }
        }

        [UsedImplicitly]
        public int QdfDealCount
        {
            get { return (int)base["QdfDealCount"]; }
            set { base["QdfDealCount"] = value; }
        }

        [UsedImplicitly]
        public decimal Position
        {
            get { return (decimal)base["Position"]; }
            set { base["Position"] = value; }
        }

        [UsedImplicitly]
        public decimal CumulativePosition
        {
            get { return (decimal)base["CumulativePosition"]; }
            set { base["CumulativePosition"] = value; }
        }

        [UsedImplicitly]
        public decimal PositionDelta
        {
            get { return (decimal)base["PositionDelta"]; }
            set { base["PositionDelta"] = value; }
        }
    }
}
