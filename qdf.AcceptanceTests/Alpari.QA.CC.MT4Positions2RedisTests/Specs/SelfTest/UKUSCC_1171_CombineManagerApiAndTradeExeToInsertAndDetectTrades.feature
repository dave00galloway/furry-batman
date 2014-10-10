@Mt4ArsPositionsContext @UKUSCC_1171
Feature: UKUSCC_1171_CombineManagerApiAndTradeExeToInsertAndDetectTradesLoadedFromFile
	In order to bulk load trades into MT4
	As a CC tester
	I want to enter trades and sync on insert finishing

Background: Setup Mt4CompositeApi
	Given I have the following connection parameters for the Mt4CompositeApi:-
		| server           | login | password |
		| 10.10.144.25:443 | 95    | 1q2w3e   |
	#Given I have a connection to a redis repository on "uk-redis-dev.corp.alpari.com" port 6379 db 0 namespace "alpari-positions"
	#And I have a connection to Mt4ArsPositionsContext
	##When I get all positions for server "MT4Test-Demo-Pro" opened from '2014/09/02 00:00:00'	
	#When I get all positions for server "ProTest" opened from '2014/09/02 00:00:00'	
	#And I query for open positions after "2014-09-01" on "ars_test_AUKP01"

Scenario: BackupScenario - old load test format should still work
	When I bulk load trades into MT4:-
		| login      | tradeInstruction                       | quantity |
		| 1000000001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000001000 | buy volume=345 symbol=EURUSD price=1.5 | 100      |


Scenario: Add Trades in parallel then close all positions for login and reconcile
	When I bulk load trades into MT4:-
		| login | tradeInstruction | quantity | fileNamePath                      | threads |
		|       |                  |          | TestData\100InsertsFor2Logins.csv | 200     |


Scenario: Add 15 Trades in parallel then close all positions for login and reconcile
	When I bulk load trades into MT4:-
		| login | tradeInstruction | quantity | fileNamePath                    | threads |
		|       |                  |          | TestData\5InsertsFor3Logins.csv | 200     |


Scenario: Add 30 Trades in parallel in groups then close all positions for login and reconcile
	When I bulk load trades into MT4:-
		| login | tradeInstruction | quantity | fileNamePath                             | threads |
		|       |                  |          | TestData\2GroupsOf5InsertsFor3Logins.csv | 200     |

Scenario: Add 100k Trades in parallel then close all positions for login and reconcile
	When I bulk load trades into MT4:-
		| login | tradeInstruction | quantity | fileNamePath                         | threads |
		|       |                  |          | TestData\100InsertsFor1000Logins.csv | 500     |

Scenario: Bulk Close Trades in parallel then reconcile
	When I bulk close trades in MT4 for these logins:-
	| login      |
	| 1000000001 |
	| 1000010240 |
	#| 1000010240 |

Scenario: Bulk Close Trades in parallel using start and stop logins then reconcile
	When I bulk close trades in MT4 for these logins:-
	| startLogin | endLogin   | threads |
	| 1000000001 | 1000001000 | 50      |
