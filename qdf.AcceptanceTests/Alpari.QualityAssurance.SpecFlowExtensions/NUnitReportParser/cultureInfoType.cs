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
    [System.Xml.Serialization.XmlTypeAttribute(TypeName = "culture-infoType")]
    public class cultureinfoType
    {
        private string currentcultureField;
        private string currentuicultureField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute("current-culture")]
        public string currentculture
        {
            get
            {
                return this.currentcultureField;
            }
            set
            {
                this.currentcultureField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute("current-uiculture")]
        public string currentuiculture
        {
            get
            {
                return this.currentuicultureField;
            }
            set
            {
                this.currentuicultureField = value;
            }
        }
    }
}
