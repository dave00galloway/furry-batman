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
namespace Alpari.QualityAssurance.SpecFlowExtensions.Specs
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.9.0.77")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("TypedDataTableFun")]
    public partial class TypedDataTableFunFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "TypedDataTableFun.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "TypedDataTableFun", "In order to compare sets of actual and expected data\r\nAs a Tester\r\nI want methods" +
                    " for comparing Typed Data Tables", ProgrammingLanguage.CSharp, ((string[])(null)));
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
        [NUnit.Framework.DescriptionAttribute("Compare Two matching data sets")]
        public virtual void CompareTwoMatchingDataSets()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare Two matching data sets", ((string[])(null)));
#line 6
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
#line 7
 testRunner.Given("I have the following \"expected\" person data:", ((string)(null)), table1, "Given ");
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
#line 11
 testRunner.And("I have the following \"actual\" person data:", ((string)(null)), table2, "And ");
#line 15
 testRunner.When("I compare the \"expected\" and \"actual\" person data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 16
 testRunner.Then("the person data should match exactly", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare Two data sets one mismatch")]
        public virtual void CompareTwoDataSetsOneMismatch()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare Two data sets one mismatch", ((string[])(null)));
#line 18
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table3.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "99",
                        "Impaler"});
            table3.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 19
 testRunner.Given("I have the following \"expected\" person data:", ((string)(null)), table3, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table4.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
            table4.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 23
 testRunner.And("I have the following \"actual\" person data:", ((string)(null)), table4, "And ");
#line 27
 testRunner.When("I compare the \"expected\" and \"actual\" person data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 28
 testRunner.Then("the person data should contain 1 \"mismatch\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare Two data sets one missing")]
        public virtual void CompareTwoDataSetsOneMissing()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare Two data sets one missing", ((string[])(null)));
#line 30
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table5.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
            table5.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 31
 testRunner.Given("I have the following \"expected\" person data:", ((string)(null)), table5, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table6.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
#line 35
 testRunner.And("I have the following \"actual\" person data:", ((string)(null)), table6, "And ");
#line 38
 testRunner.When("I compare the \"expected\" and \"actual\" person data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 39
 testRunner.Then("the person data should contain 1 \"missing\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare Two data sets one extra")]
        public virtual void CompareTwoDataSetsOneExtra()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare Two data sets one extra", ((string[])(null)));
#line 41
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table7.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
#line 42
 testRunner.Given("I have the following \"expected\" person data:", ((string)(null)), table7, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table8 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table8.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
            table8.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 45
 testRunner.And("I have the following \"actual\" person data:", ((string)(null)), table8, "And ");
#line 49
 testRunner.When("I compare the \"expected\" and \"actual\" person data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 50
 testRunner.Then("the person data should contain 1 \"extra\"", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare Two data sets one mismatch and export to csv")]
        [NUnit.Framework.CategoryAttribute("UKUSQDF_116")]
        public virtual void CompareTwoDataSetsOneMismatchAndExportToCsv()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare Two data sets one mismatch and export to csv", new string[] {
                        "UKUSQDF_116"});
#line 53
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table9 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table9.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "99",
                        "Impaler"});
            table9.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 54
 testRunner.Given("I have the following \"expected\" person data:", ((string)(null)), table9, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table10 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table10.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
            table10.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 58
 testRunner.And("I have the following \"actual\" person data:", ((string)(null)), table10, "And ");
#line 62
 testRunner.When("I compare the \"expected\" and \"actual\" person data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table11 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "FileName",
                        "Path",
                        "Overwrite"});
            table11.AddRow(new string[] {
                        "DataTableToCsv",
                        "mismatch",
                        "C:\\temp\\",
                        "true"});
#line 63
 testRunner.Then("the person data should contain 1 \"mismatch\" :-", ((string)(null)), table11, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare Two data sets one missing and export to csv")]
        [NUnit.Framework.CategoryAttribute("UKUSQDF_116")]
        public virtual void CompareTwoDataSetsOneMissingAndExportToCsv()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare Two data sets one missing and export to csv", new string[] {
                        "UKUSQDF_116"});
#line 68
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table12 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table12.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
            table12.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 69
 testRunner.Given("I have the following \"expected\" person data:", ((string)(null)), table12, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table13 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table13.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
#line 73
 testRunner.And("I have the following \"actual\" person data:", ((string)(null)), table13, "And ");
#line 76
 testRunner.When("I compare the \"expected\" and \"actual\" person data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table14 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "FileName",
                        "Path",
                        "Overwrite"});
            table14.AddRow(new string[] {
                        "DataTableToCsv",
                        "missing",
                        "C:\\temp\\",
                        "true"});
#line 77
 testRunner.Then("the person data should contain 1 \"missing\" :-", ((string)(null)), table14, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare Two data sets one extra and export to csv")]
        [NUnit.Framework.CategoryAttribute("UKUSQDF_116")]
        public virtual void CompareTwoDataSetsOneExtraAndExportToCsv()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare Two data sets one extra and export to csv", new string[] {
                        "UKUSQDF_116"});
#line 82
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table15 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table15.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
#line 83
 testRunner.Given("I have the following \"expected\" person data:", ((string)(null)), table15, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table16 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table16.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
            table16.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 86
 testRunner.And("I have the following \"actual\" person data:", ((string)(null)), table16, "And ");
#line 90
 testRunner.When("I compare the \"expected\" and \"actual\" person data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table17 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "FileName",
                        "Path",
                        "Overwrite"});
            table17.AddRow(new string[] {
                        "DataTableToCsv",
                        "extra",
                        "C:\\temp\\",
                        "true"});
#line 91
 testRunner.Then("the person data should contain 1 \"extra\" :-", ((string)(null)), table17, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare Two data sets one mismatch and export to console")]
        [NUnit.Framework.CategoryAttribute("UKUSQDF_116")]
        public virtual void CompareTwoDataSetsOneMismatchAndExportToConsole()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare Two data sets one mismatch and export to console", new string[] {
                        "UKUSQDF_116"});
#line 96
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table18 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table18.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "99",
                        "Impaler"});
            table18.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 97
 testRunner.Given("I have the following \"expected\" person data:", ((string)(null)), table18, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table19 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table19.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
            table19.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 101
 testRunner.And("I have the following \"actual\" person data:", ((string)(null)), table19, "And ");
#line 105
 testRunner.When("I compare the \"expected\" and \"actual\" person data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table20 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType"});
            table20.AddRow(new string[] {
                        "DataTableToConsole"});
#line 106
 testRunner.Then("the person data should contain 1 \"mismatch\" :-", ((string)(null)), table20, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare Two data sets one missing and export to console")]
        [NUnit.Framework.CategoryAttribute("UKUSQDF_116")]
        public virtual void CompareTwoDataSetsOneMissingAndExportToConsole()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare Two data sets one missing and export to console", new string[] {
                        "UKUSQDF_116"});
#line 111
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table21 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table21.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
            table21.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 112
 testRunner.Given("I have the following \"expected\" person data:", ((string)(null)), table21, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table22 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table22.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
#line 116
 testRunner.And("I have the following \"actual\" person data:", ((string)(null)), table22, "And ");
#line 119
 testRunner.When("I compare the \"expected\" and \"actual\" person data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table23 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType"});
            table23.AddRow(new string[] {
                        "DataTableToConsole"});
#line 120
 testRunner.Then("the person data should contain 1 \"missing\" :-", ((string)(null)), table23, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare Two data sets one extra and export to console")]
        [NUnit.Framework.CategoryAttribute("UKUSQDF_116")]
        public virtual void CompareTwoDataSetsOneExtraAndExportToConsole()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare Two data sets one extra and export to console", new string[] {
                        "UKUSQDF_116"});
#line 125
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table24 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table24.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
#line 126
 testRunner.Given("I have the following \"expected\" person data:", ((string)(null)), table24, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table25 = new TechTalk.SpecFlow.Table(new string[] {
                        "ID",
                        "Forenames",
                        "Lastname",
                        "Age",
                        "Occupation"});
            table25.AddRow(new string[] {
                        "1",
                        "Vladimir",
                        "Putin",
                        "98",
                        "Impaler"});
            table25.AddRow(new string[] {
                        "2",
                        "John",
                        "Kerry",
                        "100",
                        "stand up comic"});
#line 129
 testRunner.And("I have the following \"actual\" person data:", ((string)(null)), table25, "And ");
#line 133
 testRunner.When("I compare the \"expected\" and \"actual\" person data", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table26 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType"});
            table26.AddRow(new string[] {
                        "DataTableToConsole"});
#line 134
 testRunner.Then("the person data should contain 1 \"extra\" :-", ((string)(null)), table26, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
