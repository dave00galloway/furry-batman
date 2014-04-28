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
        private string _messageField;

        private string _stacktraceField;

        /// <remarks />
        public string Message
        {
            get { return _messageField; }
            set { _messageField = value; }
        }

        /// <remarks />
        [XmlElement("stack-trace")]
        public string Stacktrace
        {
            get { return _stacktraceField; }
            set { _stacktraceField = value; }
        }
    }
}