@textToXmlReconciliation
Feature: CreateMixtureOfTestResults001
	In order to prove test text results can be matched to test xml results
	As a test engineer
	I want to generate a spread of test results of diiferent types

@TES_77 @UAT
Scenario: Passing test one
	Given I access the static object
	When I display the static object "randomFileName" property
	Then the static object "randomFileName" property matches the feature "randomFileName" property

@TES_78 @negative @UAT
Scenario: Pending test one
	Given I access the static object
	When I call an undefined step
	Then the static object "randomFileName" property matches the feature "randomFileName" property

@TES_79 @negative @UAT
Scenario: Pending test two
	Given I access the static object
	When I call a pending step
	Then the static object "randomFileName" property matches the feature "randomFileName" property

@TES_80 @negative @UAT
Scenario: failing test one
	Given I access the static object
	When I call a failing step
	Then the static object "randomFileName" property matches the feature "randomFileName" property
