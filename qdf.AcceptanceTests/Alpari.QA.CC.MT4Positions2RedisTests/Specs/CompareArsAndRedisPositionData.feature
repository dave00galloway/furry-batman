@Mt4ArsPositionsContext
Feature: CompareArsAndRedisPositionData
	In order to test redis positions
	As a CC Tester
	I want to be able to compare redis positions with Ars Positions

#currently assumes 1 or more manually entered trades
#limit by open date since there are a lot of garbage trades in the MT4 db which aren't in ars
Background: get positions
	Given I have a connection to a redis repository on "localhost" port 6379 db 0
	And I have a connection to Mt4ArsPositionsContext
	#When I get all positions for server "MT4Test-Demo-Pro" opened from '2014/09/02 00:00:00'	
	When I get all positions for server "ProTest" opened from '2014/09/02 00:00:00'	
	And I query for open positions after "2014-09-01" on "ars_test_AUKP01"
	
Scenario: Get open positions
	Then at least 1 position is for login 111196738
	And at least 1 position is returned for login "7003713" on "ars_test_AUKP01"

Scenario: Compare open positions
	#And I compare the "MT4Test-Demo-Pro" positions with the "ars_test_AUKP01" positions excluding these fields:
	And I compare the "ProTest" positions with the "ars_test_AUKP01" positions excluding these fields:
		 | ExcludedFields |
		 | Timestamp      |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |


	#	And I compare the cnx hub trade deals with the qdf deal data excluding these fields:
	#	 | ExcludedFields |
	#	 | Comment        |
	#	 | AccountGroup   |
	#	 | Book           |
	#	 | OrderId        |
	#	 | State          |
	#Then the cnx hub trade deals should match the qdf deal data exactly:-
	#	| ExportType     |  Overwrite |
	#	| DataTableToCsv |  true      |


