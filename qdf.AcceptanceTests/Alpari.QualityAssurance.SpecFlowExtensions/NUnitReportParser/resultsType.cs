using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Xml.Serialization;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser
{
    /// <remarks />
    [GeneratedCode("xsd", "4.0.30319.17929")]
    [Serializable]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [DesignerCategory("code")]
    public class ResultsType
    {
        /// <remarks />
        [XmlElement("test-case", typeof (TestcaseType)), XmlElement("test-suite", typeof (TestsuiteType))]
        public object[] Items { get; set; }
    }
}