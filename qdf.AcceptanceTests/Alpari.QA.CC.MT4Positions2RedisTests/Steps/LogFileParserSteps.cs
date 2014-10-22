using System;
using System.Collections.Generic;
using System.Windows.Forms.DataVisualization.Charting;
using Alpari.QA.CC.MT4Positions2RedisTests.Helpers;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;
using FluentAssertions;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Steps
{
    [Binding]
    public class LogFileParserSteps : StepCentral
    {
        private List<Mt4P2RLogEntry> _logEntries;
        private List<Mt4P2RLogEntryAnalysis> _mt4P2RLogEntryAnalysisList;
        private LogFileParserParameters LogFileParserParameters { get; set; }

        [Given(@"I have the following log file parser parameters:-")]
        public void GivenIHaveTheFollowingLogFileParserParameters(LogFileParserParameters logFileParserParameters)
        {
            LogFileParserParameters = logFileParserParameters;
            LogFileParserParameters.OutputFile = ScenarioOutputDirectory + LogFileParserParameters.OutputFile;
        }

        [When(@"I parse the log file")]
        public void WhenIParseTheLogFile()
        {
            LogFileParserParameters.ParseLogFileToFile();
        }

        [When(@"I parse the log file to memory")]
        public void WhenIParseTheLogFileToMemory()
        {
            _logEntries = LogFileParserParameters.ParseLogFileToMemory<Mt4P2RLogEntry>();
            // need to do more transformation first logFile.EnumerableToLineGraph(new EnumerableToGraphExtensions.DataSeriesParameters(), );
            //Console.WriteLine(logFile.First().TimeStamp);
        }

        [When(@"I analyze the log file by activity frequency")]
        public void WhenIAnalyzeTheLogFileByActivityFrequency()
        {
            _mt4P2RLogEntryAnalysisList = _logEntries.AnalyseActionsByFrequency();
        }

        [When(@"I write the parsed log file to disk")]
        public void WhenIWriteTheParsedLogFileToDisk()
        {
            _logEntries.EnumerableToCsv(LogFileParserParameters.OutputFile, false, true, false, false, true);
        }

        [Then(@"the mt4P2RLogEntryAnalysisList has the following entries:-")]
        public void ThenTheMtRLogEntryAnalysisListHasTheFollowingEntries(Table expected)
        {
            expected.CompareToSet(_mt4P2RLogEntryAnalysisList);
        }

        [Then(@"I can export the the analysis as a line graph")]
        public void ThenICanExportTheTheAnalysisAsALineGraph()
        {
            Exception e = null;
            try
            {
                _mt4P2RLogEntryAnalysisList.CreateAnalysisGraph("Analysis", ScenarioOutputDirectory, 0);
            }
            catch (Exception exception)
            {
                e = exception;
            }
            e.Should().BeNull();
        }
    }
}