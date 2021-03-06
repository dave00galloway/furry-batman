﻿@UKUSCC_1310 @IPositionTablePageObject @IWebdriverCore
Feature: UKUSCC-1310ComparePositionsTable
In order to check the CC UI is displaying the correct data
as a tester
I want to compare the positions table in different CC environments

#note skipping actual login for moment
Scenario: Open CC UI
	Given I have opened the cc url "https://webportal.corp.alpari.com/CC_UAT"
	Then the position table is displayed

	#note manually selecting the servers, book and types for now
Scenario: Get A Book Positions
	Given I have opened the cc url "https://webportal.corp.alpari.com/CC_UAT"
	When I get the positions
	Then The count of servers is 33
	And the count of symbols is at least 60

	#note manually selecting the servers, book and types for now
Scenario: Compare A Book Positions
	Given I have opened the cc url "https://webportal.corp.alpari.com/CC_UAT"
	When I compare the positions

