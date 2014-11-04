using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using Alpari.CC.WebPortal.DAL.Repositories.Redis;
using Alpari.QualityAssurance.SpecFlowExtensions.Annotations;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QA.QDF.Test.Domain.TypedDataTables.CapitalCalculation
{
    public class ClientPositionDataTable : TypedDataTable
    {
        public ClientPositionDataTable()
        {
// ReSharper disable DoNotCallOverridableMethodsInConstructor
            SetupColumns();
        }

        public ClientPositionDataTable(string tableName, string[] primaryKeys)
        {
            SetupColumns();
            TableName = tableName;
            SetPrimaryKey(primaryKeys);
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        [UsedImplicitly]
        public ClientPositionDataRow this[int idx]
        {
            get { return (ClientPositionDataRow) Rows[idx]; }
        }

        [UsedImplicitly]
        public void Add(ClientPositionDataRow row)
        {
            Rows.Add(row);
        }

        [UsedImplicitly]
        public void Remove(ClientPositionDataRow row)
        {
            Rows.Remove(row);
        }

        [UsedImplicitly]
        public ClientPositionDataRow GetNewRow()
        {
            var row = (ClientPositionDataRow) NewRow();
            return row;
        }

        //public ClientPositionDataTable ConvertIEnumerableToDataTable(IEnumerable<Position> enumeratedObjects)
        //{
        //    SetupDataTable(enumeratedObjects);
        //    return this;
        //}

        public ClientPositionDataTable ConvertIEnumerableToDataTable(IEnumerable<Position> enumeratedObjects,
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
            foreach (Position position in enumeratedObjects)
            {
                Rows.Add(new object[]
                {
                    position.Server, //ignore
                    0, //ignore
                    position.Login,
                    position.Order.ToString(CultureInfo.InvariantCulture),
                    position.Symbol,
                    0, //section is unknown to redis
                    position.Group,
                    position.Book != "UNKNOWN" ? position.Book == "A" ? "CLIENTA" : "CLIENTB" : position.Book,
                    //counterparty
                    //position.Cmd, 
                    position.Cmd == 0 ? position.Volume : position.Volume*-1 //BaseVolume
                });
                AcceptChanges();
            }
        }

        protected override Type GetRowType()
        {
            return typeof (ClientPositionDataRow);
        }

        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        {
            return new ClientPositionDataRow(builder);
        }

        protected override void SetupColumns()
        {
            Columns.Add(new DataColumn("ServerName", typeof (string)));
            Columns.Add(new DataColumn("ServerId", typeof (int)));
            Columns.Add(new DataColumn("Login", typeof (int)));
            Columns.Add(new DataColumn("Ticket", typeof (string)));
            Columns.Add(new DataColumn("Symbol", typeof (string)));
            Columns.Add(new DataColumn("SectionId", typeof (int)));
            Columns.Add(new DataColumn("Group", typeof (string)));
            Columns.Add(new DataColumn("Counterparty", typeof (string)));
            Columns.Add(new DataColumn("BaseVolume", typeof (decimal)));
        }
    }

    public class ClientPositionDataRow : DataRow
    {
        internal ClientPositionDataRow(DataRowBuilder builder)
            : base(builder)
        {
        }

        [UsedImplicitly]
        public string ServerName
        {
            get { return (string) base["ServerName"]; }
            set { base["ServerName"] = value; }
        }

        [UsedImplicitly]
        public int ServerId
        {
            get { return (int) base["ServerId"]; }
            set { base["ServerId"] = value; }
        }

        [UsedImplicitly]
        public int Login
        {
            get { return (int) base["Login"]; }
            set { base["Login"] = value; }
        }

        [UsedImplicitly]
        public string Ticket
        {
            get { return (string) base["Ticket"]; }
            set { base["Ticket"] = value; }
        }

        [UsedImplicitly]
        public string Symbol
        {
            get { return (string) base["Symbol"]; }
            set { base["Symbol"] = value; }
        }

        [UsedImplicitly]
        public int SectionId
        {
            get { return (int) base["SectionId"]; }
            set { base["SectionId"] = value; }
        }

        [UsedImplicitly]
        public string Group
        {
            get { return (string) base["Group"]; }
            set { base["Group"] = value; }
        }

        [UsedImplicitly]
        public string Counterparty
        {
            get { return (string) base["Counterparty"]; }
            set { base["Counterparty"] = value; }
        }

        [UsedImplicitly]
        public decimal BaseVolume
        {
            get { return (decimal) base["BaseVolume"]; }
            set { base["BaseVolume"] = value; }
        }
    }
}