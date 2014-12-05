using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;
using Alpari.QualityAssurance.SpecFlowExtensions.Annotations;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Context.TypedDataTables
{
    public class Person
    {
        public ulong Id { get; [UsedImplicitly] set; }
        public string Forenames { get; [UsedImplicitly] set; }
        public string Lastname { get; [UsedImplicitly] set; }
        public UInt16 Age { get; [UsedImplicitly] set; }
        public string Occupation { get; [UsedImplicitly] set; }
    }

    [System.ComponentModel.DesignerCategory("")]
    public class PersonData : TypedDataTable
    {
        #region Constructor and StronglyTypedDataTable required methods

        /// <summary>
        ///     set up with no primary key
        /// </summary>
        public PersonData()
        {
            SetupColumns();
        }

        public PersonData(bool defaultPrimaryKey)
        {
            SetupColumns();
            if (defaultPrimaryKey)
            {
                PrimaryKey = new[] {Columns["ID"]};
            }
        }

        public PersonData(string[] primaryKeyColumns)
        {
            SetupColumns();
            this.SetPrimaryKey(primaryKeyColumns);
        }

        public PersonDataRow this[int idx]
        {
            get { return (PersonDataRow) Rows[idx]; }
        }

        protected sealed override void SetupColumns()
        {
            Columns.Add(new DataColumn("ID", typeof (ulong)));
            Columns.Add(new DataColumn("Forenames", typeof (string)));
            Columns.Add(new DataColumn("Lastname", typeof (string)));
            Columns.Add(new DataColumn("Age", typeof (UInt16)));
            Columns.Add(new DataColumn("Occupation", typeof (string)));
        }

        public void Add(PersonDataRow row)
        {
            Rows.Add(row);
        }

        public void Remove(PersonDataRow row)
        {
            Rows.Remove(row);
        }

// ReSharper disable once UnusedMember.Global - required overload
        public PersonDataRow GetNewRow()
        {
            var row = (PersonDataRow) NewRow();

            return row;
        }

        protected override Type GetRowType()
        {
            return typeof (PersonDataRow);
        }

        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        {
            return new PersonDataRow(builder);
        }

        #endregion

        /// <summary>
        ///     Implemented to staisfy
        ///     CA2237: Mark ISerializable types with SerializableAttribute
        ///     and CA2229: Implement serialization constructors
        ///     If this overload is ever used, then an instance will be created with serialisation context
        /// </summary>
        /// <param name="info"></param>
        /// <param name="context"></param>
        protected PersonData(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
        }

        public PersonData ConvertIEnumerableToDataTable(IEnumerable<Person> enumeratedObjects)
        {
            return SetupDataTable(enumeratedObjects, this);
        }

        public PersonData ConvertIEnumerableToDataTable(IEnumerable<Person> enumeratedObjects, string tableName,
            string[] primaryKeys)
        {
            TableName = tableName;
            this.SetPrimaryKey(primaryKeys);
            return SetupDataTable(enumeratedObjects, this);
        }

        private static PersonData SetupDataTable(IEnumerable<Person> enumeratedObjects, PersonData dataTable)
        {
            foreach (Person person in enumeratedObjects)
            {
                dataTable.Rows.Add(new Object[]
                {person.Id, person.Forenames, person.Lastname, person.Age, person.Occupation});
            }
            dataTable.AcceptChanges();
            return dataTable;
        }
    }

    public class PersonDataRow : DataRow
    {
        public PersonDataRow(DataRowBuilder builder) : base(builder)
        {
        }

        public ulong Id
        {
            get { return (ulong) base["ID"]; }
            set { base["SymbolCIDode"] = value; }
        }

        public string Forenames
        {
            get { return (string) base["Forenames"]; }
            set { base["Forenames"] = value; }
        }

        public string Lastname
        {
            get { return (string) base["Lastname"]; }
            set { base["Lastname"] = value; }
        }

        public UInt16 Age
        {
            get { return (UInt16) base["Age"]; }
            set { base["Age"] = value; }
        }

        public string Occupation
        {
            get { return (string) base["Occupation"]; }
            set { base["Occupation"] = value; }
        }
    }
}