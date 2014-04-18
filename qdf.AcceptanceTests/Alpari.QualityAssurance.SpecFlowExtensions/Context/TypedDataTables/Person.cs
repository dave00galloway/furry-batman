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

    public class PersonData : DataTable
    {
        #region Constructor and StronglyTypedDataTable required methods
        public PersonData()
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
        public static PersonData ConvertIEnumerableToDataTable(IEnumerable<Person> persons)
        {
            PersonData personData = new PersonData();
            foreach (Person person in persons)
	        {
                personData.Rows.Add(new Object[] {person.ID,person.Forenames,person.Lastname,person.Age,person.Occupation });
	        }
            personData.AcceptChanges();
            return personData;
        }
    }

    public class PersonDataRow : DataRow
    {
        private DataRowBuilder builder;

        public PersonDataRow(DataRowBuilder builder):base(builder)
        {
            this.builder = builder;
        }

        //public ulong ID
        //{
        //    get { return (ulong)base["ID"]; }
        //    set { base["SymbolCIDode"] = value; }
        //}

        //public string Forenames
        //{
        //    get { return (string)base["Forenames"]; }
        //    set { base["Forenames"] = value; }
        //}

        //public string Lastname
        //{
        //    get { return (string)base["Lastname"]; }
        //    set { base["Lastname"] = value; }
        //}

        //public UInt16 Age
        //{
        //    get { return (UInt16)base["Age"]; }
        //    set { base["Age"] = value; }
        //}        

        //public string Occupation
        //{
        //    get { return (string)base["Occupation"]; }
        //    set { base["Occupation"] = value; }
        //}
    }

}
