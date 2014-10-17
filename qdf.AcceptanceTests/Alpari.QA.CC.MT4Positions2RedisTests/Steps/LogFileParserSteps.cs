using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using TechTalk.SpecFlow;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class LogFileParserSteps
    {
        private LogFileParserParameters LogFileParserParameters { get; set; }

        [Given(@"I have the following log file parser parameters:-")]
        public void GivenIHaveTheFollowingLogFileParserParameters(LogFileParserParameters logFileParserParameters)
        {
            LogFileParserParameters = logFileParserParameters;
        }

        [When(@"I parse the log file")]
        public void WhenIParseTheLogFile()
        {
            LogFileParserParameters.ParseLogFileToFile();
        }

        [When(@"I parse the log file to memory")]
        public void WhenIParseTheLogFileToMemory()
        {
            var logFile = LogFileParserParameters.ParseLogFileToMemory<Mt4P2RLogEntry>();
            // need to do more transformation first logFile.EnumerableToLineGraph(new EnumerableToGraphExtensions.DataSeriesParameters(), );
        }

    }
}
