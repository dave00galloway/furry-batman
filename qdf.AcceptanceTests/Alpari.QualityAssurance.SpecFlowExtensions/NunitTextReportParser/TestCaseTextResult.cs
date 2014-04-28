using System.Collections.Generic;
using System.Linq;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NunitTextReportParser
{
    public class TestCaseTextResult
    {
        public TestCaseTextResult(string longName)
        {
            LongName = longName;
            TestStepResults = new List<TestStepResult>();
        }

        public string LongName { get; private set; }
        public string ShortName { get; set; }
        public List<string> Tags { get; private set; }
        public string PrimaryTag { get; private set; }
        public List<TestStepResult> TestStepResults { get; private set; }

        public void SetTags(string taglist, string primaryTagId)
        {
            Tags = taglist.Split(',').Select(x => x.Trim()).ToList();
            PrimaryTag = Tags.Where(x => x.StartsWith(primaryTagId)).ToList().First();
        }

        public void AddTestStep(string line)
        {
            TestStepResults.Add(new TestStepResult(line));
        }
    }
}