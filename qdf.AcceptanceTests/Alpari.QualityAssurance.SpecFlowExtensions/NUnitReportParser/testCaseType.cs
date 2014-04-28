using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using System.Xml.Serialization;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser
{
    /// <remarks />
    [GeneratedCode("xsd", "4.0.30319.17929")]
    [Serializable]
    [DebuggerStepThrough]
    //[System.ComponentModel.DesignerCategoryAttribute("code")]
    [XmlType(TypeName = "test-caseType")]
    public class testcaseType
    {
        private string assertsField;
        private CategoryType[] categoriesField;
        private string descriptionField;
        private string executedField;
        //private propertyType[] propertiesField;
        private object itemField;
        private string nameField;
        private string resultField;
        private string successField;
        private string timeField;

        /// <remarks />
        [XmlArrayItem("category", IsNullable = false)]
        public CategoryType[] categories
        {
            get { return categoriesField; }
            set { categoriesField = value; }
        }

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
    }
}