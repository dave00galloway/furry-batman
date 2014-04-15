using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser
{
    /// <summary>
    /// just using the xsd toget the data structure
    /// The results file is quite messy and nested, so the complex types are ignored for now
    /// updated the source xsd to the Nunit provided one rather thena the VS generated one as it's simpler, 
    /// but still doesn't auto parse the result xml!
    /// </summary>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.17929")]
    [System.SerializableAttribute()]
    //[System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
    [System.Xml.Serialization.XmlRootAttribute("test-results", Namespace = "", IsNullable = false)]
    public class resultType
    {
        private string nameField;
        private decimal totalField;
        private decimal errorsField;
        private decimal failuresField;
        private decimal inconclusiveField;
        private decimal notrunField;
        private decimal ignoredField;
        private decimal skippedField;
        private decimal invalidField;
        private string dateField;
        private string timeField;

        # region ignored fields and properties
            //private environmentType environmentField;

            //private cultureinfoType cultureinfoField;

            //private testsuiteType testsuiteField;

            ///// <remarks/>
            //public environmentType environment
            //{
            //    get
            //    {
            //        return this.environmentField;
            //    }
            //    set
            //    {
            //        this.environmentField = value;
            //    }
            //}

            ///// <remarks/>
            //[System.Xml.Serialization.XmlElementAttribute("culture-info")]
            //public cultureinfoType cultureinfo
            //{
            //    get
            //    {
            //        return this.cultureinfoField;
            //    }
            //    set
            //    {
            //        this.cultureinfoField = value;
            //    }
            //}

            ///// <remarks/>
            //[System.Xml.Serialization.XmlElementAttribute("test-suite")]
            //public testsuiteType testsuite
            //{
            //    get
            //    {
            //        return this.testsuiteField;
            //    }
            //    set
            //    {
            //        this.testsuiteField = value;
            //    }
            //}
        #endregion

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string name
        {
            get
            {
                return this.nameField;
            }
            set
            {
                this.nameField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal total
        {
            get
            {
                return this.totalField;
            }
            set
            {
                this.totalField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal errors
        {
            get
            {
                return this.errorsField;
            }
            set
            {
                this.errorsField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal failures
        {
            get
            {
                return this.failuresField;
            }
            set
            {
                this.failuresField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal inconclusive
        {
            get
            {
                return this.inconclusiveField;
            }
            set
            {
                this.inconclusiveField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute("not-run")]
        public decimal notrun
        {
            get
            {
                return this.notrunField;
            }
            set
            {
                this.notrunField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal ignored
        {
            get
            {
                return this.ignoredField;
            }
            set
            {
                this.ignoredField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal skipped
        {
            get
            {
                return this.skippedField;
            }
            set
            {
                this.skippedField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public decimal invalid
        {
            get
            {
                return this.invalidField;
            }
            set
            {
                this.invalidField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string date
        {
            get
            {
                return this.dateField;
            }
            set
            {
                this.dateField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string time
        {
            get
            {
                return this.timeField;
            }
            set
            {
                this.timeField = value;
            }
        }
    }
}
