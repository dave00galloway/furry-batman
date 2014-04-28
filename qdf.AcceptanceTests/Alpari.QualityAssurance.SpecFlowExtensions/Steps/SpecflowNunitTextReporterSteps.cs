using System.Collections.Generic;
using System.Linq;
using Alpari.QualityAssurance.SpecFlowExtensions.NunitTextReportParser;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using FluentAssertions;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.Steps
{
    [Binding]
    public class SpecflowNunitTextReporterSteps : SpecflowNunitTextReporterStepBase
    {
        [Given(@"I have a text test result file ""(.*)""")]
        public void GivenIHaveATextTestResultFile(string fileNamePath)
        {
            //throw new NotImplementedException(String.Format("need to write a FileStrream Parser for {0}", fileNamePath));
            SetNunitTxtParser(fileNamePath);
        }

        [When(@"I parse the text test result file as a test-suite collection")]
        public void WhenIParseTheTextTestResultFileAsATest_SuiteCollection()
        {
            var nunitXmlParser = GetNunitTextParser();
            nunitXmlParser.ParseTextTestResultFileAsTestSuiteCollection();
        }

        [Then(@"the text file parser contains some test cases")]
        public void ThenTheTextFileParserContainsSomeTestCases()
        {
            var testCases = GetTestCaseTextResults();
            testCases.Count.Should().BeGreaterThan(0);
        }

        [Then(@"the text file parser contains some test cases with tags")]
        public void ThenTheTextFileParserContainsSomeTestCasesWithTags()
        {
            var testCases = GetTestCaseTextResults();
            testCases.Any(x => x.Tags.Count.Should().BeGreaterThan(0).Equals(true));
        }

        [Then(@"the text file parser contains some test cases with a primary tag")]
        public void ThenTheTextFileParserContainsSomeTestCasesWithAPrimaryTag()
        {
            var testCases = GetTestCaseTextResults();
            testCases.Any(x => x.PrimaryTag.Should().NotBeNullOrWhiteSpace().Equals(true));
        }

        [Then(
            @"the following test case text results are found for these test suites keyed by containing a ""(.*)"" value:"
            )]
        public void ThenTheFollowingTestCaseTextResultsAreFoundForTheseTestSuitesKeyedByContainingAValue(
            string tableKey, Table testCasesInTestSuites)
        {
            //Currently still just looking at the XML results here - need to add the txt results too!
            var expectedAndActualTestCases =
                GetExpectedAndActualTestCasesBySuiteAsILists(testCasesInTestSuites);
            var nunitXmlParser = GetNunitTextParser();
            //var linqD = nunitXmlParser.TestCaseTextResultsToDictionary();
            var actualXmlTestCaseResults = expectedAndActualTestCases.Actual;
                // now, do we add the txt results to this dict? Why not create a new type keyed by primary tag?
            var combinedResults =
                nunitXmlParser.MergeTestResults(actualXmlTestCaseResults);
            //join the List of xml tests to the txt test using the primary tag, replacing the _ in the xml tag with the - in the primary tag.
            //Add some fields from txt to the expecte result set to prove the txt result has been joined
            /* Broken verification - can't check a tag is both _ and - so need to sort out in source, then change all the tests (or the other way round!)*/
            var verificationErrors = DataTableOperations.VerifyTables(tableKey, "ContainsListEntry",
                expectedAndActualTestCases);
            Assert.IsEmpty(verificationErrors);
            combinedResults.Should().NotBeEmpty();
        }


        [Then(@"the text file parser contains some text")]
        public void ThenTheTextFileParserContainsSomeText()
        {
            var nunitXmlParser = GetNunitTextParser();
            nunitXmlParser.FileText.Should().NotBeEmpty();
        }
    }
}