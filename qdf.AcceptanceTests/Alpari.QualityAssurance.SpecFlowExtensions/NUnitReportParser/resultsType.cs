using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Xml.Serialization;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser
{
    /// <remarks />
    [GeneratedCode("xsd", "4.0.30319.17929")]
    [Serializable]
    //[System.Diagnostics.DebuggerStepThroughAttribute()]
    [DesignerCategory("code")]
    public class resultsType
    {
        private object[] itemsField;

        /// <remarks />
        [XmlElement("test-case", typeof (testcaseType))]
        [XmlElement("test-suite", typeof (testsuiteType))]
        public object[] Items
        {
            get { return itemsField; }
            set { itemsField = value; }
        }
    }
}