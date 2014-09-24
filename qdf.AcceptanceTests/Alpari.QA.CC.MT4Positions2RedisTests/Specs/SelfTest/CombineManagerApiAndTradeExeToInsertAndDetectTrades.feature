@Mt4ArsPositionsContext
Feature: CombineManagerApiAndTradeExeToInsertAndDetectTrades
	In order to bulk load trades into MT4
	As a CC tester
	I want to enter trades and sync on insert finishing

Background: Setup Mt4CompositeApi
	Given I have the following connection parameters for the Mt4CompositeApi:-
		| server           | login | password |
		| 10.10.144.25:443 | 95    | 1q2w3e   |
	Given I have a connection to a redis repository on "localhost" port 6379 db 0 namespace "alpari-positions"
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
		# | OpenTime       |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |


Scenario: Add Trades then close all positions for login and reconcile
	When I bulk load trades into MT4:-
		| login   | tradeInstruction                       | quantity | fileNamePath | threads |
		| 7004066 | buy volume=345 symbol=EURUSD price=1.5 | 5        |              |         |
	Then the count of open trades for login "7003906" will increase by 5
	When I close all positions for login "7003906"
	Then the count of open trades for login "7003906" will be 0
	When I get all positions for server "ProTest" opened from '2014/09/02 00:00:00'	
	And I query for open positions after "2014-09-01" on "ars_test_AUKP01"
	And I compare the "ProTest" positions with the "ars_test_AUKP01" positions excluding these fields:
		 | ExcludedFields |
		 | Timestamp      |
		 #| OpenTime       |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

#This approach can't work when using a single account as the threads will interfere with each other, 
#and the Mt4CompositeApi property won't have been populated
#Scenario: Add Trades in parallel then close all positions for login and reconcile
#	When I bulk load trades into MT4:-
#		| login   | tradeInstruction                       | quantity | fileNamePath | threads |
#		| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 150      |              | 64      |
#	Then the count of open trades for login "7003906" will increase by 500
#	When I close all positions for login "7003906"
#	Then the count of open trades for login "7003906" will be 0
#	When I get all positions for server "ProTest" opened from '2014/09/02 00:00:00'	
#	And I query for open positions after "2014-09-01" on "ars_test_AUKP01"
#	And I compare the "ProTest" positions with the "ars_test_AUKP01" positions excluding these fields:
#		 | ExcludedFields |
#		 | Timestamp      |
#		 | OpenTime       |
#	Then the redis positions should match the ars positions exactly:-
#		| ExportType     |  Overwrite |
#		| DataTableToCsv |  true      |

Scenario: Add Trades in parallel then close all positions for login and reconcile
	When I bulk load trades into MT4:-
		| login   | tradeInstruction                       | quantity |
		| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004130 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004129 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004128 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004127 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004126 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004125 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004124 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004123 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004122 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004121 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004120 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004119 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004118 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004117 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004116 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004115 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004114 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004113 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004112 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004111 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004110 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004109 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004108 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004107 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004106 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004105 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004104 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004103 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004102 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004101 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004100 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004099 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004098 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004097 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004096 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004095 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004094 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004093 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004092 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004091 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004090 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004089 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004088 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004087 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004086 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004085 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004084 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004083 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004082 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004081 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004080 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004079 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004078 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004077 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004076 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004075 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004074 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004073 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004072 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004071 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004070 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004069 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 7004068 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004130 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004129 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004128 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004127 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004126 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004125 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004124 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004123 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004122 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004121 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004120 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004119 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004118 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004117 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004116 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004115 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004114 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004113 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004112 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004111 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004110 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004109 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004108 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004107 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004106 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004105 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004104 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004103 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004102 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004101 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004100 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004099 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004098 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004097 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004096 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004095 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004094 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004093 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004092 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004091 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004090 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004089 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004088 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004087 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004086 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004085 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004084 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004083 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004082 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004081 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004080 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004079 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004078 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004077 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004076 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004075 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004074 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004073 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004072 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004071 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004070 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004069 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004068 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004130 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004129 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004128 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004127 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004126 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004125 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004124 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004123 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004122 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004121 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004120 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004119 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004118 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004117 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004116 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004115 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004114 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004113 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004112 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004111 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004110 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004109 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004108 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004107 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004106 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004105 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004104 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004103 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004102 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004101 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004100 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004099 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004098 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004097 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004096 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004095 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004094 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004093 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004092 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004091 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004090 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004089 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004088 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004087 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004086 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004085 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004084 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004083 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004082 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004081 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004080 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004079 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004078 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004077 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004076 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004075 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004074 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004073 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004072 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004071 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004070 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004069 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004068 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7003906 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004130 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004129 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004128 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004127 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004126 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004125 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004124 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004123 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004122 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004121 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004120 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004119 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004118 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004117 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004116 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004115 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004114 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004113 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004112 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004111 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004110 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004109 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004108 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004107 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004106 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004105 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004104 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004103 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004102 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004101 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004100 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004099 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004098 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004097 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004096 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004095 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004094 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004093 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004092 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004091 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004090 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004089 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004088 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004087 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004086 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004085 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004084 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004083 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004082 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004081 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004080 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004079 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004078 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004077 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004076 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004075 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004074 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004073 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004072 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004071 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004070 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004069 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		#| 7004068 | buy volume=345 symbol=EURUSD price=1.5 | 150      |

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

Scenario: Bulk Close Trades in parallel then reconcile
	When I bulk close trades in MT4 for these logins:-
	| login   |
	| 7003906 |
	| 7004130 |
	| 7004129 |
	| 7004128 |
	| 7004127 |
	| 7004126 |
	| 7004125 |
	| 7004124 |
	| 7004123 |
	| 7004122 |
	| 7004121 |
	| 7004120 |
	| 7004119 |
	| 7004118 |
	| 7004117 |
	| 7004116 |
	| 7004115 |
	| 7004114 |
	| 7004113 |
	| 7004112 |
	| 7004111 |
	| 7004110 |
	| 7004109 |
	| 7004108 |
	| 7004107 |
	| 7004106 |
	| 7004105 |
	| 7004104 |
	| 7004103 |
	| 7004102 |
	| 7004101 |
	| 7004100 |
	| 7004099 |
	| 7004098 |
	| 7004097 |
	| 7004096 |
	| 7004095 |
	| 7004094 |
	| 7004093 |
	| 7004092 |
	| 7004091 |
	| 7004090 |
	| 7004089 |
	| 7004088 |
	| 7004087 |
	| 7004086 |
	| 7004085 |
	| 7004084 |
	| 7004083 |
	| 7004082 |
	| 7004081 |
	| 7004080 |
	| 7004079 |
	| 7004078 |
	| 7004077 |
	| 7004076 |
	| 7004075 |
	| 7004074 |
	| 7004073 |
	| 7004072 |
	| 7004071 |
	| 7004070 |
	| 7004069 |
	| 7004068 |
