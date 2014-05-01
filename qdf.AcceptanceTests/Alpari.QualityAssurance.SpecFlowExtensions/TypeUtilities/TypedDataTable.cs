using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    [System.ComponentModel.DesignerCategory("")]
    [Serializable]
    public abstract class TypedDataTable : DataTable,ITypedDataTable
    {
        /// <summary>
        ///     Implemented to staisfy
        ///     CA2237: Mark ISerializable types with SerializableAttribute
        ///     and CA2229: Implement serialization constructors
        ///     If this overload is ever used, then an instance will be created with serialisation context
        /// </summary>
        /// <param name="info"></param>
        /// <param name="context"></param>
        protected TypedDataTable(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {

        }

        protected TypedDataTable()
        {
            //SetupColumns();
        }

        protected TypedDataTable(string[] primaryKeyColumns)
        {
            //SetupColumns();
            //SetPrimaryKey(primaryKeyColumns);
        }

        protected abstract void SetupColumns();

//       #region Constructor and StronglyTypedDataTable required methods

//        /// <summary>
//        ///     set up with no primary key
//        /// </summary>
//        public PersonData()
//        {
//            SetupColumns();
//        }

//        public PersonData(bool defaultPrimaryKey)
//        {
//            SetupColumns();
//            if (defaultPrimaryKey)
//            {
//                PrimaryKey = new[] {Columns["ID"]};
//            }
//        }

//        public PersonData(string[] primaryKeyColumns)
//        {
//            SetupColumns();
//            SetPrimaryKey(primaryKeyColumns);
//        }

//        public PersonDataRow this[int idx]
//        {
//            get { return (PersonDataRow) Rows[idx]; }
//        }
//        private void SetupColumns()
//        {
//            Columns.Add(new DataColumn("ID", typeof (ulong)));
//            Columns.Add(new DataColumn("Forenames", typeof (string)));
//            Columns.Add(new DataColumn("Lastname", typeof (string)));
//            Columns.Add(new DataColumn("Age", typeof (UInt16)));
//            Columns.Add(new DataColumn("Occupation", typeof (string)));
//        }

//        public void Add(PersonDataRow row)
//        {
//            Rows.Add(row);
//        }

//        public void Remove(PersonDataRow row)
//        {
//            Rows.Remove(row);
//        }

//// ReSharper disable once UnusedMember.Global - required overload
//        public PersonDataRow GetNewRow()
//        {
//            var row = (PersonDataRow) NewRow();

//            return row;
//        }

//        protected override Type GetRowType()
//        {
//            return typeof (PersonDataRow);
//        }

//        protected override DataRow NewRowFromBuilder(DataRowBuilder builder)
//        {
//            return new PersonDataRow(builder);
//        }

//        #endregion

        public abstract T ConvertIEnumerableToDataTable<T>(IEnumerable<T> enumeratedObjects)
            where T : System.Data.DataTable, new();

        public abstract T ConvertIEnumerableToDataTable<T>(IEnumerable<T> enumeratedObjects, string tableName,
            string[] primaryKeys) where T : System.Data.DataTable, new();

        // ReSharper disable once MemberCanBePrivate.Global - used externally
        public void SetPrimaryKey(string[] primaryKeyColumns)
        {
            int size = primaryKeyColumns.Length;
            var keyColumns = new DataColumn[size];
            for (int i = 0; i < size; i++)
            {
                keyColumns[i] = Columns[primaryKeyColumns[i]];
            }
            PrimaryKey = keyColumns;
        }

    }
}
