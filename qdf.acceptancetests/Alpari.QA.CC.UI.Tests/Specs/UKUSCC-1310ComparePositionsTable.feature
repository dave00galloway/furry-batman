@UKUSCC_1310
Feature: UKUSCC-1310ComparePositionsTable
In order to check the CC UI is displaying the correct data
as a tester
I want to compare the positions table in different CC environments

#note skipping actual login for moment
Scenario: Open CC UI
	Given I have opened the cc url "https://webportal.corp.alpari.com/CC_UAT"
	Then the position table is displayed

