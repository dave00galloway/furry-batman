@UKUSCC_1014
Feature: UKUSCC-1014_AT_Create Tools for comparing redis positions
	In order to test MT4Positions2Redis
	As a CC Tester
	I want to be able to query redis positions

#currently assumes 1 or more manually entered trades
Scenario: Get open positions
	Given I have a connection to a redis repository on "localhost" port 6379 db 0
	When I get all positions for server "ProTest"
	Then at least 1 position is for login 7003713
