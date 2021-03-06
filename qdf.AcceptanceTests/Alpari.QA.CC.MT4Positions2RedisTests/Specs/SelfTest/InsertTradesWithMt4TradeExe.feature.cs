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
namespace Alpari.QA.CC.MT4Positions2RedisTests.Specs.SelfTest
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.9.0.77")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("InsertTradesWithMt4TradeExe")]
    public partial class InsertTradesWithMt4TradeExeFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "InsertTradesWithMt4TradeExe.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-GB"), "InsertTradesWithMt4TradeExe", "In order to create open positions in MT4\r\nAs a CC Tester\r\nI want to Bulk Insert t" +
                    "rades to MT4", ProgrammingLanguage.CSharp, ((string[])(null)));
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
        [NUnit.Framework.DescriptionAttribute("Launch MT4Trade.exe")]
        public virtual void LaunchMT4Trade_Exe()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Launch MT4Trade.exe", ((string[])(null)));
#line 6
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "FileName",
                        "Arguments",
                        "UseShellExecute",
                        "RedirectStandardError",
                        "RedirectStandardInput",
                        "RedirectStandardOutput",
                        "CreateNoWindow"});
            table1.AddRow(new string[] {
                        "AUT\\MT4Trade\\MT4Trade.exe",
                        "-s 10.10.144.25:443 -u 7003906 -p Trader",
                        "false",
                        "true",
                        "true",
                        "true",
                        "true"});
#line 7
 testRunner.Given("I have these parameters for MT4Trade:-", ((string)(null)), table1, "Given ");
#line 10
 testRunner.When("I launch MT4Trade", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 11
 testRunner.And("I send string \"buy volume=345 symbol=EURUSD price=1.5\" to MT4Trade", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 12
 testRunner.And("I send string \"buy volume=345 symbol=EURUSD price=1.5\" to MT4Trade", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 13
 testRunner.And("I send string \"buy volume=345 symbol=EURUSD price=1.5\" to MT4Trade", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 14
 testRunner.And("I send string \"buy volume=345 symbol=EURUSD price=1.5\" to MT4Trade", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 16
 testRunner.When("I send string \"exit\" to MT4Trade", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 17
 testRunner.Then("MT4Trade output contains \"opened\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line 18
 testRunner.Then("MT4Trade output contains \"Press Ctrl+C to exit\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Launch MT4Trade.exe and bulk load identical trades")]
        public virtual void LaunchMT4Trade_ExeAndBulkLoadIdenticalTrades()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Launch MT4Trade.exe and bulk load identical trades", ((string[])(null)));
#line 39
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "FileName",
                        "Arguments",
                        "UseShellExecute",
                        "RedirectStandardError",
                        "RedirectStandardInput",
                        "RedirectStandardOutput",
                        "CreateNoWindow"});
            table2.AddRow(new string[] {
                        "AUT\\MT4Trade\\MT4Trade.exe",
                        "-s 10.10.144.25:443 -u 7003906 -p Trader",
                        "false",
                        "true",
                        "true",
                        "true",
                        "true"});
#line 40
 testRunner.Given("I have these parameters for MT4Trade:-", ((string)(null)), table2, "Given ");
#line 43
 testRunner.When("I launch MT4Trade", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 44
 testRunner.And("I load 100 trades with these parameters \"buy volume=345 symbol=EURUSD price=1.5\" " +
                    "with MT4Trade", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 46
 testRunner.When("I send string \"exit\" to MT4Trade", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 47
 testRunner.Then("MT4Trade output contains \"opened\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line 48
 testRunner.Then("MT4Trade output contains \"Press Ctrl+C to exit\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
