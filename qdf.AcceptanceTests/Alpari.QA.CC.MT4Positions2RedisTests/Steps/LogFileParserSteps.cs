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
        private List<LogEntryStatisticalAnalysis> _stats;
        private LogFileParserParameters LogFileParserParameters { get; set; }

        [Given(@"I have the following log file parser parameters:-")]
        public void GivenIHaveTheFollowingLogFileParserParameters(LogFileParserParameters logFileParserParameters)
        {
            LogFileParserParameters = logFileParserParameters;
            LogFileParserParameters.OutputFile = ScenarioOutputDirectory + LogFileParserParameters.OutputFile;
        }

        [Given(@"I have the following split log file parser parameters:-")]
        public void GivenIHaveTheFollowingSplitLogFileParserParameters(LogFileParserParameters logFileParserParameters)
        {
            logFileParserParameters.FileToParse = ScenarioOutputDirectory + logFileParserParameters.FileToParse;
            GivenIHaveTheFollowingLogFileParserParameters(logFileParserParameters);
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
        }

        [When(@"I analyze the log file by activity frequency")]
        public void WhenIAnalyzeTheLogFileByActivityFrequency()
        {
            _mt4P2RLogEntryAnalysisList = _logEntries.AnalyseActionsByFrequency();
        }

        [When(@"I output the log file frequency analysis")]
        public void WhenIOutputTheLogFileFrequencyAnalysis()
        {
            _mt4P2RLogEntryAnalysisList.EnumerableToCsv(ScenarioOutputDirectory + "FrequencyAnalysis." + CsvParserExtensionMethods.csv,false);
        }

        [When(@"I generate statistics about the frequency analysis")]
        public void WhenIGenerateStatisticsAboutTheFrequencyAnalysis()
        {
            _stats = _mt4P2RLogEntryAnalysisList.GenerateStatisics();
        }

        [When(@"I output the frequency analysis statistics")]
        public void WhenIOutputTheFrequencyAnalysisStatistics()
        {
            _stats.EnumerableToCsv(ScenarioOutputDirectory + "StatisticalAnalysis." + CsvParserExtensionMethods.csv,false);
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