using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QA.CC.MT4Positions2RedisTests.Transforms;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class LogFileSplitterSteps : StepCentral
    {
        private LogFileSplitParams<string, string> _paramFileSplitParams;

        [Given(@"I have the following log file splitter parameters:-")]
        public void GivenIHaveTheFollowingLogFileSplitterParameters(Table table)
        {
            _paramFileSplitParams = table.LogFileSplitParametersTransform();
            _paramFileSplitParams.OutputFile = ScenarioOutputDirectory + _paramFileSplitParams.OutputFile;
        }
        
        [When(@"I split the log file")]
        public void WhenISplitTheLogFile()
        {
            _paramFileSplitParams.CreateLogFileExtract();
        }

    }
}
