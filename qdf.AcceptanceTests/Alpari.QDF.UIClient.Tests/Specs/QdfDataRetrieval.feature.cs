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
namespace Alpari.QDF.UIClient.Tests.Specs
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.9.0.77")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("QdfDataRetrieval")]
    [NUnit.Framework.CategoryAttribute("UKUSQDF_60")]
    [NUnit.Framework.CategoryAttribute("ClientSideFiltering")]
    [NUnit.Framework.CategoryAttribute("TeardownRedisConnection")]
    public partial class QdfDataRetrievalFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "QdfDataRetrieval.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-GB"), "QdfDataRetrieval", "In order to access deal data in Redis QDF\r\nAs a QDF Analyst\r\nI want a UI to retri" +
                    "eve and filter deal data", ProgrammingLanguage.CSharp, new string[] {
                        "UKUSQDF_60",
                        "ClientSideFiltering",
                        "TeardownRedisConnection"});
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
        [NUnit.Framework.DescriptionAttribute("Filter deals by date")]
        public virtual void FilterDealsByDate()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Filter deals by date", ((string[])(null)));
#line 11
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table1.AddRow(new string[] {
                        "05/05/2014  12:45:42",
                        "05/05/2014  12:49:51"});
#line 12
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table1, "Given ");
#line 15
 testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 16
 testRunner.Then("no retrieved deal will have a timestamp outside \"05/05/2014  12:45:42\" to \"05/05/" +
                    "2014  12:49:51\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line 17
 testRunner.And("the count of retrieved deals will be 113", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 18
 testRunner.And("the total of retrieved deals will be 113", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Filter deals by server")]
        public virtual void FilterDealsByServer()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Filter deals by server", ((string[])(null)));
#line 20
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "Server",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table2.AddRow(new string[] {
                        "Mt4Micro2",
                        "05/05/2014  12:45:42",
                        "05/05/2014  12:49:51"});
#line 21
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table2, "Given ");
#line 24
 testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 25
 testRunner.Then("all retrieved deals will have be for server \"Mt4Micro2\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line 26
 testRunner.And("the count of retrieved deals will be 13", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Filter deals by multiple servers")]
        public virtual void FilterDealsByMultipleServers()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Filter deals by multiple servers", ((string[])(null)));
#line 28
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "Servers",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table3.AddRow(new string[] {
                        "Mt4Micro2,Mt4Classic1,Mt4Market1",
                        "05/05/2014  12:45:42",
                        "05/05/2014  12:49:51"});
#line 29
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table3, "Given ");
#line 32
 testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "Server",
                        "Count"});
            table4.AddRow(new string[] {
                        "Mt4Micro2",
                        "13"});
            table4.AddRow(new string[] {
                        "Mt4Classic1",
                        "2"});
            table4.AddRow(new string[] {
                        "Mt4Market1",
                        "2"});
#line 33
 testRunner.Then("the deals retrieved for each server will have the following counts", ((string)(null)), table4, "Then ");
#line 38
 testRunner.And("the count of retrieved deals will be 17", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Filter deals by symbol")]
        public virtual void FilterDealsBySymbol()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Filter deals by symbol", ((string[])(null)));
#line 40
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "Symbol",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table5.AddRow(new string[] {
                        "EURUSD",
                        "05/05/2014  12:45:42",
                        "05/05/2014  12:49:51"});
#line 41
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table5, "Given ");
#line 44
 testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 45
 testRunner.Then("all retrieved deals will have be for symbol \"EURUSD\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line 46
 testRunner.And("the count of retrieved deals will be 33", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Filter deals by multiple symbols")]
        public virtual void FilterDealsByMultipleSymbols()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Filter deals by multiple symbols", ((string[])(null)));
#line 48
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "Symbol",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table6.AddRow(new string[] {
                        "EURUSD,NZDUSD,AUDNZD",
                        "05/05/2014  12:45:42",
                        "05/05/2014  12:49:51"});
#line 49
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table6, "Given ");
#line 52
 testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "Symbol",
                        "Count"});
            table7.AddRow(new string[] {
                        "EURUSD",
                        "33"});
            table7.AddRow(new string[] {
                        "NZDUSD",
                        "4"});
            table7.AddRow(new string[] {
                        "AUDNZD",
                        "1"});
#line 53
 testRunner.Then("the deals retrieved for each symbol will have the following counts", ((string)(null)), table7, "Then ");
#line 58
 testRunner.And("the count of retrieved deals will be 38", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Filter deals by book A")]
        public virtual void FilterDealsByBookA()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Filter deals by book A", ((string[])(null)));
#line 60
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table8 = new TechTalk.SpecFlow.Table(new string[] {
                        "Book",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table8.AddRow(new string[] {
                        "A",
                        "05/05/2014  12:45:42",
                        "05/05/2014  12:49:51"});
#line 61
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table8, "Given ");
#line 64
 testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 65
 testRunner.Then("all retrieved deals will have be for book \"A\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line 66
 testRunner.And("the count of retrieved deals will be 33", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Filter deals by book B")]
        public virtual void FilterDealsByBookB()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Filter deals by book B", ((string[])(null)));
#line 68
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table9 = new TechTalk.SpecFlow.Table(new string[] {
                        "Book",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table9.AddRow(new string[] {
                        "B",
                        "05/05/2014  12:45:42",
                        "05/05/2014  12:49:51"});
#line 69
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table9, "Given ");
#line 72
 testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 73
 testRunner.Then("all retrieved deals will have be for book \"B\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line 74
 testRunner.And("the count of retrieved deals will be 80", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Filter deals by book symbol and server")]
        public virtual void FilterDealsByBookSymbolAndServer()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Filter deals by book symbol and server", ((string[])(null)));
#line 76
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table10 = new TechTalk.SpecFlow.Table(new string[] {
                        "Book",
                        "Symbol",
                        "Server",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table10.AddRow(new string[] {
                        "B",
                        "EURUSD",
                        "Mt4Classic2",
                        "05/05/2014  12:45:42",
                        "05/05/2014  12:49:51"});
#line 77
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table10, "Given ");
#line 80
 testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 81
 testRunner.Then("all retrieved deals will have be for book \"B\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line 82
 testRunner.And("all retrieved deals will have be for symbol \"EURUSD\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 83
 testRunner.And("all retrieved deals will have be for server \"Mt4Classic2\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 84
 testRunner.And("the count of retrieved deals will be 4", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Filter deals by multiple symbols and servers")]
        public virtual void FilterDealsByMultipleSymbolsAndServers()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Filter deals by multiple symbols and servers", ((string[])(null)));
#line 86
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table11 = new TechTalk.SpecFlow.Table(new string[] {
                        "Symbol",
                        "Servers",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table11.AddRow(new string[] {
                        "EURUSD,GBPUSD,AUDJPY",
                        "Currenex,Mt5Pro,Mt4JapaneseC1",
                        "05/05/2014  12:45:42",
                        "05/05/2014  12:49:51"});
#line 87
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table11, "Given ");
#line 90
 testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table12 = new TechTalk.SpecFlow.Table(new string[] {
                        "Symbol",
                        "Count"});
            table12.AddRow(new string[] {
                        "EURUSD",
                        "16"});
            table12.AddRow(new string[] {
                        "GBPUSD",
                        "2"});
            table12.AddRow(new string[] {
                        "AUDJPY",
                        "1"});
#line 91
 testRunner.Then("the deals retrieved for each symbol will have the following counts", ((string)(null)), table12, "Then ");
#line hidden
            TechTalk.SpecFlow.Table table13 = new TechTalk.SpecFlow.Table(new string[] {
                        "Server",
                        "Count"});
            table13.AddRow(new string[] {
                        "Mt4JapaneseC1",
                        "12"});
            table13.AddRow(new string[] {
                        "Currenex",
                        "5"});
            table13.AddRow(new string[] {
                        "Mt5Pro",
                        "2"});
#line 96
 testRunner.Then("the deals retrieved for each server will have the following counts", ((string)(null)), table13, "Then ");
#line 101
 testRunner.And("the count of retrieved deals will be 19", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Filter deals by multiple symbols and servers and B Book")]
        public virtual void FilterDealsByMultipleSymbolsAndServersAndBBook()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Filter deals by multiple symbols and servers and B Book", ((string[])(null)));
#line 103
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table14 = new TechTalk.SpecFlow.Table(new string[] {
                        "Book",
                        "Symbol",
                        "Servers",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table14.AddRow(new string[] {
                        "B",
                        "EURUSD,GBPUSD,AUDJPY,USDCHF",
                        "Currenex,Mt5Pro,Mt4JapaneseC1",
                        "05/05/2014  12:45:42",
                        "05/05/2014  12:49:51"});
#line 104
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table14, "Given ");
#line 107
 testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table15 = new TechTalk.SpecFlow.Table(new string[] {
                        "Symbol",
                        "Count"});
            table15.AddRow(new string[] {
                        "EURUSD",
                        "16"});
            table15.AddRow(new string[] {
                        "GBPUSD",
                        "2"});
            table15.AddRow(new string[] {
                        "AUDJPY",
                        "1"});
            table15.AddRow(new string[] {
                        "USDCHF",
                        "2"});
#line 108
 testRunner.Then("the deals retrieved for each symbol will have the following counts", ((string)(null)), table15, "Then ");
#line hidden
            TechTalk.SpecFlow.Table table16 = new TechTalk.SpecFlow.Table(new string[] {
                        "Server",
                        "Count"});
            table16.AddRow(new string[] {
                        "Mt4JapaneseC1",
                        "12"});
            table16.AddRow(new string[] {
                        "Currenex",
                        "5"});
            table16.AddRow(new string[] {
                        "Mt5Pro",
                        "4"});
#line 114
 testRunner.Then("the deals retrieved for each server will have the following counts", ((string)(null)), table16, "Then ");
#line 119
 testRunner.And("the count of retrieved deals will be 21", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Filter deals by multiple symbols and servers and A Book")]
        public virtual void FilterDealsByMultipleSymbolsAndServersAndABook()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Filter deals by multiple symbols and servers and A Book", ((string[])(null)));
#line 121
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table17 = new TechTalk.SpecFlow.Table(new string[] {
                        "Book",
                        "Symbol",
                        "Servers",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table17.AddRow(new string[] {
                        "A",
                        "EURUSD,GBPUSD,AUDJPY,USDCHF",
                        "Currenex,Mt5Pro,Mt4JapaneseC1",
                        "05/05/2014  12:45:42",
                        "05/05/2014  12:49:51"});
#line 122
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table17, "Given ");
#line 125
 testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table18 = new TechTalk.SpecFlow.Table(new string[] {
                        "Symbol",
                        "Count"});
            table18.AddRow(new string[] {
                        "USDCHF",
                        "2"});
#line 126
 testRunner.Then("the deals retrieved for each symbol will have the following counts", ((string)(null)), table18, "Then ");
#line hidden
            TechTalk.SpecFlow.Table table19 = new TechTalk.SpecFlow.Table(new string[] {
                        "Server",
                        "Count"});
            table19.AddRow(new string[] {
                        "Mt5Pro",
                        "2"});
#line 129
 testRunner.Then("the deals retrieved for each server will have the following counts", ((string)(null)), table19, "Then ");
#line 132
 testRunner.And("the count of retrieved deals will be 2", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
