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
    public class environmentType
    {
        private string clrversionField;
        private string cwdField;
        private string machinenameField;
        private string nunitversionField;
        private string osversionField;
        private string platformField;
        private string userField;
        private string userdomainField;

        /// <remarks />
        [XmlAttribute("nunit-version")]
        public string nunitversion
        {
            get { return nunitversionField; }
            set { nunitversionField = value; }
        }

        /// <remarks />
        [XmlAttribute("clr-version")]
        public string clrversion
        {
            get { return clrversionField; }
            set { clrversionField = value; }
        }

        /// <remarks />
        [XmlAttribute("os-version")]
        public string osversion
        {
            get { return osversionField; }
            set { osversionField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string platform
        {
            get { return platformField; }
            set { platformField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string cwd
        {
            get { return cwdField; }
            set { cwdField = value; }
        }

        /// <remarks />
        [XmlAttribute("machine-name")]
        public string machinename
        {
            get { return machinenameField; }
            set { machinenameField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string user
        {
            get { return userField; }
            set { userField = value; }
        }

        /// <remarks />
        [XmlAttribute("user-domain")]
        public string userdomain
        {
            get { return userdomainField; }
            set { userdomainField = value; }
        }
    }
}