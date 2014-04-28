using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Xml.Serialization;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser
{
    /// <remarks />
    [GeneratedCode("xsd", "4.0.30319.17929")]
    [Serializable]
    [DesignerCategory("code")]
    public class FailureType
    {
        /// <remarks />
        public string Message { get; set; }

        /// <remarks />
        [XmlElement("stack-trace")]
        public string Stacktrace { get; set; }
    }
}