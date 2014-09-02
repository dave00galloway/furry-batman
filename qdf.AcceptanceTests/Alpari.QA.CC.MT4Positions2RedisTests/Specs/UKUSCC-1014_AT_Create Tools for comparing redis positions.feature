@UKUSCC_1014
Feature: UKUSCC-1014_AT_Create Tools for comparing redis positions
	In order to test MT4Positions2Redis
	As a CC Tester
	I want to be able to query redis positions

#currently assumes 1 or more manually entered trades
Scenario: Get open positions
	Given I have entered 50 into the calculator
	And I have entered 70 into the calculator
	When I press add
	Then the result should be 120 on the screen
