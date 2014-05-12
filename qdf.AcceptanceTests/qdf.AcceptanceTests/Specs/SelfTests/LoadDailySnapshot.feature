Feature: LoadDataOnce
	In order to avoid multiple data loads
	As a tester
	I want to be to load data once for a feature and have it available for all scenarios

Background:Load data
	Given I have already loaded QDF deal data from "TestData\AllQdfDeals.csv"
	And I have already loaded CCTool data from "TestData\CcToolData.csv"
	And I have already aggregated the QdfDeal Data and CcToolData

@mytag
Scenario: Load Test Data and Check it's there
	Then there are 350 deals in AllQdfDeals and 3722 records in CcToolData

Scenario: Load Test Data and Check it's there again
	Then there are 350 deals in AllQdfDeals and 3722 records in CcToolData

