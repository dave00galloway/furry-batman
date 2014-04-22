using System.Data;
namespace Alpari.QualityAssurance.SpecFlowExtensions.Context.TypedDataTables
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Text;
    
    public class Person
    {
        public ulong ID {get;set;}
        public string Forenames {get;set;}
        public string Lastname {get;set;}
        public UInt16 Age {get;set;}
        public string Occupation  {get;set;}
    }

    public class PersonData : DataTable, Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities.ITypedDataTable
    {
        #region Constructor and StronglyTypedDataTable required methods
        /// <summary>
        /// set up with no primary key
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
                this.PrimaryKey = new DataColumn[] { Columns["ID"] };
            }
        }

        public PersonData(string[] primaryKeyColumns)
        {
            SetupColumns();
            SetPrimaryKey(primaryKeyColumns);
        }

        public void SetPrimaryKey(string[] primaryKeyColumns)
        {
            int size = primaryKeyColumns.Length;
            DataColumn[] keyColumns = Array.CreateInstance(typeof(DataColumn), size) as DataColumn[];
            for (int i = 0; i < size; i++)
            {
                keyColumns[i] = Columns[primaryKeyColumns[i]];
            }
            this.PrimaryKey = keyColumns;
        }


        /// <summary>
        /// TODO:- set up an abstract base class implementing ITypedDataTable with abstract or virtual methods to override
        /// </summary>
        internal void SetupColumns()
        {
            Columns.Add(new DataColumn("ID", typeof(ulong)));
            Columns.Add(new DataColumn("Forenames", typeof(string)));
            Columns.Add(new DataColumn("Lastname", typeof(string)));
            Columns.Add(new DataColumn("Age", typeof(UInt16)));
            Columns.Add(new DataColumn("Occupation", typeof(string)));
        }

        public PersonDataRow this[int idx]
        {
            get { return (PersonDataRow)Rows[idx]; }
        }

        public void Add(PersonDataRow row)
        {
            Rows.Add(row);
        }

        public void Remove(PersonDataRow row)
        {
            Rows.Remove(row);
        }

        public PersonDataRow GetNewRow()
        {
            PersonDataRow row = (PersonDataRow)NewRow();

            return row;
        }

        protected override Type GetRowType()
        {
            return typeof(PersonDataRow);
        }

        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
        {
            return new PersonDataRow(builder);
        }
        #endregion
        public PersonData ConvertIEnumerableToDataTable(IEnumerable<Person> enumeratedObjects)
        {
            //PersonData dataTable = new PersonData();
            return SetupDataTable(enumeratedObjects, this);
            //foreach (Person person in enumeratedObjects)
            //{
            //    dataTable.Rows.Add(new Object[] { person.ID, person.Forenames, person.Lastname, person.Age, person.Occupation });
            //}
            //dataTable.AcceptChanges();
            //return dataTable;
        }

        public PersonData ConvertIEnumerableToDataTable(IEnumerable<Person> enumeratedObjects,string tableName, string[] primaryKeys)
        {
            //PersonData dataTable = new PersonData();
            this.TableName = tableName;
            this.SetPrimaryKey(primaryKeys);
            return SetupDataTable(enumeratedObjects, this);
        }

        private static PersonData SetupDataTable(IEnumerable<Person> enumeratedObjects, PersonData dataTable)
        {
            foreach (Person person in enumeratedObjects)
            {
                dataTable.Rows.Add(new Object[] { person.ID, person.Forenames, person.Lastname, person.Age, person.Occupation });
            }
            dataTable.AcceptChanges();
            return dataTable;
        }

        /// <summary>
        /// Not sure about this design - whatever T is, the return type will always be PersonData
        /// could do this for all the non protected/internal methods in this class, so that implementing the interaface gives stubs, but will it actually help?
        /// Time might be better spent creating a code generator, or getting DBMetal to work properly!
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="enumeratedObjects"></param>
        /// <returns></returns>
        public T ConvertIEnumerableToDataTable<T>(IEnumerable<T> enumeratedObjects) where T : System.Data.DataTable, new()
        {
            return this.ConvertIEnumerableToDataTable(enumeratedObjects);
        }

        public T ConvertIEnumerableToDataTable<T>(IEnumerable<T> enumeratedObjects, string tableName, string[] primaryKeys) where T : DataTable, new()
        {
            return this.ConvertIEnumerableToDataTable(enumeratedObjects,tableName, primaryKeys);
        }
    }

    public class PersonDataRow : DataRow
    {
        private DataRowBuilder builder;

        public PersonDataRow(DataRowBuilder builder):base(builder)
        {
            this.builder = builder;
        }

        public ulong ID
        {
            get { return (ulong)base["ID"]; }
            set { base["SymbolCIDode"] = value; }
        }

        public string Forenames
        {
            get { return (string)base["Forenames"]; }
            set { base["Forenames"] = value; }
        }

        public string Lastname
        {
            get { return (string)base["Lastname"]; }
            set { base["Lastname"] = value; }
        }

        public UInt16 Age
        {
            get { return (UInt16)base["Age"]; }
            set { base["Age"] = value; }
        }

        public string Occupation
        {
            get { return (string)base["Occupation"]; }
            set { base["Occupation"] = value; }
        }
    }

}
