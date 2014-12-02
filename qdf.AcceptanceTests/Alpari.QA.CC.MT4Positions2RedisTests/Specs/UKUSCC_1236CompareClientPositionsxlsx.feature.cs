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
namespace Alpari.QA.CC.MT4Positions2RedisTests.Specs
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.9.0.77")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("UKUSCC_1236CompareClientPositionsXlsx")]
    [NUnit.Framework.CategoryAttribute("UKUSCC_1236")]
    public partial class UKUSCC_1236CompareClientPositionsXlsxFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "UKUSCC_1236CompareClientPositionsxlsx.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-GB"), "UKUSCC_1236CompareClientPositionsXlsx", "In order to find discrepancies in redis and ars open positions\r\nAs a CC tester\r\nI" +
                    " want to compare cc_sp_get_client_positions between cc@master and cc_uat@slave3", ProgrammingLanguage.CSharp, new string[] {
                        "UKUSCC_1236"});
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
        [NUnit.Framework.DescriptionAttribute("Compare JPN Client Positions")]
        public virtual void CompareJPNClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare JPN Client Positions", ((string[])(null)));
#line 10
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table1.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_ars_ajpc01_4_20141201_164121.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_ars_ajpc01_4_20141201_164144.xlsx" +
                            ""});
#line 11
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table1, "When ");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table2.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 14
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table2, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare C1 Client Positions")]
        public virtual void CompareC1ClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare C1 Client Positions", ((string[])(null)));
#line 18
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table3.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_ars_AUKC01_6_20141201_164456.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_ars_AUKC01_6_20141201_164458.xlsx" +
                            ""});
#line 19
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table3, "When ");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table4.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 22
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table4, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare C2 Client Positions")]
        public virtual void CompareC2ClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare C2 Client Positions", ((string[])(null)));
#line 26
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table5.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_ars_AUKC02_46_20141201_164637.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_ars_AUKC02_46_20141201_164720.xls" +
                            "x"});
#line 27
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table5, "When ");
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table6.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 30
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table6, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare MT4AUKM01 Client Positions")]
        public virtual void CompareMT4AUKM01ClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare MT4AUKM01 Client Positions", ((string[])(null)));
#line 34
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table7.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_ars_aukm01_47_20141201_165102.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_ars_aukm01_47_20141201_165045.xls" +
                            "x"});
#line 35
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table7, "When ");
#line hidden
            TechTalk.SpecFlow.Table table8 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table8.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 38
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table8, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare MT4AUKM02 Client Positions")]
        public virtual void CompareMT4AUKM02ClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare MT4AUKM02 Client Positions", ((string[])(null)));
#line 42
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table9 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table9.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_ars_aukm02_48_20141201_165524.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_ars_aukm02_48_20141201_165551.xls" +
                            "x"});
#line 43
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table9, "When ");
#line hidden
            TechTalk.SpecFlow.Table table10 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table10.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 46
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table10, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare MT4AUKPO1 Client Positions")]
        public virtual void CompareMT4AUKPO1ClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare MT4AUKPO1 Client Positions", ((string[])(null)));
#line 50
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table11 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table11.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_ars_AUKP01_49_20141201_165633.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_ars_AUKP01_49_20141201_165634.xls" +
                            "x"});
#line 51
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table11, "When ");
#line hidden
            TechTalk.SpecFlow.Table table12 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table12.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 54
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table12, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare MT4AUKSB1 Client Positions")]
        public virtual void CompareMT4AUKSB1ClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare MT4AUKSB1 Client Positions", ((string[])(null)));
#line 58
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table13 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table13.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_ars_AUKSB1_53_20141201_165720.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_ars_AUKSB1_53_20141201_165723.xls" +
                            "x"});
#line 59
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table13, "When ");
#line hidden
            TechTalk.SpecFlow.Table table14 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table14.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 62
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table14, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare CBOJ Client Positions")]
        public virtual void CompareCBOJClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare CBOJ Client Positions", ((string[])(null)));
#line 66
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table15 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table15.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_ars_cboj_57_20141201_170132.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_ars_cboj_57_20141201_170130.xlsx"});
#line 67
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table15, "When ");
#line hidden
            TechTalk.SpecFlow.Table table16 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table16.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 70
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table16, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare B2B Client Positions")]
        public virtual void CompareB2BClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare B2B Client Positions", ((string[])(null)));
#line 74
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table17 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table17.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_ars_AUKB2B1_74_20141201_164815.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_ars_AUKB2B1_74_20141201_164815.xl" +
                            "sx"});
#line 75
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table17, "When ");
#line hidden
            TechTalk.SpecFlow.Table table18 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table18.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 78
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table18, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare MT4AUKMARKET1 Client Positions")]
        public virtual void CompareMT4AUKMARKET1ClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare MT4AUKMARKET1 Client Positions", ((string[])(null)));
#line 82
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table19 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table19.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_ars_AUKMarket1_89_20141201_170310.xl" +
                            "sx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_ars_AUKMarket1_89_20141201_170327" +
                            ".xlsx"});
#line 83
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table19, "When ");
#line hidden
            TechTalk.SpecFlow.Table table20 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table20.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 86
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table20, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare MT4AUKMARKETMENA Client Positions")]
        public virtual void CompareMT4AUKMARKETMENAClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare MT4AUKMARKETMENA Client Positions", ((string[])(null)));
#line 90
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table21 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table21.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_ars_AUKMarketMENA_90_20141201_171708" +
                            ".xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_ars_AUKMarketMENA_90_20141201_171" +
                            "707.xlsx"});
#line 91
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table21, "When ");
#line hidden
            TechTalk.SpecFlow.Table table22 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table22.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 94
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table22, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare ADS Client Positions")]
        public virtual void CompareADSClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare ADS Client Positions", ((string[])(null)));
#line 98
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table23 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table23.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_uk_ADS_201_20141201_172245.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_uk_ADS_201_20141201_172244.xlsx"});
#line 99
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table23, "When ");
#line hidden
            TechTalk.SpecFlow.Table table24 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table24.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 102
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table24, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare ASV Client Positions")]
        public virtual void CompareASVClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare ASV Client Positions", ((string[])(null)));
#line 106
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table25 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table25.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_uk_ASV_202_20141201_172327.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_uk_ASV_202_20141201_172325.xlsx"});
#line 107
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table25, "When ");
#line hidden
            TechTalk.SpecFlow.Table table26 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table26.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 110
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table26, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare MSCov Client Positions")]
        public virtual void CompareMSCovClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare MSCov Client Positions", ((string[])(null)));
#line 114
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table27 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table27.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_uk_Coverage_203_20141201_172400.xlsx" +
                            "",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_uk_Coverage_203_20141201_172358.x" +
                            "lsx"});
#line 115
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table27, "When ");
#line hidden
            TechTalk.SpecFlow.Table table28 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table28.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 118
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table28, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare ADS STP Client Positions")]
        public virtual void CompareADSSTPClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare ADS STP Client Positions", ((string[])(null)));
#line 122
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table29 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table29.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_uk_ADS_STP_204_20141201_172450.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_uk_ADS_STP_204_20141201_172447.xl" +
                            "sx"});
#line 123
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table29, "When ");
#line hidden
            TechTalk.SpecFlow.Table table30 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table30.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 126
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table30, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare ADS CFD Client Positions")]
        public virtual void CompareADSCFDClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare ADS CFD Client Positions", ((string[])(null)));
#line 130
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table31 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table31.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_uk_ADS_CFD_206_20141201_172540.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_uk_ADS_CFD_206_20141201_172537.xl" +
                            "sx"});
#line 131
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table31, "When ");
#line hidden
            TechTalk.SpecFlow.Table table32 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table32.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 134
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table32, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Compare FXCM Client Positions")]
        public virtual void CompareFXCMClientPositions()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Compare FXCM Client Positions", ((string[])(null)));
#line 138
this.ScenarioSetup(scenarioInfo);
#line hidden
            TechTalk.SpecFlow.Table table33 = new TechTalk.SpecFlow.Table(new string[] {
                        "RedisPositionsFile",
                        "ArsPositionsFile"});
            table33.AddRow(new string[] {
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Redis_uk_FXCM_208_20141201_172621.xlsx",
                        "C:\\Users\\dgalloway\\Downloads\\Positions_Database_uk_FXCM_208_20141201_172616.xlsx"});
#line 139
 testRunner.When("I compare cc redis and cc ars client position data from xlsx:-", ((string)(null)), table33, "When ");
#line hidden
            TechTalk.SpecFlow.Table table34 = new TechTalk.SpecFlow.Table(new string[] {
                        "ExportType",
                        "Overwrite"});
            table34.AddRow(new string[] {
                        "DataTableToCsv",
                        "true"});
#line 142
 testRunner.Then("the redis positions should match the ars positions exactly:-", ((string)(null)), table34, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
