@Reporting
Feature: SpecflowNunitTextReportParser
	In order to provide detailed log info in te test results
	As a tester
	I want the nunit report parser to match up the text output with the xml output

Background:	Load Xml to a generic parser
	Given I have an xml test result file
	"""
	TestData\TaggedTestResult.xml
	"""
	And I have a text test result file "TestData\TaggedTestResult.txt"

Scenario: Load an xml result file and find test cases by test case name
	When I parse the xml test result file as a test-suite collection
	Then the following test cases are found for these test suites keyed by "Test case name":
	| Test case short name | Test suite name                      | Test case name                                                                                          | Executed | Result       | Success | Time  | Asserts |
	| FailingTestOne       | CreateMixtureOfTestResults001Feature | Alpari.QualityAssurance.SpecFlowExtensions.Specs.CreateMixtureOfTestResults001Feature.FailingTestOne    | True     | Failure      | False   | 0.477 | 1       |
	| PassingTestOne       | CreateMixtureOfTestResults001Feature | Alpari.QualityAssurance.SpecFlowExtensions.Specs.CreateMixtureOfTestResults001Feature.PassingTestOne    | True     | Success      | True    | 0.005 | 1       |
	| PendingTestOne       | CreateMixtureOfTestResults001Feature | Alpari.QualityAssurance.SpecFlowExtensions.Specs.CreateMixtureOfTestResults001Feature.PendingTestOne    | True     | Inconclusive | False   | 0.162 | 0       |
	| PendingTestTwo       | CreateMixtureOfTestResults001Feature | Alpari.QualityAssurance.SpecFlowExtensions.Specs.CreateMixtureOfTestResults001Feature.PendingTestTwo    | True     | Inconclusive | False   | 0.006 | 0       |
	| FailingTestOne       | CreateMixtureOfTestResults002Feature | Alpari.QualityAssurance.SpecFlowExtensions.Specs.CreateMixtureOfTestResults002Feature.FailingTestOne    | True     | Failure      | False   | 0.003 | 1       |
	| PassingTestOne       | CreateMixtureOfTestResults002Feature | Alpari.QualityAssurance.SpecFlowExtensions.Specs.CreateMixtureOfTestResults002Feature.PassingTestOne    | True     | Success      | True    | 0.001 | 1       |
	| PassingTestOneTwo    | CreateMixtureOfTestResults002Feature | Alpari.QualityAssurance.SpecFlowExtensions.Specs.CreateMixtureOfTestResults002Feature.PassingTestOneTwo | True     | Success      | True    | 0.001 | 1       |
	| PendingTestOneTwo    | CreateMixtureOfTestResults002Feature | Alpari.QualityAssurance.SpecFlowExtensions.Specs.CreateMixtureOfTestResults002Feature.PendingTestOneTwo | True     | Inconclusive | False   | 0.003 | 0       |
	| PendingTestTwoTwo    | CreateMixtureOfTestResults002Feature | Alpari.QualityAssurance.SpecFlowExtensions.Specs.CreateMixtureOfTestResults002Feature.PendingTestTwoTwo | True     | Inconclusive | False   | 0.002 | 0       |

Scenario: Load a text file
	Then the text file parser contains some text

Scenario: Load a text file and check test cases are present
	When I parse the text test result file as a test-suite collection
	Then the text file parser contains some test cases

Scenario: Load a text file and check test cases with tags are present
	When I parse the text test result file as a test-suite collection
	Then the text file parser contains some test cases with tags

Scenario: Load a text file and check test cases with a primary tag are present
	When I parse the text test result file as a test-suite collection
	Then the text file parser contains some test cases with a primary tag

Scenario: Load a text result file and find test cases by tag
	When I parse the xml test result file as a test-suite collection
	And I parse the text test result file as a test-suite collection
	Then the following test case text results are found for these test suites keyed by containing a "Tags" value:
	| Tags    | Test case short name | Test suite name                      |
	| @TES-84 | PendingTestTwoTwo    | CreateMixtureOfTestResults002Feature |

#@TES-1000
#Scenario: Why Do We need to underscore the tags
#	When I parse the xml test result file as a test-suite collection
# Specflow throws an error
#Test Name:	WhyDoWeNeedToUnderscoreTheTags
#Test FullName:	Alpari.QualityAssurance.SpecFlowExtensions.Specs.SpecflowNunitTextReportParserFeature.WhyDoWeNeedToUnderscoreTheTags
#Test Source:	c:\svn\local\BakeryDemoTest\trunk\AllBakeryDemoTestProjects\Alpari.QualityAssurance.SpecFlowExtensions\Specs\SpecflowNunitTextReportParser.feature : line 7
#Test Outcome:	Failed
#Test Duration:	0:00:00.001
#
#Result Message:	Category name must not contain ',', '!', '+' or '-'
#
