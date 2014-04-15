using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NunitTextReportParser
{
    public class TestStepResult
    {
        public string TestStep { get; private set; }
        public List<string> StepDetails { get; private set; }

        public TestStepResult()
        {
            StepDetails = new List<string>();
        }

        public TestStepResult(string testStep)
        {
            this.TestStep = testStep;
            StepDetails = new List<string>();
        }
    }
}
