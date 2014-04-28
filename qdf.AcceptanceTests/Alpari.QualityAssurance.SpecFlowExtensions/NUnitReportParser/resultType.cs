using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Xml.Serialization;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser
{
    /// <summary>
    ///     just using the xsd toget the data structure
    ///     The results file is quite messy and nested, so the complex types are ignored for now
    ///     updated the source xsd to the Nunit provided one rather thena the VS generated one as it's simpler,
    ///     but still doesn't auto parse the result xml!
    /// </summary>
    [GeneratedCode("xsd", "4.0.30319.17929")]
    [Serializable]
    //[System.Diagnostics.DebuggerStepThroughAttribute()]
    [DesignerCategory("code")]
    [XmlType(AnonymousType = true)]
    [XmlRoot("test-results", Namespace = "", IsNullable = false)]
    public class resultType
    {
        private string dateField;
        private decimal errorsField;
        private decimal failuresField;
        private decimal ignoredField;
        private decimal inconclusiveField;
        private decimal invalidField;
        private string nameField;
        private decimal notrunField;
        private decimal skippedField;
        private string timeField;
        private decimal totalField;

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

        /// <remarks />
        [XmlAttribute]
        public string name
        {
            get { return nameField; }
            set { nameField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public decimal total
        {
            get { return totalField; }
            set { totalField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public decimal errors
        {
            get { return errorsField; }
            set { errorsField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public decimal failures
        {
            get { return failuresField; }
            set { failuresField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public decimal inconclusive
        {
            get { return inconclusiveField; }
            set { inconclusiveField = value; }
        }

        /// <remarks />
        [XmlAttribute("not-run")]
        public decimal notrun
        {
            get { return notrunField; }
            set { notrunField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public decimal ignored
        {
            get { return ignoredField; }
            set { ignoredField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public decimal skipped
        {
            get { return skippedField; }
            set { skippedField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public decimal invalid
        {
            get { return invalidField; }
            set { invalidField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string date
        {
            get { return dateField; }
            set { dateField = value; }
        }

        /// <remarks />
        [XmlAttribute]
        public string time
        {
            get { return timeField; }
            set { timeField = value; }
        }
    }
}