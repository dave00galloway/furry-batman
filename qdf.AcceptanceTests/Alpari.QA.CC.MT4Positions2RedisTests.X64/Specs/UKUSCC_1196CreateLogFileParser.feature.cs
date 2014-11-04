﻿// ------------------------------------------------------------------------------
//  <auto-generated>
//      This code was generated by SpecFlow (http://www.specflow.org/).
//      SpecFlow Version:1.9.0.77
//      SpecFlow Generator Version:1.9.0.0
//      Runtime Version:4.0.30319.18444
// 
//      Changes to this file may cause incorrect behavior and will be lost if
//      the code is regenerated.
//  </auto-generated>
// ------------------------------------------------------------------------------
#region Designer generated code
#pragma warning disable
namespace Alpari.QA.CC.MT4Positions2RedisTests.X64.Specs
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.9.0.77")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("UKUSCC_1196CreateLogFileParser")]
    [NUnit.Framework.CategoryAttribute("UKUSCC_1196")]
    public partial class UKUSCC_1196CreateLogFileParserFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "UKUSCC_1196CreateLogFileParser.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-GB"), "UKUSCC_1196CreateLogFileParser", "In order to interpret log files from the positions 2 Redis service\r\nAs a CC teste" +
                    "r\r\nI want to be able to parse the service log and interpret the results", ProgrammingLanguage.CSharp, new string[] {
                        "UKUSCC_1196"});
            testRunner.OnFeatureStart(featureInfo);
        }
        
        [NUnit.Framework.TestFixtureTearDownAttribute()]
        public virtual void FeatureTearDown()
        {
            testRunner.OnFeatureEnd();
            testRunner = null;
        }
        
        [NUnit.Framework.SetUpAttribute()]
        public virtual void TestInitialize()
        {
        }
        
        [NUnit.Framework.TearDownAttribute()]
        public virtual void ScenarioTearDown()
        {
            testRunner.OnScenarioEnd();
        }
        
        public virtual void ScenarioSetup(TechTalk.SpecFlow.ScenarioInfo scenarioInfo)
        {
            testRunner.OnScenarioStart(scenarioInfo);
        }
        
        public virtual void ScenarioCleanup()
        {
            testRunner.CollectScenarioErrors();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Cleanse log file extract")]
        public virtual void CleanseLogFileExtract()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Cleanse log file extract", ((string[])(null)));
#line 7
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "parseSyntax",
                        "OuterSyntaxDelimiter",
                        "InnerSyntaxDelimiter",
                        "outputfile"});
            table1.AddRow(new string[] {
                        "TestData\\LogFileTests\\Build56_Service_Log_extract.log",
                        "[,1,,0, ,^],1,,0, ,^ ,0,U_TRANS,2, ,",
                        "^",
                        ",",
                        "TestOutput\\output.csv"});
#line 8
 testRunner.Given("I have the following log file parser parameters:-", ((string)(null)), table1, "Given ");
#line 12
 testRunner.When("I parse the log file", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Parse log file extract")]
        public virtual void ParseLogFileExtract()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Parse log file extract", ((string[])(null)));
#line 14
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "parseSyntax",
                        "ColumnJoins",
                        "OuputDelimiter",
                        "OuterSyntaxDelimiter",
                        "InnerSyntaxDelimiter",
                        "outputfile"});
            table2.AddRow(new string[] {
                        "TestData\\LogFileTests\\Build56_Service_Log_extract.log",
                        "[,1,,0, ,^],1,,0, ,^ ,0,U_TRANS,2, ,",
                        "",
                        ",",
                        "^",
                        ",",
                        "output.csv"});
#line 15
 testRunner.Given("I have the following log file parser parameters:-", ((string)(null)), table2, "Given ");
#line 19
 testRunner.When("I parse the log file to memory", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 20
 testRunner.And("I write the parsed log file to disk", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Parse log extended file extract")]
        public virtual void ParseLogExtendedFileExtract()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Parse log extended file extract", ((string[])(null)));
#line 22
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "parseSyntax",
                        "ColumnJoins",
                        "OuputDelimiter",
                        "OuterSyntaxDelimiter",
                        "InnerSyntaxDelimiter",
                        "outputfile"});
            table3.AddRow(new string[] {
                        "TestData\\LogFileTests\\Build56_Service_Log_extract_extended.log",
                        "[,1,,0, ,^],1,,0, ,^ ,0,U_,2, ,",
                        "",
                        ",",
                        "^",
                        ",",
                        "output.csv"});
#line 23
 testRunner.Given("I have the following log file parser parameters:-", ((string)(null)), table3, "Given ");
#line 27
 testRunner.When("I parse the log file to memory", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 28
 testRunner.And("I analyze the log file by activity frequency", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 29
 testRunner.And("I output the log file frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 30
 testRunner.And("I generate statistics about the frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 31
 testRunner.And("I output the frequency analysis statistics", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "TimeStamp",
                        "U_INIT",
                        "U_TRANS_ADD",
                        "U_TRANS_DELETE",
                        "U_TRANS_UPDATE"});
            table4.AddRow(new string[] {
                        "16/10/2014 17:03:22",
                        "2",
                        "2",
                        "2",
                        "4"});
            table4.AddRow(new string[] {
                        "16/10/2014 17:03:23",
                        "2",
                        "1",
                        "2",
                        "3"});
            table4.AddRow(new string[] {
                        "16/10/2014 17:03:24",
                        "1",
                        "2",
                        "2",
                        "4"});
            table4.AddRow(new string[] {
                        "16/10/2014 17:03:25",
                        "2",
                        "2",
                        "2",
                        "4"});
#line 32
 testRunner.Then("the mt4P2RLogEntryAnalysisList has the following entries:-", ((string)(null)), table4, "Then ");
#line 38
 testRunner.And("I can export the the analysis as a line graph", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Parse log extended file extract and export to graph")]
        public virtual void ParseLogExtendedFileExtractAndExportToGraph()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Parse log extended file extract and export to graph", ((string[])(null)));
#line 40
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "parseSyntax",
                        "ColumnJoins",
                        "OuputDelimiter",
                        "OuterSyntaxDelimiter",
                        "InnerSyntaxDelimiter",
                        "outputfile"});
            table5.AddRow(new string[] {
                        "TestData\\LogFileTests\\Build56_Service_Log_extract_extended.log",
                        "[,1,,0, ,^],1,,0, ,^ ,0,U_,2, ,",
                        "",
                        ",",
                        "^",
                        ",",
                        "output.csv"});
#line 41
 testRunner.Given("I have the following log file parser parameters:-", ((string)(null)), table5, "Given ");
#line 45
 testRunner.When("I parse the log file to memory", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 46
 testRunner.And("I analyze the log file by activity frequency", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 47
 testRunner.Then("I can export the the analysis as a line graph", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Cleanse log file")]
        public virtual void CleanseLogFile()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Cleanse log file", ((string[])(null)));
#line 51
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "parseSyntax",
                        "OuterSyntaxDelimiter",
                        "InnerSyntaxDelimiter",
                        "outputfile"});
            table6.AddRow(new string[] {
                        "C:\\TEMP\\MT4P2R_Build73_10_10_144_25_443_2014-10-29.log",
                        "[,1,,0, ,^],1,,0, ,^ ,0,U_,2, ,",
                        "^",
                        ",",
                        "MT4P2R_Build73_10_10_144_25_443_2014-10-29.log_parsed.log"});
#line 52
 testRunner.Given("I have the following log file parser parameters:-", ((string)(null)), table6, "Given ");
#line 56
 testRunner.When("I parse the log file", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Parse log file and export to graph 1")]
        public virtual void ParseLogFileAndExportToGraph1()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Parse log file and export to graph 1", ((string[])(null)));
#line 72
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "parseSyntax",
                        "ColumnJoins",
                        "OuputDelimiter",
                        "OuterSyntaxDelimiter",
                        "InnerSyntaxDelimiter",
                        "outputfile"});
            table7.AddRow(new string[] {
                        "C:\\Reports\\20141031110428277\\UKUSCC_1206LogFileSplitter\\SplitanotherlogfileByrown" +
                            "umbersintomultiplelogfiles\\extract1.log",
                        "[,1,,0, ,^],1,,0, ,^ ,0,U_,2, ,",
                        "",
                        ",",
                        "^",
                        ",",
                        "MT4P2R_build73_10_10_144_25_443_2014-10-29_parsed1.log"});
#line 73
 testRunner.Given("I have the following log file parser parameters:-", ((string)(null)), table7, "Given ");
#line 77
 testRunner.When("I parse the log file to memory", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 78
 testRunner.And("I write the parsed log file to disk", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 79
 testRunner.And("I analyze the log file by activity frequency", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 80
 testRunner.And("I output the log file frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 81
 testRunner.And("I generate statistics about the frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 82
 testRunner.And("I output the frequency analysis statistics", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 83
 testRunner.Then("I can export the the analysis as a line graph", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Parse log file and export to graph 2")]
        public virtual void ParseLogFileAndExportToGraph2()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Parse log file and export to graph 2", ((string[])(null)));
#line 86
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table8 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "parseSyntax",
                        "ColumnJoins",
                        "OuputDelimiter",
                        "OuterSyntaxDelimiter",
                        "InnerSyntaxDelimiter",
                        "outputfile"});
            table8.AddRow(new string[] {
                        "C:\\Reports\\20141031110428277\\UKUSCC_1206LogFileSplitter\\SplitanotherlogfileByrown" +
                            "umbersintomultiplelogfiles\\extract2.log",
                        "[,1,,0, ,^],1,,0, ,^ ,0,U_,2, ,",
                        "",
                        ",",
                        "^",
                        ",",
                        "MT4P2R_build73_10_10_144_25_443_2014-10-29_parsed2.log"});
#line 87
 testRunner.Given("I have the following log file parser parameters:-", ((string)(null)), table8, "Given ");
#line 91
 testRunner.When("I parse the log file to memory", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 92
 testRunner.And("I write the parsed log file to disk", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 93
 testRunner.And("I analyze the log file by activity frequency", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 94
 testRunner.And("I output the log file frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 95
 testRunner.And("I generate statistics about the frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 96
 testRunner.And("I output the frequency analysis statistics", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 97
 testRunner.Then("I can export the the analysis as a line graph", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Parse log file and export to graph 3")]
        public virtual void ParseLogFileAndExportToGraph3()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Parse log file and export to graph 3", ((string[])(null)));
#line 100
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table9 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "parseSyntax",
                        "ColumnJoins",
                        "OuputDelimiter",
                        "OuterSyntaxDelimiter",
                        "InnerSyntaxDelimiter",
                        "outputfile"});
            table9.AddRow(new string[] {
                        "C:\\Reports\\20141031110428277\\UKUSCC_1206LogFileSplitter\\SplitanotherlogfileByrown" +
                            "umbersintomultiplelogfiles\\extract3.log",
                        "[,1,,0, ,^],1,,0, ,^ ,0,U_,2, ,",
                        "",
                        ",",
                        "^",
                        ",",
                        "MT4P2R_build73_10_10_144_25_443_2014-10-29_parsed3.log"});
#line 101
 testRunner.Given("I have the following log file parser parameters:-", ((string)(null)), table9, "Given ");
#line 105
 testRunner.When("I parse the log file to memory", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 106
 testRunner.And("I write the parsed log file to disk", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 107
 testRunner.And("I analyze the log file by activity frequency", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 108
 testRunner.And("I output the log file frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 109
 testRunner.And("I generate statistics about the frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 110
 testRunner.And("I output the frequency analysis statistics", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 111
 testRunner.Then("I can export the the analysis as a line graph", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Parse log file and export to graph 4")]
        public virtual void ParseLogFileAndExportToGraph4()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Parse log file and export to graph 4", ((string[])(null)));
#line 114
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table10 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "parseSyntax",
                        "ColumnJoins",
                        "OuputDelimiter",
                        "OuterSyntaxDelimiter",
                        "InnerSyntaxDelimiter",
                        "outputfile"});
            table10.AddRow(new string[] {
                        "C:\\Reports\\20141031110428277\\UKUSCC_1206LogFileSplitter\\SplitanotherlogfileByrown" +
                            "umbersintomultiplelogfiles\\extract4.log",
                        "[,1,,0, ,^],1,,0, ,^ ,0,U_,2, ,",
                        "",
                        ",",
                        "^",
                        ",",
                        "MT4P2R_build73_10_10_144_25_443_2014-10-29_parsed4.log"});
#line 115
 testRunner.Given("I have the following log file parser parameters:-", ((string)(null)), table10, "Given ");
#line 119
 testRunner.When("I parse the log file to memory", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 120
 testRunner.And("I write the parsed log file to disk", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 121
 testRunner.And("I analyze the log file by activity frequency", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 122
 testRunner.And("I output the log file frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 123
 testRunner.And("I generate statistics about the frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 124
 testRunner.And("I output the frequency analysis statistics", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 125
 testRunner.Then("I can export the the analysis as a line graph", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Parse log file and export to graph 5")]
        public virtual void ParseLogFileAndExportToGraph5()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Parse log file and export to graph 5", ((string[])(null)));
#line 127
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table11 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "parseSyntax",
                        "ColumnJoins",
                        "OuputDelimiter",
                        "OuterSyntaxDelimiter",
                        "InnerSyntaxDelimiter",
                        "outputfile"});
            table11.AddRow(new string[] {
                        "C:\\Reports\\20141031110428277\\UKUSCC_1206LogFileSplitter\\SplitanotherlogfileByrown" +
                            "umbersintomultiplelogfiles\\extract5.log",
                        "[,1,,0, ,^],1,,0, ,^ ,0,U_,2, ,",
                        "",
                        ",",
                        "^",
                        ",",
                        "MT4P2R_build73_10_10_144_25_443_2014-10-29_parsed5.log"});
#line 128
 testRunner.Given("I have the following log file parser parameters:-", ((string)(null)), table11, "Given ");
#line 132
 testRunner.When("I parse the log file to memory", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 133
 testRunner.And("I write the parsed log file to disk", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 134
 testRunner.And("I analyze the log file by activity frequency", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 135
 testRunner.And("I output the log file frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 136
 testRunner.And("I generate statistics about the frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 137
 testRunner.And("I output the frequency analysis statistics", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 138
 testRunner.Then("I can export the the analysis as a line graph", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
