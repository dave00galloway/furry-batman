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
    public class CultureinfoType
    {
        private string _currentcultureField;
        private string _currentuicultureField;

        /// <remarks />
        [XmlAttribute("current-culture")]
        public string Currentculture
        {
            get { return _currentcultureField; }
            set { _currentcultureField = value; }
        }

        /// <remarks />
        [XmlAttribute("current-uiculture")]
        public string Currentuiculture
        {
            get { return _currentuicultureField; }
            set { _currentuicultureField = value; }
        }
    }
}