Feature: ArsQdfReconciliationWithLoadedFiles
	In order to test the reconciliation functionality
	As a tester
	I want to be able to re-use the same input data

@mytag
Scenario: Load Test Data and Compare
	Given I have loaded QDF deal data from "TestData\AllQdfDeals.csv"
	And I have loaded CCTool data from "TestData\CcToolData.csv"
	When I compare the loaded QDF and CC data
	Then the data should not match
