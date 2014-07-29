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
namespace Alpari.QA.Six06Console.Tests.Specs
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.9.0.77")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("UKUSQDF-156AutomateTestingOfSix06ConsoleApp")]
    [NUnit.Framework.CategoryAttribute("UKUSQDF_156")]
    public partial class UKUSQDF_156AutomateTestingOfSix06ConsoleAppFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "UKUSQDF-156 Test the 606point5 Console Application.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-GB"), "UKUSQDF-156AutomateTestingOfSix06ConsoleApp", "In order to provide a log of auto hedged trades\r\nAs a QDF Analyst\r\nI want to be a" +
                    "ble to view autohedged trades copied from QDF database and inserted into MT5", ProgrammingLanguage.CSharp, new string[] {
                        "UKUSQDF_156"});
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
        
        public virtual void FeatureBackground()
        {
#line 7
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "FileName",
                        "UseShellExecute",
                        "RedirectStandardError",
                        "RedirectStandardInput",
                        "RedirectStandardOutput",
                        "CreateNoWindow"});
            table1.AddRow(new string[] {
                        "AUT\\QDF\\606.5Console\\606.5Console.exe",
                        "false",
                        "true",
                        "true",
                        "false",
                        "true"});
#line 8
 testRunner.Given("I have the following process parameters", ((string)(null)), table1, "Given ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Launch 606.5Console and check deals against stored proc results")]
        public virtual void Launch606_5ConsoleAndCheckDealsAgainstStoredProcResults()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Launch 606.5Console and check deals against stored proc results", ((string[])(null)));
#line 12
this.ScenarioSetup(scenarioInfo);
#line 7
this.FeatureBackground();
#line 13
 testRunner.When("I call QDF.GetAutoTradeswithEventID with ID 0 and save the result as a datatable", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 14
 testRunner.And("I launch the process and parse the order events from the console into orders and " +
                    "deals", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 15
 testRunner.Then("the order Event ID to deal mapping dictionary contains all the deals returned by " +
                    "QDF.GetAutoTradeswithEventID", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion