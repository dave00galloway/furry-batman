using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using System;
using System.Data;
using System.Runtime.Serialization;

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

        //public abstract T ConvertIEnumerableToDataTable<T>(IEnumerable<T> enumeratedObjects)
        //    where T : System.Data.DataTable, new();

        //public abstract T ConvertIEnumerableToDataTable<T>(IEnumerable<T> enumeratedObjects, string tableName,
        //    string[] primaryKeys) where T : System.Data.DataTable, new();

        // ReSharper disable once MemberCanBePrivate.Global - used externally


        /// <summary>
        /// TODO:- replace/create overload which uses delegates instead of a switch
        /// </summary>
        /// <param name="exportType"></param>
        /// <param name="parameters"></param>
        public void ExportData(ExportTypes exportType, string[] parameters)
        {
            switch (exportType)
            {
                case ExportTypes.Csv:
                    this.DataTableToCsv(parameters[(int) ExportParams.FileNamePath],true);
                    break;
                case ExportTypes.Database:
                    throw new ArgumentException("Export type not implemented yet",
                        Enum.GetName(typeof (ExportTypes), exportType));
                default:
                    throw new ArgumentException("Export type not valid", Enum.GetName(typeof (ExportTypes), exportType));
            }
        }
    }
}
