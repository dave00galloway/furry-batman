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
    public class EnvironmentType
    {
        private string _clrversionField;
        private string _cwdField;
        private string _machinenameField;
        private string _nunitversionField;
        private string _osversionField;
        private string _platformField;
        private string _userField;
        private string _userdomainField;

        /// <remarks />
        [XmlAttribute("nunit-version")]
        public string Nunitversion
        {
            get { return _nunitversionField; }
            set { _nunitversionField = value; }
        }

        /// <remarks />
        [XmlAttribute("clr-version")]
        public string Clrversion
        {
            get { return _clrversionField; }
            set { _clrversionField = value; }
        }

        /// <remarks />
        [XmlAttribute("os-version")]
        public string Osversion
        {
            get { return _osversionField; }
            set { _osversionField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string Platform
        {
            get { return _platformField; }
            set { _platformField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string Cwd
        {
            get { return _cwdField; }
            set { _cwdField = value; }
        }

        /// <remarks />
        [XmlAttribute("machine-name")]
        public string Machinename
        {
            get { return _machinenameField; }
            set { _machinenameField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string User
        {
            get { return _userField; }
            set { _userField = value; }
        }

        /// <remarks />
        [XmlAttribute("user-domain")]
        public string Userdomain
        {
            get { return _userdomainField; }
            set { _userdomainField = value; }
        }
    }
}