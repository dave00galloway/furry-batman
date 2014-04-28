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
    public class CategoryType
    {
        private string _nameField;

        /// <remarks />
        [XmlAttribute]
        public string Name
        {
            get { return _nameField; }
            set { _nameField = value; }
        }
    }
}