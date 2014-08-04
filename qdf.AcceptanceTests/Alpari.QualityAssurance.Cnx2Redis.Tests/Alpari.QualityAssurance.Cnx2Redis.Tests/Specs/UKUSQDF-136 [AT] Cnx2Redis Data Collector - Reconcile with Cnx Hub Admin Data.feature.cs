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
namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Specs
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.9.0.77")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data")]
    [NUnit.Framework.CategoryAttribute("UKUSQDF_136")]
    [NUnit.Framework.CategoryAttribute("cnxHubTradeActivityImporter:Csv")]
    public partial class UKUSQDF_136ATCnx2RedisDataCollector_ReconcileWithCnxHubAdminDataFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-GB"), "UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data", "In order to have confidence in the cnx-deals data\r\nAs a QDF analyst\r\nI want to se" +
                    "e that cnx-deals data matches data from cnx admin hub", ProgrammingLanguage.CSharp, new string[] {
                        "UKUSQDF_136",
                        "cnxHubTradeActivityImporter:Csv"});
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
                        "Login",
                        "Name"});
            table1.AddRow(new string[] {
                        "AUKUS2102",
                        "Lucror"});
            table1.AddRow(new string[] {
                        "AUKUS2089",
                        "Chase Capital"});
            table1.AddRow(new string[] {
                        "AUKUS2065",
                        "Leverate Financial"});
            table1.AddRow(new string[] {
                        "AUKUS2095",
                        "TradingServices"});
            table1.AddRow(new string[] {
                        "AUKUS2099",
                        "BostonPrime"});
            table1.AddRow(new string[] {
                        "AUKUS2106",
                        "Gedik"});
            table1.AddRow(new string[] {
                        "AUKUS2033",
                        "Forex Financial"});
            table1.AddRow(new string[] {
                        "AUKUS1004",
                        "Royal Forex Trading"});
            table1.AddRow(new string[] {
                        "AUKP2962",
                        "Accurate Investment"});
            table1.AddRow(new string[] {
                        "AUKUS2026",
                        "TTCM Traders Trust"});
            table1.AddRow(new string[] {
                        "AUKP3064",
                        "Fidus SAL"});
            table1.AddRow(new string[] {
                        "AUKP2848",
                        "Aganex"});
            table1.AddRow(new string[] {
                        "AUKUS2078",
                        "Scope"});
            table1.AddRow(new string[] {
                        "AUKP3156",
                        "Gerhardus"});
            table1.AddRow(new string[] {
                        "AUKP3399",
                        "Atef Abdulrahman Mohammed AlNuwaiser"});
            table1.AddRow(new string[] {
                        "AUKP3038",
                        "Arab International"});
            table1.AddRow(new string[] {
                        "AUKP1050",
                        "Bailey"});
            table1.AddRow(new string[] {
                        "AUKP3233",
                        "Mohammad Najmudeen"});
            table1.AddRow(new string[] {
                        "AUKP2193",
                        "Uros Frantar"});
            table1.AddRow(new string[] {
                        "AUKP3216",
                        "Javier Timerman"});
#line 8
testRunner.Given("I have this list of takers to load from cnx hub", ((string)(null)), table1, "Given ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data")]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 07-14-2014  To 07-14-2014.csv", null)]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 07-15-2014  To 07-15-2014.csv", null)]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 07-16-2014  To 07-16-2014.csv", null)]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 07-17-2014  To 07-17-2014.csv", null)]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 07-18-2014  To 07-20-2014.csv", null)]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 07-21-2014  To 07-21-2014.csv", null)]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 07-22-2014  To 07-22-2014.csv", null)]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 07-23-2014  To 07-23-2014.csv", null)]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 07-24-2014  To 07-27-2014.csv", null)]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 07-28-2014  To 07-28-2014.csv", null)]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 07-29-2014  To 07-30-2014.csv", null)]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 07-31-2014  To 07-31-2014.csv", null)]
        [NUnit.Framework.TestCaseAttribute("C:\\data\\Trade Activities For All accounts From 08-01-2014  To 08-03-2014.csv", null)]
        public virtual void UKUSQDF_136ATCnx2RedisDataCollector_ReconcileWithCnxHubAdminData(string report, string[] exampleTags)
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data", exampleTags);
#line 31
this.ScenarioSetup(scenarioInfo);
#line 7
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "DealSource",
                        "DealType"});
            table2.AddRow(new string[] {
                        "cnx-deals",
                        "BookLessDeal"});
#line 32
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table2, "Given ");
#line 35
 testRunner.When(string.Format("I load cnx trade activities from \"{0}\" for the included logins", report), ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 36
  testRunner.And("I retrieve the qdf deal data filtered by cnx hub start and end times and by inclu" +
                    "ded logins", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExcludedFields"});
            table3.AddRow(new string[] {
                        "Comment"});
            table3.AddRow(new string[] {
                        "AccountGroup"});
            table3.AddRow(new string[] {
                        "Book"});
            table3.AddRow(new string[] {
                        "OrderId"});
            table3.AddRow(new string[] {
                        "State"});
#line 37
  testRunner.And("I compare the cnx hub trade deals with the qdf deal data excluding these fields:", ((string)(null)), table3, "And ");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table4.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 44
 testRunner.Then("the cnx hub trade deals should match the qdf deal data exactly:-", ((string)(null)), table4, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Trade Activities For All accounts From 07-14-2014  To 07-14-2014 Pre Midnight")]
        [NUnit.Framework.IgnoreAttribute()]
        public virtual void TradeActivitiesForAllAccountsFrom07_14_2014To07_14_2014PreMidnight()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Trade Activities For All accounts From 07-14-2014  To 07-14-2014 Pre Midnight", new string[] {
                        "ignore"});
#line 67
this.ScenarioSetup(scenarioInfo);
#line 7
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "DealSource",
                        "DealType"});
            table5.AddRow(new string[] {
                        "cnx-deals",
                        "BookLessDeal"});
#line 68
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table5, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "FileNamePath",
                        "ConvertedStartTime",
                        "ConvertedEndTime"});
            table6.AddRow(new string[] {
                        "C:\\data\\Trade Activities For All accounts From 07-14-2014  To 07-14-2014.csv",
                        "13/07/2014  21:06:10",
                        "13/07/2014  23:59:59"});
#line 71
 testRunner.When("I load cnx trade activities for the included logins from", ((string)(null)), table6, "When ");
#line 75
  testRunner.And("I retrieve the qdf deal data filtered by cnx hub start and end times and by inclu" +
                    "ded logins", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExcludedFields"});
            table7.AddRow(new string[] {
                        "Comment"});
            table7.AddRow(new string[] {
                        "AccountGroup"});
            table7.AddRow(new string[] {
                        "Book"});
            table7.AddRow(new string[] {
                        "OrderId"});
            table7.AddRow(new string[] {
                        "State"});
#line 76
  testRunner.And("I compare the cnx hub trade deals with the qdf deal data excluding these fields:", ((string)(null)), table7, "And ");
#line hidden
            TechTalk.SpecFlow.Table table8 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table8.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 84
 testRunner.Then("the cnx hub trade deals should match the qdf deal data exactly:-", ((string)(null)), table8, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Trade Activities For All accounts From07-23-2014 To07-23-2014")]
        [NUnit.Framework.IgnoreAttribute()]
        public virtual void TradeActivitiesForAllAccountsFrom07_23_2014To07_23_2014()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Trade Activities For All accounts From07-23-2014 To07-23-2014", new string[] {
                        "ignore"});
#line 88
this.ScenarioSetup(scenarioInfo);
#line 7
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table9 = new TechTalk.SpecFlow.Table(new string[] {
                        "DealSource",
                        "DealType"});
            table9.AddRow(new string[] {
                        "cnx-deals",
                        "BookLessDeal"});
#line 89
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table9, "Given ");
#line 92
 testRunner.When("I load cnx trade activities from \"C:\\data\\Trade Activities For All accounts From " +
                    "07-23-2014  To 07-23-2014.csv\" for the included logins", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 93
  testRunner.And("I retrieve the qdf deal data filtered by cnx hub start and end times and by inclu" +
                    "ded logins", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            TechTalk.SpecFlow.Table table10 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExcludedFields"});
            table10.AddRow(new string[] {
                        "Comment"});
            table10.AddRow(new string[] {
                        "AccountGroup"});
            table10.AddRow(new string[] {
                        "Book"});
            table10.AddRow(new string[] {
                        "OrderId"});
            table10.AddRow(new string[] {
                        "State"});
#line 94
  testRunner.And("I compare the cnx hub trade deals with the qdf deal data excluding these fields:", ((string)(null)), table10, "And ");
#line hidden
            TechTalk.SpecFlow.Table table11 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table11.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 102
 testRunner.Then("the cnx hub trade deals should match the qdf deal data exactly:-", ((string)(null)), table11, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
