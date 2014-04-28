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
    public class categoryType
    {
        private string nameField;

        /// <remarks />
        [XmlAttribute]
        public string name
        {
            get { return nameField; }
            set { nameField = value; }
        }
    }
}