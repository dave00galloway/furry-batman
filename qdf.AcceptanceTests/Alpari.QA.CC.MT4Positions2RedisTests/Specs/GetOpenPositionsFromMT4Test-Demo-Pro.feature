@UKUSCC_1014
Feature: UKUSCC-1014_AT_MT4Test-Demo-Pro
	In order to test MT4Positions2Redis
	As a CC Tester
	I want to be able to query redis positions

#currently assumes 1 or more manually entered trades
#limit by open date since there are a lot of garbage trades in the MT4 db which aren't in ars
Background: get positions
	Given I have a connection to a redis repository on "localhost" port 6379 db 0
	When I get all positions for server "MT4Test-Demo-Pro" opened from '2014/09/02 00:00:00'
	#When I get all positions for server "MT4Test-Demo-Pro"
	
Scenario: Get open positions
	Then at least 1 position is for login 111196738

#Scenario: convert open positions
#	When I convert open positions to testable positions
#	Then at least 1 position has an OpenTime of "2014/09/02 11:59:57"