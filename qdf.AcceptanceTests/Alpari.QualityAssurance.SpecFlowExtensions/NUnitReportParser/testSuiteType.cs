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
    public class TestsuiteType
    {
        /// <remarks />
        [XmlElement("failure", typeof (FailureType))]
        public object Item { get; set; }


        /// <remarks />
        [XmlAttribute]
        public string Type { get; set; }

        /// <remarks />
        [XmlAttribute]
        public string Name { get; set; }

        /// <remarks />
        [XmlAttribute]
        public string Description { get; set; }

        /// <remarks />
        [XmlAttribute]
        public string Success { get; set; }

        /// <remarks />
        [XmlAttribute]
        public string Time { get; set; }

        /// <remarks />
        [XmlAttribute]
        public string Executed { get; set; }

        /// <remarks />
        [XmlAttribute]
        public string Asserts { get; set; }

        /// <remarks />
        [XmlAttribute]
        public string Result { get; set; }

        /// <remarks />
        public ResultsType Results { get; set; }

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