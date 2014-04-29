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
            NunitXmlParser nunitXmlParser = GetNunitXmlParser();
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
            NunitXmlParser nunitXmlParser = GetNunitXmlParser();
            Assert.AreEqual(expectedName, nunitXmlParser.XmlRoot.Name);
        }

        [Then(@"test-results with a ""(.*)"" attribute value of ""(.*)"" exists")]
        public void ThenTest_ResultsWithAAttributeValueOfExists(string attributeName, string attributeValue)
        {
            NunitXmlParser nunitXmlParser = GetNunitXmlParser();
            IDictionary<string, object> testResultsDictionary = GetTestResultsDictionary(nunitXmlParser);
            Assert.AreEqual(attributeValue, testResultsDictionary[attributeName]);
        }

        [Then(@"a test-results object with the following attribute values exists:")]
        public void ThenATest_ResultsObjectWithTheFollowingAttributeValuesExists(Table expectedTestResults)
        {
            NunitXmlParser nunitXmlParser = GetNunitXmlParser();
            IDictionary<string, object> testResultsDictionary = GetTestResultsDictionary(nunitXmlParser);
            IList<IDictionary<string, object>> tableAsList = DataTableOperations.GetTableAsList(expectedTestResults);
            string verificationErrors = DataTableOperations.VerifyTables(tableAsList[0], testResultsDictionary);
            Assert.IsEmpty(verificationErrors);
        }

        [Then(@"an environment object with the following attribute values exists:")]
        public void ThenAnEnvironmentObjectWithTheFollowingAttributeValuesExists(Table expectedHostTestEnvironment)
        {
            NunitXmlParser nunitXmlParser = GetNunitXmlParser();
            IDictionary<string, object> hostTestEnvironmentDictionary = GetHostTestEnvironmentDictionary(nunitXmlParser);
            IList<IDictionary<string, object>> tableAsList =
                DataTableOperations.GetTableAsList(expectedHostTestEnvironment);
            //make sure there is only 1 result to start with!
            Assert.AreEqual(1, nunitXmlParser.HostTestEnvironmentList.Count);
            string verificationErrors = DataTableOperations.VerifyTables(tableAsList[0], hostTestEnvironmentDictionary);
            Assert.IsEmpty(verificationErrors);
        }

        [When(@"I parse the xml test result file as an environment")]
        public void WhenIParseTheXmlTestResultFileAsAnEnvironment()
        {
            NunitXmlParser nunitXmlParser = GetNunitXmlParser();
            nunitXmlParser.SetTestEnvironment();
        }

        [Then(@"an environment with a ""(.*)"" attribute value of ""(.*)"" exists")]
        public void ThenAnEnvironmentWithAAttributeValueOfExists(string attributeName, string attributeValue)
        {
            NunitXmlParser nunitXmlParser = GetNunitXmlParser();
            IDictionary<string, object> hostTestEnvironmentDictionary = GetHostTestEnvironmentDictionary(nunitXmlParser);
            Assert.AreEqual(attributeValue, hostTestEnvironmentDictionary[attributeName]);
        }

        [When(@"I parse the xml test result file as a test-suite collection")]
        public void WhenIParseTheXmlTestResultFileAsATest_SuiteCollection()
        {
            NunitXmlParser nunitXmlParser = GetNunitXmlParser();
            nunitXmlParser.SetTestSuiteCollection();
        }

        [Then(@"a test-suite with a ""(.*)"" attribute value of ""(.*)"" exists")]
        public void ThenATest_SuiteWithAAttributeValueOfExists(string attributeName, string attributeValue)
        {
            IList<Dictionary<string, object>> testSuiteCollectionAsListOfTestSuiteDictionaries =
                SaveTestSuiteCollectionAsListOfDictionaries();
            //build a KVP with expected values
            var item = new KeyValuePair<string, object>(attributeName, attributeValue);
            Dictionary<string, object> actual =
                DataTableOperations.GetDictionaryFromListOfDictionariesByKeyValuePair(item,
                    testSuiteCollectionAsListOfTestSuiteDictionaries);
            actual.Should().Contain(item);
        }

        [Then(@"the following test cases are found for these test suites:")]
        public void ThenTheFollowingTestCasesAreFoundForTheseTestSuites(Table testCasesInTestSuites)
        {
            ExpectedAndActualTestCasesBySuiteAsIlIsts expectedAndActualTestCases =
                GetExpectedAndActualTestCasesBySuiteAsILists(testCasesInTestSuites);
            string verificationErrors = DataTableOperations.VerifyTables(expectedAndActualTestCases);
            Assert.IsEmpty(verificationErrors);
        }

        [Then(@"the following test cases are found for these test suites keyed by ""(.*)"":")]
        public void ThenTheFollowingTestCasesAreFoundForTheseTestSuitesKeyedBy(string tableKey,
            Table testCasesInTestSuites)
        {
            ExpectedAndActualTestCasesBySuiteAsIlIsts expectedAndActualTestCases =
                GetExpectedAndActualTestCasesBySuiteAsILists(testCasesInTestSuites);
            string verificationErrors = DataTableOperations.VerifyTables(tableKey, expectedAndActualTestCases);
            Assert.IsEmpty(verificationErrors);
        }

        [Then(@"the following test cases are found for these test suites keyed by containing a ""(.*)"":")]
        public void ThenTheFollowingTestCasesAreFoundForTheseTestSuitesKeyedByContainingA(string tableKey,
            Table testCasesInTestSuites)
        {
            ExpectedAndActualTestCasesBySuiteAsIlIsts expectedAndActualTestCases =
                GetExpectedAndActualTestCasesBySuiteAsILists(testCasesInTestSuites);
            string verificationErrors = DataTableOperations.VerifyTables(tableKey, "ContainsListEntry",
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
            NunitXmlParser nunitXmlParser = GetNunitXmlParser();
            nunitXmlParser.SetCultureInfo();
        }

        [Then(@"a single culture-info object exists")]
        public void ThenASingleCulture_InfoObjectExists()
        {
            NunitXmlParser nunitXmlParser = GetNunitXmlParser();
            Assert.AreEqual(1, nunitXmlParser.CultureinfoTypeList.Count);
        }

        [Then(@"a culture-info with a ""(.*)"" attribute value of ""(.*)"" exists")]
        public void ThenACulture_InfoWithAAttributeValueOfExists(string attributeName, string attributeValue)
        {
            NunitXmlParser nunitXmlParser = GetNunitXmlParser();
            IDictionary<string, object> cultureInfoDictionary = GetCultureInfoDictionary(nunitXmlParser);
            Assert.AreEqual(attributeValue, cultureInfoDictionary[attributeName]);
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