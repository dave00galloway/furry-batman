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
namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Specs.SelfTest
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.9.0.77")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("CompareMySqlAndQdfCnxDeals")]
    [NUnit.Framework.CategoryAttribute("UKUSQDF_92")]
    [NUnit.Framework.CategoryAttribute("UKUSQDF_117")]
    [NUnit.Framework.CategoryAttribute("localhost")]
    [NUnit.Framework.CategoryAttribute("deal:cnx_deals:TestData\\cnx.csv")]
    public partial class CompareMySqlAndQdfCnxDealsFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "CompareMySqlAndQdfCnxDeals.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-GB"), "CompareMySqlAndQdfCnxDeals", "In order to test Cnx2Redis\r\nAs a QDF Tester\r\nI want to be able to compare data fr" +
                    "om MySql and Redis", ProgrammingLanguage.CSharp, new string[] {
                        "UKUSQDF_92",
                        "UKUSQDF_117",
                        "localhost",
                        "deal:cnx_deals:TestData\\cnx.csv"});
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
        [NUnit.Framework.DescriptionAttribute("Compare small range of deals where side is incorrect excluding known issues")]
        public virtual void CompareSmallRangeOfDealsWhereSideIsIncorrectExcludingKnownIssues()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare small range of deals where side is incorrect excluding known issues", ((string[])(null)));
#line 33
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "DealSource",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table1.AddRow(new string[] {
                        "cnx-deals",
                        "19/06/2014  17:36:00",
                        "19/06/2014  17:44:59"});
#line 34
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table1, "Given ");
#line 37
  testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "DealId"});
            table2.AddRow(new string[] {
                        "B201417005FFD00"});
            table2.AddRow(new string[] {
                        "B201417005FFN00"});
            table2.AddRow(new string[] {
                        "B201417005FFR00"});
            table2.AddRow(new string[] {
                        "B201417005FFU00"});
            table2.AddRow(new string[] {
                        "B201417005FFX00"});
            table2.AddRow(new string[] {
                        "B201417005FG000"});
            table2.AddRow(new string[] {
                        "B201417005FG300"});
            table2.AddRow(new string[] {
                        "B201417005FR400"});
            table2.AddRow(new string[] {
                        "B201417005FS100"});
            table2.AddRow(new string[] {
                        "B201417005FS400"});
            table2.AddRow(new string[] {
                        "B201417005FTC00"});
#line 38
  testRunner.And("I query cnx trade by trade id for these trade ids:", ((string)(null)), table2, "And ");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExcludedFields"});
            table3.AddRow(new string[] {
                        "OrderId"});
            table3.AddRow(new string[] {
                        "Side"});
#line 51
  testRunner.And("I compare the cnx trade deals with the qdf deal data excluding these fields:", ((string)(null)), table3, "And ");
#line 55
  testRunner.Then("the cnx trade deals should match the qdf deal data exactly", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare small range of deals where side is incorrect and find all expected record" +
            "s")]
        public virtual void CompareSmallRangeOfDealsWhereSideIsIncorrectAndFindAllExpectedRecords()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare small range of deals where side is incorrect and find all expected record" +
                    "s", ((string[])(null)));
#line 58
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "DealSource",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table4.AddRow(new string[] {
                        "cnx-deals",
                        "19/06/2014  17:36:00",
                        "19/06/2014  17:44:59"});
#line 59
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table4, "Given ");
#line 62
  testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "DealId"});
            table5.AddRow(new string[] {
                        "B201417005FFD00"});
            table5.AddRow(new string[] {
                        "B201417005FFN00"});
            table5.AddRow(new string[] {
                        "B201417005FFR00"});
            table5.AddRow(new string[] {
                        "B201417005FFU00"});
            table5.AddRow(new string[] {
                        "B201417005FFX00"});
            table5.AddRow(new string[] {
                        "B201417005FG000"});
            table5.AddRow(new string[] {
                        "B201417005FG300"});
            table5.AddRow(new string[] {
                        "B201417005FR400"});
            table5.AddRow(new string[] {
                        "B201417005FS100"});
            table5.AddRow(new string[] {
                        "B201417005FS400"});
            table5.AddRow(new string[] {
                        "B201417005FTC00"});
#line 63
  testRunner.And("I query cnx trade by trade id for these trade ids:", ((string)(null)), table5, "And ");
#line 76
  testRunner.And("I compare the cnx trade deals with the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 77
  testRunner.Then("the cnx trade deals should contain the same deals as the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare small range of deals by date time range")]
        public virtual void CompareSmallRangeOfDealsByDateTimeRange()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare small range of deals by date time range", ((string[])(null)));
#line 79
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "DealSource",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table6.AddRow(new string[] {
                        "cnx-deals",
                        "19/06/2014  17:36:00",
                        "19/06/2014  17:44:59"});
#line 80
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table6, "Given ");
#line 83
  testRunner.When("I retrieve the qdf deal data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 84
  testRunner.And("I query cnx trade by trade id from \"19/06/2014  17:36:00\" to \"19/06/2014  17:44:5" +
                    "9\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExcludedFields"});
            table7.AddRow(new string[] {
                        "OrderId"});
            table7.AddRow(new string[] {
                        "Side"});
#line 85
  testRunner.And("I compare the cnx trade deals with the qdf deal data excluding these fields:", ((string)(null)), table7, "And ");
#line 89
  testRunner.Then("the cnx trade deals should match the qdf deal data exactly", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
