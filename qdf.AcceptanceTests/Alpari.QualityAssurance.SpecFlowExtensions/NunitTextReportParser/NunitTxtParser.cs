using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NunitTextReportParser
{
    public class NunitTxtParser
    {
        public NunitTxtParser(string fileNamePath)
        {
            ReadTextFile(fileNamePath);
            TestCases = new List<TestCaseTextResult>();
        }

        public IEnumerable<string> FileText { get; private set; }

        public IList<TestCaseTextResult> TestCases { get; set; }

        private void ReadTextFile(string fileNamePath)
        {
            FileText = File.ReadAllLines(fileNamePath);
        }

        public void ParseTextTestResultFileAsTestSuiteCollection()
        {
            //throw new NotImplementedException();
            foreach (var line in FileText)
            {
                if (AddNewTestCase(line))
                {
                }
                    //todo : parameterise for projet name / primary tag key being different
                if (AddTagList(line, "@TES-"))
                {
                }
                if (AddTestStepResult(line))
                {
                }
                if (AddTestStepResultDetail(line))
                {
                }
                AddTestCaseShortName(line);
            }
        }

        private bool AddTestStepResultDetail(string line)
        {
            if (TestCases.Last().TestStepResults.Count > 0)
            {
                TestCases.Last().TestStepResults.Last().StepDetails.Add(line);
                return true;
            }
            return false;
        }

        private bool AddTestStepResult(string line)
        {
            var firstWord = line.Split(' ').ToList().First();

            switch (firstWord)
            {
                case "Given":
                case "Then":
                case "When":
                case "And":
                case "But":
                    TestCases.Last().AddTestStep(line);
                    return true;
                default:
                    return false;
            }
        }

        private void AddTestCaseShortName(string line)
        {
            if ((TestCases.Last().ShortName == null) && line.Trim().Length > 0)
            {
                TestCases.Last().ShortName = line;
                //TestCases.ElementAt(TestCases.Count-1).shortName = line;
            }
        }

        private bool AddNewTestCase(string line)
        {
            if (line.StartsWith("***** "))
            {
                var testCase = new TestCaseTextResult(line.Replace("***** ", ""));
                TestCases.Add(testCase);
                return true;
            }
            return false;
        }

        private bool AddTagList(string line, string primaryTagId)
        {
            if (line.StartsWith("Tags:- "))
            {
                var taglist = line.Replace("Tags:- ", "");
                //var testCase = TestCases.ElementAt(TestCases.Count-1);
                var testCase = TestCases.Last();
                testCase.SetTags(taglist, primaryTagId);
                return true;
            }
            return false;
        }

        public Dictionary<string, TestCaseTextResult> TestCaseTextResultsToDictionary()
        {
            //Might need seperate method!
            //IList<TestCaseTextResult> testCases = this.TestCases;
            //var d = new Dictionary<string, TestCaseTextResult>();
            //foreach (var result in testCases)
            //{
            //    d.Add(result.PrimaryTag, result);
            //}
            // is equivalent to:-
            //var linqD = testCases.ToDictionary(x => x.PrimaryTag); //  now has all the correct data - Now don't need to converttestcase results to dictionaries
            return TestCases.ToDictionary(x => x.PrimaryTag);
                //  now has all the correct data - Now don't need to converttestcase results to dictionaries
        }

        public Dictionary<string, CombinedTextAndXmlResult> MergeTestResults(
            IList<IDictionary<string, object>> actualXmlTestCaseResults)
        {
            // Dictionary<string, CombinedTextAndXmlResult> mergedResults = new Dictionary<string, CombinedTextAndXmlResult>() ;
            // Dictionary<string, TestCaseTextResult> textResults = this.TestCaseTextResultsToDictionary();
            //var query = from result in textResults
            //            select new CombinedTextAndXmlResult(result.Value, actualXmlTestCaseResults);
            //foreach (var item in query)
            //{
            //    mergedResults[item.textResult.PrimaryTag] = item;
            //}
            //return query.ToDictionary(x => x.textResult.PrimaryTag);
            //var sdq = textResults.AsEnumerable().Select(textResult => new CombinedTextAndXmlResult(textResult.Value, actualXmlTestCaseResults));
            return TestCaseTextResultsToDictionary() //.AsEnumerable() // Do I need this?
                .Select(textResult => new CombinedTextAndXmlResult(textResult.Value, actualXmlTestCaseResults))
                .ToDictionary(x => x.TextResult.PrimaryTag);
        }
    }
}