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
        /// <remarks />
        [XmlAttribute("nunit-version")]
        public string Nunitversion { get; set; }

        /// <remarks />
        [XmlAttribute("clr-version")]
        public string Clrversion { get; set; }

        /// <remarks />
        [XmlAttribute("os-version")]
        public string Osversion { get; set; }

        /// <remarks />
        [XmlAttribute]
        public string Platform { get; set; }

        /// <remarks />
        [XmlAttribute]
        public string Cwd { get; set; }

        /// <remarks />
        [XmlAttribute("machine-name")]
        public string Machinename { get; set; }

        /// <remarks />
        [XmlAttribute]
        public string User { get; set; }

        /// <remarks />
        [XmlAttribute("user-domain")]
        public string Userdomain { get; set; }
    }
}