using System.Collections.Generic;
using Alpari.QA.CC.MT4Positions2RedisTests.X64.Transforms;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.X64.Steps
{
    [Binding]
    public class LogFileSplitterSteps : StepCentral
    {
        private LogFileSplitParams<string, string> _paramFileSplitParams;
        private LogFileSplitParams<int, int> _paramFileIntSplitParams;
        private IEnumerable<LogFileSplitParams<int, int>> _paramFileIntSplitParamsSet;

        [Given(@"I have the following log file splitter parameters:-")]
        public void GivenIHaveTheFollowingLogFileSplitterParameters(Table table)
        {
            _paramFileSplitParams = table.LogFileSplitParametersTransform();
            _paramFileSplitParams.OutputFile = ScenarioOutputDirectory + _paramFileSplitParams.OutputFile;
        }

        [Given(@"I have the following log file splitter parameters by line number:-")]
        public void GivenIHaveTheFollowingLogFileSplitterParametersByLineNumber(Table table)
        {
            _paramFileIntSplitParams = table.LogFileSplitIntParametersTransform();
            _paramFileIntSplitParams.OutputFile = ScenarioOutputDirectory + _paramFileIntSplitParams.OutputFile;
        }

        [Given(@"I have the following log file splitter parameter sets by line number:-")]
        public void GivenIHaveTheFollowingLogFileSplitterParameterSetsByLineNumber_(Table table)
        {
            _paramFileIntSplitParamsSet = table.LogFileSplitIntParameterSetTransform();
            foreach (var logFileSplitParams in _paramFileIntSplitParamsSet)
            {
                logFileSplitParams.OutputFile = ScenarioOutputDirectory + logFileSplitParams.OutputFile;
            }
        }

        [When(@"I split the log file by row numbers into files")]
        public void WhenISplitTheLogFileByRowNumbersIntoFiles()
        {
            foreach (var logFileSplitParams in _paramFileIntSplitParamsSet)
            {
                logFileSplitParams.CreateLogFileExtract();
            }
        }

        
        [When(@"I split the log file")]
        public void WhenISplitTheLogFile()
        {
            _paramFileSplitParams.CreateLogFileExtract();
        }

        [When(@"I split the log file by row numbers")]
        public void WhenISplitTheLogFileByRowNumbers()
        {
            _paramFileIntSplitParams.CreateLogFileExtract();
        }

    }
}
