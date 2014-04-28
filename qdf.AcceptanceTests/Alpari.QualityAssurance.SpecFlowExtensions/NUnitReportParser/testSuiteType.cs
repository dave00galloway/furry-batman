using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser
{
    /// <remarks />
    [GeneratedCode("xsd", "4.0.30319.17929")]
    [Serializable]
    [DebuggerStepThrough]
    [DesignerCategory("code")]
    [XmlType(TypeName = "test-suiteType")]
    public class testsuiteType
    {
        private string assertsField;
        private string descriptionField;
        private string executedField;
        private object itemField;
        private string nameField;
        private string resultField;
        private resultsType resultsField;
        private string successField;
        private string timeField;
        private string typeField;

        /// <remarks />
        [XmlElement("failure", typeof (FailureType))]
        //[System.Xml.Serialization.XmlElementAttribute("reason", typeof(reasonType))]
        public object Item
        {
            get { return itemField; }
            set { itemField = value; }
        }


        /// <remarks />
        [XmlAttribute]
        public string type
        {
            get { return typeField; }
            set { typeField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string name
        {
            get { return nameField; }
            set { nameField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string description
        {
            get { return descriptionField; }
            set { descriptionField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string success
        {
            get { return successField; }
            set { successField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string time
        {
            get { return timeField; }
            set { timeField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string executed
        {
            get { return executedField; }
            set { executedField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string asserts
        {
            get { return assertsField; }
            set { assertsField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string result
        {
            get { return resultField; }
            set { resultField = value; }
        }

        /// <remarks />
        public resultsType results
        {
            get { return resultsField; }
            set { resultsField = value; }
        }

        #region ignored code

        //private categoryType[] categoriesField;

        //private propertyType[] propertiesField;


        ///// <remarks/>
        //[System.Xml.Serialization.XmlArrayItemAttribute("category", IsNullable = false)]
        //public categoryType[] categories
        //{
        //    get
        //    {
        //        return this.categoriesField;
        //    }
        //    set
        //    {
        //        this.categoriesField = value;
        //    }
        //}

        ///// <remarks/>
        //[System.Xml.Serialization.XmlArrayItemAttribute("property", IsNullable = false)]
        //public propertyType[] properties
        //{
        //    get
        //    {
        //        return this.propertiesField;
        //    }
        //    set
        //    {
        //        this.propertiesField = value;
        //    }
        //}

        #endregion
    }
}