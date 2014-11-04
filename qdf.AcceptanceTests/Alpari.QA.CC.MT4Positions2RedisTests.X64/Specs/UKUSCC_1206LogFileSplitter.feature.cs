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
    [NUnit.Framework.DescriptionAttribute("UKUSCC_1206LogFileSplitter")]
    [NUnit.Framework.CategoryAttribute("UKUSCC_1206")]
    public partial class UKUSCC_1206LogFileSplitterFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "UKUSCC_1206LogFileSplitter.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-GB"), "UKUSCC_1206LogFileSplitter", "In order to analyse a log file for specific test runs\r\nAs a tester\r\nI want to spl" +
                    "it log files by timestamp", ProgrammingLanguage.CSharp, new string[] {
                        "UKUSCC_1206"});
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
        [NUnit.Framework.DescriptionAttribute("Split a log file")]
        public virtual void SplitALogFile()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Split a log file", ((string[])(null)));
#line 7
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "startAt",
                        "endAt",
                        "outputfile"});
            table1.AddRow(new string[] {
                        "TestData\\LogFileTests\\Build56_Service_Log_extract_extended.log",
                        "16/10/2014 17:03:22.951",
                        "16/10/2014 17:03:25.889",
                        "extract.log"});
#line 9
 testRunner.Given("I have the following log file splitter parameters:-", ((string)(null)), table1, "Given ");
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
                        "extract.log",
                        "[,1,,0, ,^],1,,0, ,^ ,0,U_,2, ,",
                        "",
                        ",",
                        "^",
                        ",",
                        "output.csv"});
#line 13
 testRunner.And("I have the following split log file parser parameters:-", ((string)(null)), table2, "And ");
#line 17
 testRunner.When("I split the log file", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 19
 testRunner.When("I parse the log file to memory", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 20
 testRunner.And("I analyze the log file by activity frequency", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 21
 testRunner.And("I output the log file frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 22
 testRunner.And("I generate statistics about the frequency analysis", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 23
 testRunner.And("I output the frequency analysis statistics", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "TimeStamp",
                        "U_INIT",
                        "U_TRANS_ADD",
                        "U_TRANS_DELETE",
                        "U_TRANS_UPDATE"});
            table3.AddRow(new string[] {
                        "16/10/2014 17:03:22",
                        "2",
                        "0",
                        "0",
                        "0"});
            table3.AddRow(new string[] {
                        "16/10/2014 17:03:23",
                        "2",
                        "1",
                        "2",
                        "3"});
            table3.AddRow(new string[] {
                        "16/10/2014 17:03:24",
                        "1",
                        "2",
                        "2",
                        "4"});
            table3.AddRow(new string[] {
                        "16/10/2014 17:03:25",
                        "0",
                        "0",
                        "0",
                        "1"});
#line 24
 testRunner.Then("the mt4P2RLogEntryAnalysisList has the following entries:-", ((string)(null)), table3, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Split another log file")]
        public virtual void SplitAnotherLogFile()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Split another log file", ((string[])(null)));
#line 32
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "startAt",
                        "endAt",
                        "outputfile"});
            table4.AddRow(new string[] {
                        "C:\\Temp\\MT4P2R_Build73_10_10_144_25_443_2014-10-29.log",
                        "29/10/2014 17:38:16.837",
                        "[29/10/2014 23:59:59.959] U_TRANS_UPDATE: 1000000563(#13455182) succeeded",
                        "extract.log"});
#line 34
 testRunner.Given("I have the following log file splitter parameters:-", ((string)(null)), table4, "Given ");
#line 38
 testRunner.When("I split the log file", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Split another log file By row numbers")]
        public virtual void SplitAnotherLogFileByRowNumbers()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Split another log file By row numbers", ((string[])(null)));
#line 43
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "startAt",
                        "endAt",
                        "outputfile"});
            table5.AddRow(new string[] {
                        "C:\\Reports\\20141030143800568\\UKUSCC_1230CombineLogFiles\\Concatenate2moreLogFiles\\" +
                            "OutputFile.log",
                        "0",
                        "1000000",
                        "extract.log"});
#line 45
 testRunner.Given("I have the following log file splitter parameters by line number:-", ((string)(null)), table5, "Given ");
#line 49
 testRunner.When("I split the log file by row numbers", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Split another log file By row numbers into multiple log files")]
        public virtual void SplitAnotherLogFileByRowNumbersIntoMultipleLogFiles()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Split another log file By row numbers into multiple log files", ((string[])(null)));
#line 51
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "fileToParse",
                        "startAt",
                        "endAt",
                        "outputfile"});
            table6.AddRow(new string[] {
                        "C:\\Reports\\20141030143800568\\UKUSCC_1230CombineLogFiles\\Concatenate2moreLogFiles\\" +
                            "OutputFile.log",
                        "0",
                        "2000000",
                        "extract1.log"});
            table6.AddRow(new string[] {
                        "C:\\Reports\\20141030143800568\\UKUSCC_1230CombineLogFiles\\Concatenate2moreLogFiles\\" +
                            "OutputFile.log",
                        "2000001",
                        "4000000",
                        "extract2.log"});
            table6.AddRow(new string[] {
                        "C:\\Reports\\20141030143800568\\UKUSCC_1230CombineLogFiles\\Concatenate2moreLogFiles\\" +
                            "OutputFile.log",
                        "4000001",
                        "6000000",
                        "extract3.log"});
            table6.AddRow(new string[] {
                        "C:\\Reports\\20141030143800568\\UKUSCC_1230CombineLogFiles\\Concatenate2moreLogFiles\\" +
                            "OutputFile.log",
                        "6000001",
                        "8000000",
                        "extract4.log"});
            table6.AddRow(new string[] {
                        "C:\\Reports\\20141030143800568\\UKUSCC_1230CombineLogFiles\\Concatenate2moreLogFiles\\" +
                            "OutputFile.log",
                        "8000001",
                        "10000000",
                        "extract5.log"});
#line 53
 testRunner.Given("I have the following log file splitter parameter sets by line number:-", ((string)(null)), table6, "Given ");
#line 63
 testRunner.When("I split the log file by row numbers into files", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
