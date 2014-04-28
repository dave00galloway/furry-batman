using System.Collections.Generic;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NunitTextReportParser
{
    public class TestStepResult
    {
        public TestStepResult()
        {
            StepDetails = new List<string>();
        }

        public TestStepResult(string testStep)
        {
            TestStep = testStep;
            StepDetails = new List<string>();
        }

        public string TestStep { get; private set; }
        public List<string> StepDetails { get; private set; }
    }
}