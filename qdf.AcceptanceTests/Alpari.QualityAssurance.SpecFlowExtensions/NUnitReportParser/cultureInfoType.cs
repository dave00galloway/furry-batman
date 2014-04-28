using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Xml.Serialization;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser
{
    /// <remarks />
    [GeneratedCode("xsd", "4.0.30319.17929")]
    [Serializable]
    [System.Diagnostics.DebuggerStepThroughAttribute]
    [DesignerCategory("code")]
    [XmlType(TypeName = "culture-infoType")]
    public class CultureinfoType
    {
        /// <remarks />
        [XmlAttribute("current-culture")]
        public string Currentculture { get; set; }

        /// <remarks />
        [XmlAttribute("current-uiculture")]
        public string Currentuiculture { get; set; }
    }
}