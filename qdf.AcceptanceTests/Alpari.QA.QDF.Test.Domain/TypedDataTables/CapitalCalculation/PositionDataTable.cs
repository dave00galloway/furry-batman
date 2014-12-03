using Alpari.CC.WebPortal.DAL.Repositories.Redis;
using Alpari.QualityAssurance.SpecFlowExtensions.Annotations;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using System;
using System.Collections.Generic;
using System.Data;

namespace Alpari.QA.QDF.Test.Domain.TypedDataTables.CapitalCalculation
{
    public class PositionDataTable : TypedDataTable
    {
        public PositionDataTable()
        {
// ReSharper disable DoNotCallOverridableMethodsInConstructor
            SetupColumns();
        }

        public PositionDataTable(string tableName, string[] primaryKeys)
        {
            SetupColumns();
            TableName = tableName;
            SetPrimaryKey(primaryKeys);
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        [UsedImplicitly]
        public PositionDataRow this[int idx]
        {
            get { return (PositionDataRow) Rows[idx]; }
        }

        [UsedImplicitly]
        public void Add(PositionDataRow row)
        {
            Rows.Add(row);
        }

        [UsedImplicitly]
        public void Remove(PositionDataRow row)
        {
            Rows.Remove(row);
        }

        [UsedImplicitly]
        public PositionDataRow GetNewRow()
        {
            var row = (PositionDataRow) NewRow();
            return row;
        }

        public PositionDataTable ConvertIEnumerableToDataTable(IEnumerable<Position> enumeratedObjects)
        {
            SetupDataTable(enumeratedObjects);
            return this;
        }

        public PositionDataTable ConvertIEnumerableToDataTable(IEnumerable<Position> enumeratedObjects, 
            string tableName,
            string[] primaryKeys)
        {
            SetupDataTable(enumeratedObjects);
            TableName = tableName;
            SetPrimaryKey(primaryKeys);
            return this;
        }

        private void SetupDataTable(IEnumerable<Position> enumeratedObjects)
        {
            foreach (Position position in enumeratedObjects) //don't believe that parellelising helped .AsParallel().WithExecutionMode(ParallelExecutionMode.ForceParallelism).WithDegreeOfParallelism(32))
            {
                Rows.Add(new object[]
                {
                    position.Login, position.Order, position.Cmd, position.Volume, position.OpenPrice, position.Sl,
                    position.Tp, position.OpenTime, position.Comment, position.Timestamp, position.Group,
                    position.Status, position.Symbol, position.Server, position.Book
                });
                AcceptChanges();
            }
        }

        protected override Type GetRowType()
        {
            return typeof (PositionDataRow);
        }

        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        {
            return new PositionDataRow(builder);
        }

        protected override void SetupColumns()
        {
            Columns.Add(new DataColumn("Login", typeof (int)));
            Columns.Add(new DataColumn("Order", typeof (int)));
            Columns.Add(new DataColumn("Cmd", typeof (sbyte)));
            Columns.Add(new DataColumn("Volume", typeof (decimal)));
            Columns.Add(new DataColumn("OpenPrice", typeof (decimal)));
            Columns.Add(new DataColumn("Sl", typeof (decimal)));
            Columns.Add(new DataColumn("Tp", typeof (decimal)));
            Columns.Add(new DataColumn("OpenTime", typeof (DateTime)));
            Columns.Add(new DataColumn("Comment", typeof (string)));
            Columns.Add(new DataColumn("Timestamp", typeof (DateTime)));
            Columns.Add(new DataColumn("Group", typeof (string)));
            Columns.Add(new DataColumn("Status", typeof (string)));
            Columns.Add(new DataColumn("Symbol", typeof (string)));
            Columns.Add(new DataColumn("Server", typeof (string)));
            Columns.Add(new DataColumn("Book", typeof (string)));
        }
    }

    public class PositionDataRow : DataRow
    {
        internal PositionDataRow(DataRowBuilder builder) : base(builder)
        {
        }

        [UsedImplicitly]
        public int Login
        {
            get { return (int) base["Login"]; }
            set { base["Login"] = value; }
        }

        [UsedImplicitly]
        public int Order
        {
            get { return (int) base["Order"]; }
            set { base["Order"] = value; }
        }

        [UsedImplicitly]
        public sbyte Cmd
        {
            get { return (sbyte) base["Cmd"]; }
            set { base["Cmd"] = value; }
        }

        [UsedImplicitly]
        public decimal Volume
        {
            get { return (decimal) base["Volume"]; }
            set { base["Volume"] = value; }
        }

        [UsedImplicitly]
        public decimal OpenPrice
        {
            get { return (decimal) base["OpenPrice"]; }
            set { base["OpenPrice"] = value; }
        }

        [UsedImplicitly]
        public decimal Sl
        {
            get { return (decimal) base["Sl"]; }
            set { base["Sl"] = value; }
        }

        [UsedImplicitly]
        public decimal Tp
        {
            get { return (decimal) base["Tp"]; }
            set { base["Tp"] = value; }
        }

        [UsedImplicitly]
        public DateTime OpenTime
        {
            get { return (DateTime) base["OpenTime"]; }
            set { base["OpenTime"] = value; }
        }

        [UsedImplicitly]
        public string Comment
        {
            get { return (string) base["Comment"]; }
            set { base["Comment"] = value; }
        }

        [UsedImplicitly]
        public DateTime Timestamp
        {
            get { return (DateTime) base["Timestamp"]; }
            set { base["Timestamp"] = value; }
        }

        [UsedImplicitly]
        public string Group
        {
            get { return (string) base["Group"]; }
            set { base["Group"] = value; }
        }

        [UsedImplicitly]
        public string Status
        {
            get { return (string) base["Status"]; }
            set { base["Status"] = value; }
        }

        [UsedImplicitly]
        public string Symbol
        {
            get { return (string) base["Symbol"]; }
            set { base["Symbol"] = value; }
        }

        [UsedImplicitly]
        public string Server
        {
            get { return (string) base["Server"]; }
            set { base["Server"] = value; }
        }

        [UsedImplicitly]
        public string Book
        {
            get { return (string) base["Book"]; }
            set { base["Book"] = value; }
        }
    }
}