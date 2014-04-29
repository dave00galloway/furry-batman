using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
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
    [DebuggerStepThrough]
    [DesignerCategory("code")]
    [XmlType(AnonymousType = true)]
    [XmlRoot("test-results", Namespace = "", IsNullable = false)]
    public class ResultType
    {
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
        public string Name { get; set; }

        /// <remarks />
        [XmlAttribute]
        public decimal Total { get; set; }

        /// <remarks />
        [XmlAttribute]
        public decimal Errors { get; set; }

        /// <remarks />
        [XmlAttribute]
        public decimal Failures { get; set; }

        /// <remarks />
        [XmlAttribute]
        public decimal Inconclusive { get; set; }

        /// <remarks />
        [XmlAttribute("not-run")]
        public decimal Notrun { get; set; }

        /// <remarks />
        [XmlAttribute]
        public decimal Ignored { get; set; }

        /// <remarks />
        [XmlAttribute]
        public decimal Skipped { get; set; }

        /// <remarks />
        [XmlAttribute]
        public decimal Invalid { get; set; }

        /// <remarks />
        [XmlAttribute]
        public string Date { get; set; }

        /// <remarks />
        [XmlAttribute]
        public string Time { get; set; }
    }
}