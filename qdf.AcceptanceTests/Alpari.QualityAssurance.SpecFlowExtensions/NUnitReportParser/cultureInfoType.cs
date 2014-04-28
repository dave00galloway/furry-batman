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
    [XmlType(TypeName = "culture-infoType")]
    public class cultureinfoType
    {
        private string currentcultureField;
        private string currentuicultureField;

        /// <remarks />
        [XmlAttribute("current-culture")]
        public string currentculture
        {
            get { return currentcultureField; }
            set { currentcultureField = value; }
        }

        /// <remarks />
        [XmlAttribute("current-uiculture")]
        public string currentuiculture
        {
            get { return currentuicultureField; }
            set { currentuicultureField = value; }
        }
    }
}