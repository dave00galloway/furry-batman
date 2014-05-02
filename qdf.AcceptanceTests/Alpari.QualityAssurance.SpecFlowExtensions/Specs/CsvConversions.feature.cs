﻿// ------------------------------------------------------------------------------
//  <auto-generated>
//      This code was generated by SpecFlow (http://www.specflow.org/).
//      SpecFlow Version:1.9.0.77
//      SpecFlow Generator Version:1.9.0.0
//      Runtime Version:4.0.30319.18063
// 
//      Changes to this file may cause incorrect behavior and will be lost if
//      the code is regenerated.
//  </auto-generated>
// ------------------------------------------------------------------------------
#region Designer generated code
#pragma warning disable
namespace Alpari.QualityAssurance.SpecFlowExtensions.Specs
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.9.0.77")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("CsvConversions")]
    public partial class CsvConversionsFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "CsvConversions.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "CsvConversions", "In order to read and write data\r\nAs a tester\r\nI want to be able to create objects" +
                    " from csv and vice versa", ProgrammingLanguage.CSharp, ((string[])(null)));
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
        [NUnit.Framework.DescriptionAttribute("create file from list of objects and read back as list")]
        [NUnit.Framework.CategoryAttribute("mytag")]
        public virtual void CreateFileFromListOfObjectsAndReadBackAsList()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("create file from list of objects and read back as list", new string[] {
                        "mytag"});
#line 7
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table1.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "99",
                        "Impaler"});
            table1.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 8
 testRunner.Given("I have the following \"expected\" person data:", ((string)(null)), table1, "Given ");
#line 12
 testRunner.When("I export the \"expected\" person data to csv \"people.csv\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 13
 testRunner.And("I import the csv file \"people.csv\" as a Person list caled \"actual\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 14
 testRunner.And("I compare the \"expected\" and \"actual\" person data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 15
 testRunner.Then("the person data should match exactly", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("create file from list of objects and read back as list with duplicates")]
        public virtual void CreateFileFromListOfObjectsAndReadBackAsListWithDuplicates()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("create file from list of objects and read back as list with duplicates", ((string[])(null)));
#line 18
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table2.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "99",
                        "Impaler"});
            table2.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 19
 testRunner.Given("I have the following \"expected\" person data:", ((string)(null)), table2, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table3.AddRow(new string[] {
                        "3",
                        "Vladimir",
                        "Putin",
                        "99",
                        "Impaler"});
            table3.AddRow(new string[] {
                        "4",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 23
 testRunner.And("I have the following \"additional\" person data:", ((string)(null)), table3, "And ");
#line 27
 testRunner.When("I export the \"expected\" person data to csv \"people.csv\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 28
 testRunner.And("I append the \"additional\" person data to csv \"people.csv\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 29
 testRunner.And("I import the csv file \"people.csv\" as a Person list caled \"actual\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 30
 testRunner.And("I compare the \"expected\" and \"actual\" person data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 31
 testRunner.Then("the person data should contain 2 \"extra\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
