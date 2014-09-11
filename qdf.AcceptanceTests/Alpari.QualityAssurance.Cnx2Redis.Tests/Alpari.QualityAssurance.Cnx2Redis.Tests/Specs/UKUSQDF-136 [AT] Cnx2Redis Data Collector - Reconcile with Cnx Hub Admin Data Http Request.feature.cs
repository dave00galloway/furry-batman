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
    [NUnit.Framework.DescriptionAttribute("UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data htt" +
        "p request")]
    [NUnit.Framework.CategoryAttribute("UKUSQDF_136")]
    [NUnit.Framework.CategoryAttribute("cnxHubTradeActivityImporter:WebClient")]
    public partial class UKUSQDF_136ATCnx2RedisDataCollector_ReconcileWithCnxHubAdminDataHttpRequestFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data Http Request.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-GB"), "UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data htt" +
                    "p request", "In order to have confidence in the cnx-deals data\r\nAs a QDF analyst\r\nI want to se" +
                    "e that cnx-deals data matches data from cnx admin hub", ProgrammingLanguage.CSharp, new string[] {
                        "UKUSQDF_136",
                        "cnxHubTradeActivityImporter:WebClient"});
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
        [NUnit.Framework.DescriptionAttribute("UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data fro" +
            "m http request")]
        [NUnit.Framework.TestCaseAttribute("08/05/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/06/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/07/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/08/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/09/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/10/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/11/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/12/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/13/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/14/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/15/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/16/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/17/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/18/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/19/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/20/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/21/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/22/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/23/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/24/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/25/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/26/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/27/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/28/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/29/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/30/2014", null)]
        [NUnit.Framework.TestCaseAttribute("08/31/2014", null)]
        [NUnit.Framework.TestCaseAttribute("09/01/2014", null)]
        public virtual void UKUSQDF_136ATCnx2RedisDataCollector_ReconcileWithCnxHubAdminDataFromHttpRequest(string reportDate, string[] exampleTags)
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data fro" +
                    "m http request", exampleTags);
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
 testRunner.When(string.Format("I load cnx trade activities for \"{0}\" for the included logins", reportDate), ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
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
        [NUnit.Framework.DescriptionAttribute("UKUSQDF-136 [AT] Cnx2Redis Data Collector - redeploy at build 31")]
        [NUnit.Framework.TestCaseAttribute("09/04/2014", null)]
        [NUnit.Framework.TestCaseAttribute("09/05/2014", null)]
        [NUnit.Framework.TestCaseAttribute("09/06/2014", null)]
        [NUnit.Framework.TestCaseAttribute("09/07/2014", null)]
        [NUnit.Framework.TestCaseAttribute("09/08/2014", null)]
        [NUnit.Framework.TestCaseAttribute("09/09/2014", null)]
        [NUnit.Framework.TestCaseAttribute("09/10/2014", null)]
        public virtual void UKUSQDF_136ATCnx2RedisDataCollector_RedeployAtBuild31(string reportDate, string[] exampleTags)
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("UKUSQDF-136 [AT] Cnx2Redis Data Collector - redeploy at build 31", exampleTags);
#line 78
this.ScenarioSetup(scenarioInfo);
#line 7
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "DealSource",
                        "DealType"});
            table5.AddRow(new string[] {
                        "cnxstp-pret-deals",
                        "BookLessDeal"});
#line 79
 testRunner.Given("I have the following search criteria for qdf deals", ((string)(null)), table5, "Given ");
#line 82
 testRunner.When(string.Format("I load cnx trade activities for \"{0}\" for the included logins", reportDate), ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 83
  testRunner.And("I retrieve the qdf deal data filtered by cnx hub start and end times and by inclu" +
                    "ded logins", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExcludedFields"});
            table6.AddRow(new string[] {
                        "Comment"});
            table6.AddRow(new string[] {
                        "AccountGroup"});
            table6.AddRow(new string[] {
                        "Book"});
            table6.AddRow(new string[] {
                        "OrderId"});
            table6.AddRow(new string[] {
                        "State"});
#line 84
  testRunner.And("I compare the cnx hub trade deals with the qdf deal data excluding these fields:", ((string)(null)), table6, "And ");
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table7.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 91
 testRunner.Then("the cnx hub trade deals should match the qdf deal data exactly:-", ((string)(null)), table7, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
