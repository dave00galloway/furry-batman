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
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [XmlType(TypeName = "test-caseType")]
    public class TestcaseType
    {

        /// <remarks />
        [XmlArrayItem("category", IsNullable = false)]
        public CategoryType[] Categories { get; set; }

        /// <remarks />
        [XmlElement("failure", typeof (FailureType))]
        public object Item { get; set; }

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
    }
}