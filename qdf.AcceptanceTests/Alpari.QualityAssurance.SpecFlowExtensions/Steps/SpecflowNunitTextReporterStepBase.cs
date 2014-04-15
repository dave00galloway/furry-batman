using Alpari.QualityAssurance.SpecFlowExtensions.NunitTextReportParser;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class SpecflowNunitTextReporterStepBase : CrossStepDefinitionStepBase
    {
        public static void SetNunitTxtParser(string fileNamePath)
        {
            var nunitXmlParser = new NunitTxtParser(fileNamePath);
            ScenarioContext.Current[typeof(NunitTxtParser).ToString()] = nunitXmlParser;
        }

        public static NunitTxtParser GetNunitTextParser()
        {
            return (NunitTxtParser)ScenarioContext.Current[typeof(NunitTxtParser).ToString()];
        }

        public static IList<TestCaseTextResult> GetTestCaseTextResults()
        {
            var nunitXmlParser = GetNunitTextParser();
            IList<TestCaseTextResult> testCases = nunitXmlParser.TestCases;
            return testCases;
        }

        public static ExpectedAndActualTestCasesBySuiteAsIlIsts GetExpectedAndActualTestCasesBySuiteAsILists(Table testCasesInTestSuites)
        {
            //avoid issue of x def steps by calling the method statically!
            return SpecflowZapiReporterParserSteps.GetExpectedAndActualTestCasesBySuiteAsILists(testCasesInTestSuites);
        }
    }
}
