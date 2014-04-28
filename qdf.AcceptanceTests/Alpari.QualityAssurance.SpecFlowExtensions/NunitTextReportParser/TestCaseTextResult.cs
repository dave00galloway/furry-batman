using System.Collections.Generic;
using System.Linq;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NunitTextReportParser
{
    public class TestCaseTextResult
    {
        public TestCaseTextResult(string longName)
        {
            this.longName = longName;
            TestStepResults = new List<TestStepResult>();
        }

        public string longName { get; private set; }
        public string shortName { get; set; }
        public List<string> Tags { get; private set; }
        public string PrimaryTag { get; private set; }
        public List<TestStepResult> TestStepResults { get; private set; }

        public void setTags(string taglist, string primaryTagId)
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