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
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(TypeName = "test-suiteType")]
    public class testsuiteType
    {
        private object itemField;
        private string typeField;
        private string nameField;
        private string descriptionField;
        private string successField;
        private string timeField;
        private string executedField;
        private string assertsField;
        private string resultField;
        private resultsType resultsField;

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("failure", typeof(failureType))]
        //[System.Xml.Serialization.XmlElementAttribute("reason", typeof(reasonType))]
        public object Item
        {
            get
            {
                return this.itemField;
            }
            set
            {
                this.itemField = value;
            }
        }



        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string type
        {
            get
            {
                return this.typeField;
            }
            set
            {
                this.typeField = value;
            }
        }

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
        public string description
        {
            get
            {
                return this.descriptionField;
            }
            set
            {
                this.descriptionField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string success
        {
            get
            {
                return this.successField;
            }
            set
            {
                this.successField = value;
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

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string executed
        {
            get
            {
                return this.executedField;
            }
            set
            {
                this.executedField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string asserts
        {
            get
            {
                return this.assertsField;
            }
            set
            {
                this.assertsField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string result
        {
            get
            {
                return this.resultField;
            }
            set
            {
                this.resultField = value;
            }
        }

        /// <remarks/>
        public resultsType results
        {
            get
            {
                return this.resultsField;
            }
            set
            {
                this.resultsField = value;
            }
        }

        #region ignored code
        //private categoryType[] categoriesField;

        //private propertyType[] propertiesField;

        

        ///// <remarks/>
        //[System.Xml.Serialization.XmlArrayItemAttribute("category", IsNullable = false)]
        //public categoryType[] categories
        //{
        //    get
        //    {
        //        return this.categoriesField;
        //    }
        //    set
        //    {
        //        this.categoriesField = value;
        //    }
        //}

        ///// <remarks/>
        //[System.Xml.Serialization.XmlArrayItemAttribute("property", IsNullable = false)]
        //public propertyType[] properties
        //{
        //    get
        //    {
        //        return this.propertiesField;
        //    }
        //    set
        //    {
        //        this.propertiesField = value;
        //    }
        //}


        #endregion
    }
}
