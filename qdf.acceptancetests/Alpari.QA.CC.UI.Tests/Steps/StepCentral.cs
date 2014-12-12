﻿using Alpari.QA.Webdriver.Core;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.UI.Tests.Steps
{
    [Binding]
    public class StepCentral : MasterStepBase
    {
        public StepCentral(IWebdriverCore webdriverCore)
        {
            WebdriverCore = webdriverCore;
        }

        /// <summary>
        ///     making the massive assumption that all tests will use webdriver...
        ///     TODO:- configure hooks to take parameters for webdriver config etc.
        /// </summary>
        public static IWebdriverCore WebdriverCore { get; set; }

        [StepArgumentTransformation]
        new public static ExportParameters ExportParametersTransform(Table table)
        {
            return MasterStepBase.ExportParametersTransform(table);
        }
    }
}