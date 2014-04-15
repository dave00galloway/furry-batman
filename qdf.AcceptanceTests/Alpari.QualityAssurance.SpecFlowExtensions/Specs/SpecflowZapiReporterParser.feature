@Reporting
#exentually use this projects own dynamically generated test results, but will want to exclude Sceanrios tagged @Reporting
Feature: SpecflowZapiReporterParser
	In order to upload Specflow test results to Zephyr
	As a Test Designer
	I want to be able to load specflow test results into memory

Background:	Load Xml to a generic parser
	Given I have an xml test result file
	"""
	TestData\TestResult.xml
	"""

Scenario: Load an xml result file and find a single test result
	Then the xml root Name property is "test-results"

Scenario: Load an xml result file and find a test result
	When I parse the xml test result file as test-results
	Then test-results with a "name" attribute value of "C:\svn\local\BakeryDemoTest\trunk\AllBakeryDemoTestProjects\FIX_SpecflowTests\bin\Release\FIX_SpecflowTests.dll" exists

Scenario: Load an xml result file and find a test result's values
	When I parse the xml test result file as test-results
	Then a test-results object with the following attribute values exists:
	| name                                                                                                            | total | errors | failures | notrun | inconclusive | ignored | skipped | invalid | date       | time     |
	| C:\svn\local\BakeryDemoTest\trunk\AllBakeryDemoTestProjects\FIX_SpecflowTests\bin\Release\FIX_SpecflowTests.dll | 7     | 1      | 0        | 0      | 0            | 0       | 0       | 0       | 2014-01-27 | 14:07:06 |

#TODO:- create a vertical table in field/value format with optional comparison type (exact/case insensitive contais etc)

@negative
Scenario: Load an xml result file and find a test result's values negative
	When I parse the xml test result file as test-results
	Then a test-results object with the following attribute values exists:
	| name                                                                                                          | total | errors | failures | notrun | inconclusive | ignored | skipped | invalid | date       | time     |
	| C:\svn\local\BakeryDemoTest\trunk\AllBakeryDemoTestProjects\FIX_SpecflowTests\bin\Debug\FIX_SpecflowTests.dll | 6     | 2      | 2        | 1      | 1            | 4       | 6       | 8       | 2014-03-27 | 14:05:06 |


Scenario: Load an xml result file and find an environment
	When I parse the xml test result file as an environment
	Then an environment with a "nunitversion" attribute value of "2.6.3.13283" exists

Scenario: Load an xml result file and find an environment's value
	When I parse the xml test result file as an environment
	Then an environment object with the following attribute values exists:
	| nunitversion | clrversion     | osversion                                    | platform | cwd                                                         | machinename | user      | userdomain |
	| 2.6.3.13283  | 2.0.50727.5472 | Microsoft Windows NT 6.1.7601 Service Pack 1 | Win32NT  | C:\svn\local\BakeryDemoTest\trunk\AllBakeryDemoTestProjects | AUK0231NB   | dgalloway | ALPARI-UK  |


Scenario: Load an xml result file and find a suite
	When I parse the xml test result file as a test-suite collection
	Then a test-suite with a "name" attribute value of "FIX_SpecflowTests" exists

@negative
Scenario: Load an xml result file and fail to find a suite
	When I parse the xml test result file as a test-suite collection
	Then a test-suite with a "name" attribute value of "made up suite" exists

Scenario: Load an xml result file and find a TestFixture suite
	When I parse the xml test result file as a test-suite collection
	Then a test-suite with a "type" attribute value of "TestFixture" exists

@negative
Scenario: Load an xml result file and find test cases
	When I parse the xml test result file as a test-suite collection
	Then the following test cases are found for these test suites:
	| test suite name                | test case name                                                                                                            | executed | result  | success | time  | asserts |
	| ShareContextOneFeature         | Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextOneFeature.AccessAStaticObjectFromShareContextOneScenarioOne | True     | Success | True    | 0.352 | 2       |
	| ShareContextOneFeature         | Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextOneFeature.AccessAStaticObjectFromShareContextOneScenarioTwo | True     | Success | True    | 0.001 | 2       |
	| ShareContextTwoFeature         | Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextTwoFeature.AccessAStaticObjectFromShareContextTwoScenarioOne | True     | Success | True    | 0.002 | 2       |
	| ShareContextTwoFeature         | Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextTwoFeature.AccessAStaticObjectFromShareContextTwoScenarioTwo | True     | Success | True    | 0.001 | 2       |
	| QuoteRequestAndResponseFeature | FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAnInvalidCurrencySymbolReceivesAQuote               | True     | Error   | False   | 0.058 | 0       |
	| QuoteRequestAndResponseFeature | FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAnInvalidCurrencySymbolReceivesAQuoteRejection      | Success  | True    | True    | 0.008 | 3       |
	| QuoteRequestAndResponseFeature | FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAValidCurrencySymbolReceivesAQuote                  | Success  | True    | True    | 0.009 | 1       |

@Jira1234
Scenario: Load an xml result file and find test cases by test case name
	When I parse the xml test result file as a test-suite collection
	Then the following test cases are found for these test suites keyed by "test case name":
	| test case short name                                          | test suite name                | test case name                                                                                                            | executed | result  | success | time  | asserts |
	| AccessAStaticObjectFromShareContextOneScenarioOne             | ShareContextOneFeature         | Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextOneFeature.AccessAStaticObjectFromShareContextOneScenarioOne | True     | Success | True    | 0.352 | 2       |
	| AccessAStaticObjectFromShareContextOneScenarioTwo             | ShareContextOneFeature         | Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextOneFeature.AccessAStaticObjectFromShareContextOneScenarioTwo | True     | Success | True    | 0.001 | 2       |
	| AccessAStaticObjectFromShareContextTwoScenarioOne             | ShareContextTwoFeature         | Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextTwoFeature.AccessAStaticObjectFromShareContextTwoScenarioOne | True     | Success | True    | 0.002 | 2       |
	| AccessAStaticObjectFromShareContextTwoScenarioTwo             | ShareContextTwoFeature         | Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextTwoFeature.AccessAStaticObjectFromShareContextTwoScenarioTwo | True     | Success | True    | 0.001 | 2       |
	| QuoteRequestForAnInvalidCurrencySymbolReceivesAQuote          | QuoteRequestAndResponseFeature | FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAnInvalidCurrencySymbolReceivesAQuote               | True     | Error   | False   | 0.058 | 0       |
	| QuoteRequestForAnInvalidCurrencySymbolReceivesAQuoteRejection | QuoteRequestAndResponseFeature | FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAnInvalidCurrencySymbolReceivesAQuoteRejection      | True     | Success | True    | 0.008 | 3       |
	| QuoteRequestForAValidCurrencySymbolReceivesAQuote             | QuoteRequestAndResponseFeature | FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAValidCurrencySymbolReceivesAQuote                  | True     | Success | True    | 0.009 | 1       |

@negative
Scenario: Load an xml result file and find test cases by test case name with some comparsion differences
	When I parse the xml test result file as a test-suite collection
	Then the following test cases are found for these test suites keyed by "test case name":
	| test case short name                                          | test suite name                | test case name                                                                                                            | executed | result  | success | time  | asserts |
	| AccessAStaticObjectFromShareContextOneScenarioOne             | ShareContextOneFeature         | Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextOneFeature.AccessAStaticObjectFromShareContextOneScenarioOne | True     | Success | false   | 0.352 | 2       |
	| AccessAStaticObjectFromShareContextOneScenarioTwo             | dtyjdtyjf                      | Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextOneFeature.AccessAStaticObjectFromShareContextOneScenarioTwo | True     | Success | True    | 0.001 | 2       |
	| AccessAStaticObjectFromShareContextTwoScenarioOne             | ShareContextTwoFeature         | Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextTwoFeature.AccessAStaticObjectFromShareContextTwoScenarioOne | True     | srfjyj  | True    | 0.002 | 2       |
	| AccessAStaticObjectFromShareContextTwoScenarioTwo             | ShareContextTwoFeature         | Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextTwoFeature.AccessAStaticObjectFromShareContextTwoScenarioTwo | True     | Success | True    | 0.001 | 2       |
	| QuoteRequestForAnInvalidCurrencySymbolReceivesAQuote          | QuoteRequestAndResponseFeature | FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.hwtrhwrjsrtjwrj                                                    | True     | Error   | False   | 0.058 | 0       |
	| QuoteRequestForAnInvalidCurrencySymbolReceivesAQuoteRejection | QuoteRequestAndResponseFeature | FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAnInvalidCurrencySymbolReceivesAQuoteRejection      | True     | Success | True    | 0.008 | 3       |
	| QuoteRequestForAValidCurrencySymbolReceivesAQuote             | QuoteRequestAndResponseFeature | FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAValidCurrencySymbolReceivesAQuote                  | True     | Success | True    | 0.009 | 1       |

#More data will be needed to test this functionality properly!
Scenario: Find a test case by tag name
	When I parse the xml test result file as a test-suite collection
	Then the following test cases are found for these test suites keyed by containing a "tags" value:
	| tags      | test case short name                                 | test suite name                |
	| @negative | QuoteRequestForAnInvalidCurrencySymbolReceivesAQuote | QuoteRequestAndResponseFeature |

Scenario: Find a test case with a test failure
	When I parse the xml test result file as a test-suite collection
	Then the following test cases are found for these test suites keyed by "test case short name":
	| test case short name                                 | message                                                                                            |
	| QuoteRequestForAnInvalidCurrencySymbolReceivesAQuote | System.Collections.Generic.KeyNotFoundException : The given key was not present in the dictionary. |

Scenario: Load an xml result file and find culture-info
	When I parse the xml test result file as culture-info
	Then a single culture-info object exists
		And a culture-info with a "currentculture" attribute value of "en-GB" exists
		And a culture-info with a "currentuiculture" attribute value of "en-US" exists

###############################################################
####out of scope tests#########################################
###############################################################
#Too faffy to get this working alongside a proper parsing of the same xml doc
#Scenario: File Is Loaded
#	Then the xml has a content that can be read as a string

#using the nunit results.xsd doesn't work either
#Scenario: Load an xml result file and find an NUnit Schema test result
#	When I parse the xml test result file as Nunit schema test-results
#	Then test-results with a "name" attribute value of "C:\svn\local\BakeryDemoTest\trunk\AllBakeryDemoTestProjects\FIX_SpecflowTests\bin\Release\FIX_SpecflowTests.dll" exists
