@Mt4ArsPositionsContext
Feature: CombineManagerApiAndTradeExeToInsertAndDetectTrades
	In order to bulk load trades into MT4
	As a CC tester
	I want to enter trades and sync on insert finishing

Background: Setup Mt4CompositeApi
	Given I have the following connection parameters for the Mt4CompositeApi:-
		| server           | login | password |
		| 10.10.144.25:443 | 95    | 1q2w3e   |
	Given I have a connection to a redis repository on "localhost" port 6379 db 0
	And I have a connection to Mt4ArsPositionsContext
	#When I get all positions for server "MT4Test-Demo-Pro" opened from '2014/09/02 00:00:00'	
	When I get all positions for server "ProTest" opened from '2014/09/02 00:00:00'	
	And I query for open positions after "2014-09-01" on "ars_test_AUKP01"

Scenario: Bulk load identical trades and sync on insert completion
	When I bulk load trades into MT4:-
		| login   | tradeInstruction                       | quantity | fileNamePath |
		| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 5        |              |
	Then the count of open trades for login "7003906" will increase by 5

Scenario: Bulk load identical trades and sync on insert completion and reconcile redis and Ars
	When I bulk load trades into MT4:-
		| login   | tradeInstruction                       | quantity | fileNamePath |
		| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 5        |              |
	And I compare the "ProTest" positions with the "ars_test_AUKP01" positions excluding these fields:
		 | ExcludedFields |
		 | Timestamp      |
		 | OpenTime       |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |


Scenario: Add Trades then close all positions for login and reconcile
	When I bulk load trades into MT4:-
		| login   | tradeInstruction                       | quantity | fileNamePath | threads |
		| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 50       |              |         |
	Then the count of open trades for login "7003906" will increase by 50
	When I close all positions for login "7003906"
	Then the count of open trades for login "7003906" will be 0
	When I get all positions for server "ProTest" opened from '2014/09/02 00:00:00'	
	And I query for open positions after "2014-09-01" on "ars_test_AUKP01"
	And I compare the "ProTest" positions with the "ars_test_AUKP01" positions excluding these fields:
		 | ExcludedFields |
		 | Timestamp      |
		 | OpenTime       |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Add Trades in parallel then close all positions for login and reconcile
	When I bulk load trades into MT4:-
		| login   | tradeInstruction                       | quantity | fileNamePath | threads |
		| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 150      |              | 64      |
	Then the count of open trades for login "7003906" will increase by 500
	When I close all positions for login "7003906"
	Then the count of open trades for login "7003906" will be 0
	When I get all positions for server "ProTest" opened from '2014/09/02 00:00:00'	
	And I query for open positions after "2014-09-01" on "ars_test_AUKP01"
	And I compare the "ProTest" positions with the "ars_test_AUKP01" positions excluding these fields:
		 | ExcludedFields |
		 | Timestamp      |
		 | OpenTime       |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
