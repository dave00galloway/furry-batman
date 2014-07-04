using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QualityAssurance.Cnx2Redis.Tests.Annotations;
using Alpari.QualityAssurance.Cnx2Redis.Tests.DataContexts;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.TypedDataTables
{
    public class TradeWithEventIdDataTable : TypedDataTable
    {
        public TradeWithEventIdDataTable()
        {
// ReSharper disable once DoNotCallOverridableMethodsInConstructor
            SetupColumns();
        }

        [UsedImplicitly]
        public TradeWithEventIdDataTableRow this[int idx]
        {
            get { return (TradeWithEventIdDataTableRow)Rows[idx]; }
        }

        [UsedImplicitly]
        public void Add(TradeWithEventIdDataTableRow row)
        {
            Rows.Add(row);
        }

        [UsedImplicitly]
        public void Remove(TradeWithEventIdDataTableRow row)
        {
            Rows.Remove(row);
        }

        [UsedImplicitly]
        public TradeWithEventIdDataTableRow GetNewRow()
        {
            var row = (TradeWithEventIdDataTableRow)NewRow();

            return row;
        }

        protected override Type GetRowType()
        {
            return typeof(TradeWithEventIdDataTableRow);
        }

        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        {
            return new TradeWithEventIdDataTableRow(builder);
        }

        [UsedImplicitly]
        public TradeWithEventIdDataTable ConvertIEnumerableToDataTable(IEnumerable<GetTradeswithEventIDResult> enumeratedObjects)
        {
            return SetupDataTable(enumeratedObjects, this);
        }

        [UsedImplicitly]
        public TradeWithEventIdDataTable ConvertIEnumerableToDataTable(IEnumerable<GetTradeswithEventIDResult> enumeratedObjects,
            string tableName,
            string[] primaryKeys)
        {
            TableName = tableName;
            SetPrimaryKey(primaryKeys);
            return SetupDataTable(enumeratedObjects, this);
        }

        private static TradeWithEventIdDataTable SetupDataTable(IEnumerable<GetTradeswithEventIDResult> enumeratedObjects,
            TradeWithEventIdDataTable tradeWithEventIdDataTable)
        {
            foreach (var orderEvent in enumeratedObjects)
            {
                tradeWithEventIdDataTable.Rows.Add(new object[]
                {
                    orderEvent.OrderEventID
                    ,
                    orderEvent.OriginTimeStamp,
                    orderEvent.FillVolume, 
                    orderEvent.Price, 
                    orderEvent.Comment, 
                    orderEvent.ExecID, 
                    orderEvent.Side, 
                    orderEvent.OrderTimeTypeID, 
                    orderEvent.OrderPriceTypeID, 
                    orderEvent.TEMnemonic.Replace("/","")
                }
                    );
            }
            tradeWithEventIdDataTable.AcceptChanges();
            return tradeWithEventIdDataTable;
        }

        protected override void SetupColumns()
        {
            Columns.Add(new DataColumn("OrderEventID", typeof(int)));
            Columns.Add(new DataColumn("OriginTimeStamp", typeof(DateTime?)));
            Columns.Add(new DataColumn("FillVolume", typeof(int)));
            Columns.Add(new DataColumn("Price", typeof(double)));
            Columns.Add(new DataColumn("Comment", typeof(string)));
            Columns.Add(new DataColumn("ExecID", typeof(string)));
            Columns.Add(new DataColumn("Side", typeof(int)));
            Columns.Add(new DataColumn("OrderTimeTypeID", typeof(char)));
            Columns.Add(new DataColumn("OrderPriceTypeID", typeof(char)));
            Columns.Add(new DataColumn("TEMnemonic", typeof(string)));
        }
    }

    public class TradeWithEventIdDataTableRow : DataRow
    {
        internal TradeWithEventIdDataTableRow( DataRowBuilder builder) : base(builder)
        {
        }

        [UsedImplicitly]
        public int OrderEventId
        {
            get { return (int) base["OrderEventId"]; }
            set { base["OrderEventId"] = value; }
        }

        [UsedImplicitly]
        public DateTime OriginTimeStamp
        {
            get { return (DateTime)base["OriginTimeStamp"]; }
            set { base["OriginTimeStamp"] = value; }
        }

        [UsedImplicitly]
        public int FillVolume
        {
            get { return (int)base["FillVolume"]; }
            set { base["FillVolume"] = value; }
        }

        [UsedImplicitly]
        public double Price
        {
            get { return (double)base["Price"]; }
            set { base["Price"] = value; }
        }

        [UsedImplicitly]
        public string Comment
        {
            get { return (string)base["Comment"]; }
            set { base["Comment"] = value; }
        }

        [UsedImplicitly]
        public string ExecId
        {
            get { return (string)base["ExecID"]; }
            set { base["ExecID"] = value; }
        }

        [UsedImplicitly]
        public int Side
        {
            get { return (int)base["Side"]; }
            set { base["Side"] = value; }
        }

        [UsedImplicitly]
        public char OrderTimeTypeId
        {
            get { return (char)base["OrderTimeTypeID"]; }
            set { base["OrderTimeTypeID"] = value; }
        }

        [UsedImplicitly]
        public char OrderPriceTypeId
        {
            get { return (char)base["OrderPriceTypeID"]; }
            set { base["OrderPriceTypeID"] = value; }
        }

        [UsedImplicitly]
        public string TeMnemonic
        {
            get { return (string)base["TEMnemonic"]; }
            set { base["TEMnemonic"] = value; }
        }
    }

        //private int _OrderEventID;
		
        //private System.Nullable<System.DateTime> _OriginTimeStamp;
		
        //private System.Nullable<int> _FillVolume;
		
        //private System.Nullable<double> _Price;
		
        //private string _Comment;
		
        //private string _ExecID;
		
        //private int _Side;
		
        //private System.Nullable<char> _OrderTimeTypeID;
		
        //private char _OrderPriceTypeID;
		
        //private string _TEMnemonic;
}
