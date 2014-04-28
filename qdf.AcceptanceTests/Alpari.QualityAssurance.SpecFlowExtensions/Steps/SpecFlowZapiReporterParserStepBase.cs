using System;
using System.Collections.Generic;
using System.IO;
using Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    public class SpecFlowZapiReporterParserStepBase : CrossStepDefinitionStepBase
    {
        /// <summary>
        ///     The key that will be used to set the NunitXmlParser in the Scenario Context
        ///     TODO:- Get these strings from Reflection!
        /// </summary>
        public static readonly string NUNIT_XML_PARSER_FULLY_QUALIFIED_NAME =
            "Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser.NunitXmlParser";

        public static void SetNunitXmlParser(string fileNamePath)
        {
            var nunitXmlParser = new NunitXmlParser(fileNamePath, FileMode.Open);
            // var nunitXmlParser = new NunitXmlParser(fileNamePath,true, FileMode.Open);
            //ScenarioContext.Current[nunitXmlParser.ToString()] = nunitXmlParser;
            ScenarioContext.Current[NUNIT_XML_PARSER_FULLY_QUALIFIED_NAME] = nunitXmlParser;
        }

        /// <summary>
        ///     Get the default xml parser
        /// </summary>
        /// <returns></returns>
        public static NunitXmlParser GetNunitXmlParser()
        {
            return (NunitXmlParser) ScenarioContext.Current[NUNIT_XML_PARSER_FULLY_QUALIFIED_NAME];
        }

        public static IDictionary<string, object> GetTestResultsDictionary(NunitXmlParser nunitXmlParser)
        {
            Type TestResultsType = nunitXmlParser.TestResults.GetType();
            IDictionary<string, object> TestResultsDictionary =
                DataTableOperations.getObjectPropertiesAsDictionary(nunitXmlParser.TestResults, TestResultsType);
            return TestResultsDictionary;
        }

        public static IDictionary<string, object> GetHostTestEnvironmentDictionary(NunitXmlParser nunitXmlParser)
        {
            Type HostTestEnvironmentType = nunitXmlParser.HostTestEnvironment.GetType();
            IDictionary<string, object> HostTestEnvironmentDictionary =
                DataTableOperations.getObjectPropertiesAsDictionary(nunitXmlParser.HostTestEnvironment,
                    HostTestEnvironmentType);
            return HostTestEnvironmentDictionary;
        }

        public static IDictionary<string, object> GetCultureInfoDictionary(NunitXmlParser nunitXmlParser)
        {
            Type CultureinfoType = nunitXmlParser.CultureinfoType.GetType();
            IDictionary<string, object> CultureinfoTypeDictionary =
                DataTableOperations.getObjectPropertiesAsDictionary(nunitXmlParser.CultureinfoType, CultureinfoType);
            return CultureinfoTypeDictionary;
        }

        /// <summary>
        ///     TODO:- investigate using Generics , type arguments, and Linq to reduce number of methods needed to do these
        ///     transformations
        /// </summary>
        /// <param name="testSuiteTypeCollection"></param>
        /// <returns></returns>
        public IList<Dictionary<string, object>> GetTestSuiteCollectionAsListOfTestSuiteDictionaries(
            List<testsuiteType> testSuiteTypeCollection)
        {
            IList<Dictionary<string, object>> ListOfTestSuiteDictionaries = new List<Dictionary<string, object>>();
            Type TestSuiteType = testSuiteTypeCollection[0].GetType();
            foreach (testsuiteType testSuiteTypeCollectionItem in testSuiteTypeCollection)
            {
                IDictionary<string, object> CultureinfoTypeDictionary =
                    DataTableOperations.getObjectPropertiesAsDictionary(testSuiteTypeCollectionItem, TestSuiteType);
                ListOfTestSuiteDictionaries.Add((Dictionary<string, object>) CultureinfoTypeDictionary);
            }
            return ListOfTestSuiteDictionaries;
        }

        public IList<Dictionary<string, object>> SaveTestSuiteCollectionAsListOfDictionaries()
        {
            NunitXmlParser nunitXmlParser = GetNunitXmlParser();
            List<testsuiteType> testSuiteTypeCollection = nunitXmlParser.TestSuiteTypeCollection;
            IList<Dictionary<string, object>> TestSuiteCollectionAsListOfTestSuiteDictionaries =
                GetTestSuiteCollectionAsListOfTestSuiteDictionaries(testSuiteTypeCollection);
            ScenarioContext.Current[TestSuiteCollectionAsListOfTestSuiteDictionaries.ToString()] =
                TestSuiteCollectionAsListOfTestSuiteDictionaries;
            return TestSuiteCollectionAsListOfTestSuiteDictionaries;
        }

        public static ExpectedAndActualTestCasesBySuiteAsIlIsts GetExpectedAndActualTestCasesBySuiteAsILists(
            Table testCasesInTestSuites)
        {
            var expectedAndActualTestCases = new ExpectedAndActualTestCasesBySuiteAsIlIsts();
            expectedAndActualTestCases.Expected = DataTableOperations.getTableAsList(testCasesInTestSuites);
            expectedAndActualTestCases.Actual = GetNunitXmlParser().GetTestCasesByTestSuiteAsList();
            return expectedAndActualTestCases;
        }
    }

    public class ExpectedAndActualTestCasesBySuiteAsIlIsts : ExpectedAndActualIDictionariesAsIlIsts
    {
    }
}