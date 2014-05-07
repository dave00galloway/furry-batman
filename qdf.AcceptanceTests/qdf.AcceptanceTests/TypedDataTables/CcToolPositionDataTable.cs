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
    public class CcToolPosition : IAnalyzeablePosition
    {
        public string PositionName { get; set; }

        public Book Book { get; set; }

        public string Instrument { get; set; }

        public string ServerId { get; set; }

        public DateTime TimeStamp { get; set; }

        /// <summary>
        ///     CcPositionCount is used when positions to csv so the count of the deals for the position can be obtained
        /// </summary>
        [UsedImplicitly]
        public int CcPositionCount
        {
            get { return Positions.Count(); }
        }

        public List<DataRow> Positions { get; set; }

        public decimal Position { get; private set; }

        public decimal PositionDelta { get; set; }

        public void CalculatePosition()
        {
            Positions.ForEach(delegate(DataRow position) { Position += (decimal) position["VolumeSize"]; });
        }
    }

    [DesignerCategory("")]
    public class CcToolPositionDataTable : TypedDataTable
    {
        public CcToolPositionDataTable()
        {
// ReSharper disable once DoNotCallOverridableMethodsInConstructor
            SetupColumns();
        }

        protected override void SetupColumns()
        {
            Columns.Add(new DataColumn("PositionName", typeof (string)));
            Columns.Add(new DataColumn("Book", typeof (Book)));
            Columns.Add(new DataColumn("Instrument", typeof (string)));
            Columns.Add(new DataColumn("ServerId", typeof (string)));
            Columns.Add(new DataColumn("TimeStamp", typeof (DateTime)));
            Columns.Add(new DataColumn("CcPositionCount", typeof (int)));
            Columns.Add(new DataColumn("Positions", typeof (List<DataRow>)));
            Columns.Add(new DataColumn("Position", typeof (decimal)));
            Columns.Add(new DataColumn("PositionDelta", typeof (decimal)));
        }

        [UsedImplicitly]
        public CcToolPositionRow this[int idx]
        {
            get { return (CcToolPositionRow) Rows[idx]; }
        }

        [UsedImplicitly]
        public void Add(CcToolPositionRow row)
        {
            Rows.Add(row);
        }

        [UsedImplicitly]
        public void Remove(CcToolPositionRow row)
        {
            Rows.Remove(row);
        }

        [UsedImplicitly]
        public CcToolPositionRow GetNewRow()
        {
            var row = (CcToolPositionRow) NewRow();

            return row;
        }

        protected override Type GetRowType()
        {
            return typeof (CcToolPositionRow);
        }

        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        {
            return new CcToolPositionRow(builder);
        }

        public CcToolPositionDataTable ConvertIEnumerableToDataTable(IEnumerable<CcToolPosition> enumeratedObjects)
        {
            return SetupDataTable(enumeratedObjects, this);
        }

        public CcToolPositionDataTable ConvertIEnumerableToDataTable(IEnumerable<CcToolPosition> enumeratedObjects,
            string tableName,
            string[] primaryKeys)
        {
            TableName = tableName;
            SetPrimaryKey(primaryKeys);
            return SetupDataTable(enumeratedObjects, this);
        }

        private static CcToolPositionDataTable SetupDataTable(IEnumerable<CcToolPosition> enumeratedObjects,
            CcToolPositionDataTable ccToolPositionDataTable)
        {
            foreach (CcToolPosition ccToolPosition in enumeratedObjects)
            {
                ccToolPositionDataTable.Rows.Add(new object[]
                {
                    ccToolPosition.PositionName, ccToolPosition.Book, ccToolPosition.Instrument, ccToolPosition.ServerId,
                    ccToolPosition.TimeStamp, ccToolPosition.CcPositionCount, ccToolPosition.Positions,
                    ccToolPosition.Position,ccToolPosition.PositionDelta
                }
                    );
            }
            ccToolPositionDataTable.AcceptChanges();
            return ccToolPositionDataTable;
        }
    }

    public class CcToolPositionRow : DataRow
    {
        protected internal CcToolPositionRow([NotNull] DataRowBuilder builder) : base(builder)
        {
        }

        [UsedImplicitly]
        public string PositionName
        {
            get { return (string) base["PositionName"]; }
            set
            {
                //if (value == "A AUDUSD Mt4Classic2 2014-05-06 08:09:00")
                //{
                //    Console.WriteLine(this.ToString());
                //}
                base["PositionName"] = value;
            }
        }

        [UsedImplicitly]
        public Book Book
        {
            get { return (Book) base["Book"]; }
            set { base["Book"] = value; }
        }

        [UsedImplicitly]
        public string Instrument
        {
            get { return (string) base["Instrument"]; }
            set { base["Instrument"] = value; }
        }

        [UsedImplicitly]
        public string ServerId
        {
            get { return (string) base["ServerId"]; }
            set { base["ServerId"] = value; }
        }

        [UsedImplicitly]
        public DateTime TimeStamp
        {
            get { return (DateTime) base["TimeStamp"]; }
            set { base["TimeStamp"] = value; }
        }

        [UsedImplicitly]
        public int CcPositionCount
        {
            get { return (int) base["CcPositionCount"]; }
            set { base["CcPositionCount"] = value; }
        }

        [UsedImplicitly]
        public List<DataRow> Positions
        {
            get { return (List<DataRow>) base["Positions"]; }
            set { base["Positions"] = value; }
        }

        [UsedImplicitly]
        public decimal PositionDelta
        {
            get { return (decimal) base["PositionDelta"]; }
            set
            {
                //if (this.PositionName == "A AUDUSD Mt4Classic2 2014-05-06 08:09:00")
                //{
                //    Console.WriteLine(this.ToString());
                //}
                base["PositionDelta"] = value;
            }
        }
    }
}
