@Mt4ArsPositionsContext
Feature: GetPositionsFromArs
	In order to cross check redis positions
	As a CC Tester
	I want to query ARS databases for positions

Scenario: Query Database For Position
	Given I have a connection to Mt4ArsPositionsContext
	When I query for open positions after "2014-09-01" on "ars_test_AUKP01"
	Then at least 1 position is returned for login "7003713" on "ars_test_AUKP01"
