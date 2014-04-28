using System;
using System.Collections.Generic;
using Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using FluentAssertions;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class SpecflowZapiReporterParserSteps : SpecFlowZapiReporterParserStepBase
    {
        [Given(@"I have an xml test result file")]
        public void GivenIHaveAnXmlTestResultFile(string fileNamePath)
        {
            SetNunitXmlParser(fileNamePath);
        }

        [When(@"I parse the xml test result file as test-results")]
        public void WhenIParseTheXmlTestResultFileAsTest_Results()
        {
            var nunitXmlParser = GetNunitXmlParser();
            nunitXmlParser.SetTestResults();
        }

        //[Then(@"the xml has a content that can be read as a string")]
        //public void ThenTheXmlHasAContentThatCanBeReadAsAString()
        //{
        //    var nunitXmlParser = GetNunitXmlParser();
        //    var result = nunitXmlParser.XmlString;
        //    Console.WriteLine("xml = {0}", result);
        //    Assert.IsNotEmpty(result);
        //}

        [Then(@"the xml root Name property is ""(.*)""")]
        public void ThenTheXmlRootNamePropertyIs(string expectedName)
        {
            var nunitXmlParser = GetNunitXmlParser();
            Assert.AreEqual(expectedName, nunitXmlParser.XmlRoot.Name);
        }

        [Then(@"test-results with a ""(.*)"" attribute value of ""(.*)"" exists")]
        public void ThenTest_ResultsWithAAttributeValueOfExists(string attributeName, string attributeValue)
        {
            var nunitXmlParser = GetNunitXmlParser();
            var TestResultsDictionary = GetTestResultsDictionary(nunitXmlParser);
            Assert.AreEqual(attributeValue, TestResultsDictionary[attributeName]);
        }

        [Then(@"a test-results object with the following attribute values exists:")]
        public void ThenATest_ResultsObjectWithTheFollowingAttributeValuesExists(Table expectedTestResults)
        {
            var nunitXmlParser = GetNunitXmlParser();
            var TestResultsDictionary = GetTestResultsDictionary(nunitXmlParser);
            var tableAsList = DataTableOperations.GetTableAsList(expectedTestResults);
            var verificationErrors = DataTableOperations.VerifyTables(tableAsList[0], TestResultsDictionary);
            Assert.IsEmpty(verificationErrors);
        }

        [Then(@"an environment object with the following attribute values exists:")]
        public void ThenAnEnvironmentObjectWithTheFollowingAttributeValuesExists(Table expectedHostTestEnvironment)
        {
            var nunitXmlParser = GetNunitXmlParser();
            var HostTestEnvironmentDictionary = GetHostTestEnvironmentDictionary(nunitXmlParser);
            var tableAsList =
                DataTableOperations.GetTableAsList(expectedHostTestEnvironment);
            //make sure there is only 1 result to start with!
            Assert.AreEqual(1, nunitXmlParser.HostTestEnvironmentList.Count);
            var verificationErrors = DataTableOperations.VerifyTables(tableAsList[0], HostTestEnvironmentDictionary);
            Assert.IsEmpty(verificationErrors);
        }

        [When(@"I parse the xml test result file as an environment")]
        public void WhenIParseTheXmlTestResultFileAsAnEnvironment()
        {
            var nunitXmlParser = GetNunitXmlParser();
            nunitXmlParser.SetTestEnvironment();
        }

        [Then(@"an environment with a ""(.*)"" attribute value of ""(.*)"" exists")]
        public void ThenAnEnvironmentWithAAttributeValueOfExists(string attributeName, string attributeValue)
        {
            var nunitXmlParser = GetNunitXmlParser();
            var HostTestEnvironmentDictionary = GetHostTestEnvironmentDictionary(nunitXmlParser);
            Assert.AreEqual(attributeValue, HostTestEnvironmentDictionary[attributeName]);
        }

        [When(@"I parse the xml test result file as a test-suite collection")]
        public void WhenIParseTheXmlTestResultFileAsATest_SuiteCollection()
        {
            var nunitXmlParser = GetNunitXmlParser();
            nunitXmlParser.SetTestSuiteCollection();
        }

        [Then(@"a test-suite with a ""(.*)"" attribute value of ""(.*)"" exists")]
        public void ThenATest_SuiteWithAAttributeValueOfExists(string attributeName, string attributeValue)
        {
            var TestSuiteCollectionAsListOfTestSuiteDictionaries =
                SaveTestSuiteCollectionAsListOfDictionaries();
            //build a KVP with expected values
            var item = new KeyValuePair<string, object>(attributeName, attributeValue);
            var actual =
                DataTableOperations.GetDictionaryFromListOfDictionariesByKeyValuePair(item,
                    TestSuiteCollectionAsListOfTestSuiteDictionaries);
            actual.Should().Contain(item);
        }

        [Then(@"the following test cases are found for these test suites:")]
        public void ThenTheFollowingTestCasesAreFoundForTheseTestSuites(Table testCasesInTestSuites)
        {
            var expectedAndActualTestCases =
                GetExpectedAndActualTestCasesBySuiteAsILists(testCasesInTestSuites);
            var verificationErrors = DataTableOperations.VerifyTables(expectedAndActualTestCases);
            Assert.IsEmpty(verificationErrors);
        }

        [Then(@"the following test cases are found for these test suites keyed by ""(.*)"":")]
        public void ThenTheFollowingTestCasesAreFoundForTheseTestSuitesKeyedBy(string tableKey,
            Table testCasesInTestSuites)
        {
            var expectedAndActualTestCases =
                GetExpectedAndActualTestCasesBySuiteAsILists(testCasesInTestSuites);
            var verificationErrors = DataTableOperations.VerifyTables(tableKey, expectedAndActualTestCases);
            Assert.IsEmpty(verificationErrors);
        }

        [Then(@"the following test cases are found for these test suites keyed by containing a ""(.*)"":")]
        public void ThenTheFollowingTestCasesAreFoundForTheseTestSuitesKeyedByContainingA(string tableKey,
            Table testCasesInTestSuites)
        {
            var expectedAndActualTestCases =
                GetExpectedAndActualTestCasesBySuiteAsILists(testCasesInTestSuites);
            var verificationErrors = DataTableOperations.VerifyTables(tableKey, "ContainsListEntry",
                expectedAndActualTestCases);
            Assert.IsEmpty(verificationErrors);
        }

        [Then(@"the following test cases are found for these test suites keyed by containing a ""(.*)"" value:")]
        public void ThenTheFollowingTestCasesAreFoundForTheseTestSuitesKeyedByContainingAValue(string tableKey,
            Table testCasesInTestSuites)
        {
            ThenTheFollowingTestCasesAreFoundForTheseTestSuitesKeyedByContainingA(tableKey, testCasesInTestSuites);
        }


        [When(@"I parse the xml test result file as culture-info")]
        public void WhenIParseTheXmlTestResultFileAsCulture_Info()
        {
            var nunitXmlParser = GetNunitXmlParser();
            nunitXmlParser.SetCultureInfo();
        }

        [Then(@"a single culture-info object exists")]
        public void ThenASingleCulture_InfoObjectExists()
        {
            var nunitXmlParser = GetNunitXmlParser();
            Assert.AreEqual(1, nunitXmlParser.CultureinfoTypeList.Count);
        }

        [Then(@"a culture-info with a ""(.*)"" attribute value of ""(.*)"" exists")]
        public void ThenACulture_InfoWithAAttributeValueOfExists(string attributeName, string attributeValue)
        {
            var nunitXmlParser = GetNunitXmlParser();
            var CultureInfoDictionary = GetCultureInfoDictionary(nunitXmlParser);
            Assert.AreEqual(attributeValue, CultureInfoDictionary[attributeName]);
        }

        #region obsolete code

        //[When(@"I parse the xml test result file as Nunit schema test-results")]
        //public void WhenIParseTheXmlTestResultFileAsNunitSchemaTest_Results()
        //{
        //    var nunitXmlParser = GetNunitXmlParser();
        //    var resultType = nunitXmlParser.ParseAsNUnitSchemaTestResults();
        //    ScenarioContext.Current[resultType.GetType().ToString()] = resultType;
        //}

        //couldn't get the built in table methods working correctly
        ////var expectedTestResultsAsTestResults = expectedTestResults.CreateSet<resultType>();
        //var nunitXmlParser = GetNunitXmlParser();
        //expectedTestResults.CompareToSet<resultType>(nunitXmlParser.TestResults);

        #endregion
    }
}