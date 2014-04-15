using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser
{
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.17929")]
    [System.SerializableAttribute()]
    //[System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public class environmentType
    {
        private string nunitversionField;
        private string clrversionField;
        private string osversionField;
        private string platformField;
        private string cwdField;
        private string machinenameField;
        private string userField;
        private string userdomainField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute("nunit-version")]
        public string nunitversion
        {
            get
            {
                return this.nunitversionField;
            }
            set
            {
                this.nunitversionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute("clr-version")]
        public string clrversion
        {
            get
            {
                return this.clrversionField;
            }
            set
            {
                this.clrversionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute("os-version")]
        public string osversion
        {
            get
            {
                return this.osversionField;
            }
            set
            {
                this.osversionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string platform
        {
            get
            {
                return this.platformField;
            }
            set
            {
                this.platformField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string cwd
        {
            get
            {
                return this.cwdField;
            }
            set
            {
                this.cwdField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute("machine-name")]
        public string machinename
        {
            get
            {
                return this.machinenameField;
            }
            set
            {
                this.machinenameField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string user
        {
            get
            {
                return this.userField;
            }
            set
            {
                this.userField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute("user-domain")]
        public string userdomain
        {
            get
            {
                return this.userdomainField;
            }
            set
            {
                this.userdomainField = value;
            }
        }
    }
}
