@Mt4ArsPositionsContext
Feature: CombineManagerApiAndTradeExeToInsertAndDetectTrades
	In order to bulk load trades into MT4
	As a CC tester
	I want to enter trades and sync on insert finishing

Background: Setup Mt4CompositeApi
	Given I have the following connection parameters for the Mt4CompositeApi:-
		| server           | login | password |
		| 10.10.144.54:443 | 95    | 1q2w3e   |
	#Given I have a connection to a redis repository on "uk-redis-dev.corp.alpari.com" port 6379 db 0 namespace "alpari-positions"
	#And I have a connection to Mt4ArsPositionsContext
	##When I get all positions for server "MT4Test-Demo-Pro" opened from '2014/09/02 00:00:00'	
	#When I get all positions for server "ProTest" opened from '2014/09/02 00:00:00'	
	#And I query for open positions after "2014-09-01" on "ars_test_AUKP01"

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
		| login      | tradeInstruction                       | quantity |
		| 1000000001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000002 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000003 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000004 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000005 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000006 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000007 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000008 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000009 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000010 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000011 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000012 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000013 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000014 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000015 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000016 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000017 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000018 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000019 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000020 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000021 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000022 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000023 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000024 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000025 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000026 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000027 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000028 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000029 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000030 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000031 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000032 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000033 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000034 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000035 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000036 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000037 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000038 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000039 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000040 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000041 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000042 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000043 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000044 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000045 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000046 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000047 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000048 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000049 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000050 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000051 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000052 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000053 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000054 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000055 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000056 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000057 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000058 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000059 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000060 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000061 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000062 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000063 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000064 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000065 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000066 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000067 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000068 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000069 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000070 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000071 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000072 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000073 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000074 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000075 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000076 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000077 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000078 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000079 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000080 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000081 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000082 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000083 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000084 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000085 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000086 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000087 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000088 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000089 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000090 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000091 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000092 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000093 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000094 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000095 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000096 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000097 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000098 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000099 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000100 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000101 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000102 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000103 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000104 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000105 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000106 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000107 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000108 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000109 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000110 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000111 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000112 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000113 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000114 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000115 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000116 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000117 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000118 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000119 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000120 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000121 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000122 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000123 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000124 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000125 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000126 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000127 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000128 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000129 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000130 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000131 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000132 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000133 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000134 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000135 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000136 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000137 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000138 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000139 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000140 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000141 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000142 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000143 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000144 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000145 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000146 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000147 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000148 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000149 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000150 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000151 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000152 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000153 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000154 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000155 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000156 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000157 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000158 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000159 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000160 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000161 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000162 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000163 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000164 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000165 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000166 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000167 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000168 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000169 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000170 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000171 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000172 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000173 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000174 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000175 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000176 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000177 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000178 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000179 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000180 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000181 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000182 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000183 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000184 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000185 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000186 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000187 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000188 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000189 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000190 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000191 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000192 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000193 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000194 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000195 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000196 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000197 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000198 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000199 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000200 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000201 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000202 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000203 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000204 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000205 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000206 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000207 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000208 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000209 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000210 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000211 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000212 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000213 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000214 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000215 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000216 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000217 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000218 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000219 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000220 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000221 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000222 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000223 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000224 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000225 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000226 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000227 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000228 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000229 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000230 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000231 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000232 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000233 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000234 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000235 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000236 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000237 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000238 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000239 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000240 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000241 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000242 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000243 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000244 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000245 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000246 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000247 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000248 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000249 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000250 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000251 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000252 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000253 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000254 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000255 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000256 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000257 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000258 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000259 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000260 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000261 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000262 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000263 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000264 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000265 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000266 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000267 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000268 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000269 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000270 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000271 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000272 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000273 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000274 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000275 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000276 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000277 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000278 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000279 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000280 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000281 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000282 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000283 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000284 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000285 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000286 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000287 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000288 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000289 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000290 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000291 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000292 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000293 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000294 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000295 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000296 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000297 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000298 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000299 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000300 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000301 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000302 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000303 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000304 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000305 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000306 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000307 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000308 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000309 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000310 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000311 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000312 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000313 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000314 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000315 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000316 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000317 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000318 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000319 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000320 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000321 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000322 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000323 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000324 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000325 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000326 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000327 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000328 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000329 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000330 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000331 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000332 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000333 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000334 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000335 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000336 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000337 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000338 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000339 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000340 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000341 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000342 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000343 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000344 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000345 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000346 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000347 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000348 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000349 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000350 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000351 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000352 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000353 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000354 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000355 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000356 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000357 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000358 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000359 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000360 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000361 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000362 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000363 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000364 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000365 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000366 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000367 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000368 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000369 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000370 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000371 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000372 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000373 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000374 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000375 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000376 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000377 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000378 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000379 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000380 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000381 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000382 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000383 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000384 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000385 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000386 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000387 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000388 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000389 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000390 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000391 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000392 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000393 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000394 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000395 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000396 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000397 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000398 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000399 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000400 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000401 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000402 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000403 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000404 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000405 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000406 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000407 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000408 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000409 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000410 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000411 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000412 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000413 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000414 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000415 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000416 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000417 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000418 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000419 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000420 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000421 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000422 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000423 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000424 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000425 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000426 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000427 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000428 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000429 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000430 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000431 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000432 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000433 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000434 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000435 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000436 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000437 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000438 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000439 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000440 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000441 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000442 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000443 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000444 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000445 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000446 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000447 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000448 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000449 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000450 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000451 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000452 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000453 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000454 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000455 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000456 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000457 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000458 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000459 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000460 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000461 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000462 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000463 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000464 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000465 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000466 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000467 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000468 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000469 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000470 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000471 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000472 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000473 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000474 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000475 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000476 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000477 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000478 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000479 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000480 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000481 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000482 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000483 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000484 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000485 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000486 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000487 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000488 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000489 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000490 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000491 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000492 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000493 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000494 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000495 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000496 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000497 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000498 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000499 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000500 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000501 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000502 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000503 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000504 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000505 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000506 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000507 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000508 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000509 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000510 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000511 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000512 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000513 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000514 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000515 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000516 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000517 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000518 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000519 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000520 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000521 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000522 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000523 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000524 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000525 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000526 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000527 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000528 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000529 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000530 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000531 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000532 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000533 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000534 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000535 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000536 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000537 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000538 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000539 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000540 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000541 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000542 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000543 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000544 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000545 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000546 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000547 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000548 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000549 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000550 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000551 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000552 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000553 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000554 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000555 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000556 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000557 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000558 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000559 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000560 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000561 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000562 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000563 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000564 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000565 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000566 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000567 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000568 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000569 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000570 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000571 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000572 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000573 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000574 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000575 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000576 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000577 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000578 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000579 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000580 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000581 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000582 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000583 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000584 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000585 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000586 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000587 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000588 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000589 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000590 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000591 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000592 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000593 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000594 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000595 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000596 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000597 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000598 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000599 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000600 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000601 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000602 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000603 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000604 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000605 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000606 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000607 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000608 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000609 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000610 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000611 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000612 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000613 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000614 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000615 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000616 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000617 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000618 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000619 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000620 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000621 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000622 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000623 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000624 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000625 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000626 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000627 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000628 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000629 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000630 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000631 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000632 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000633 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000634 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000635 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000636 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000637 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000638 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000639 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000640 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000641 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000642 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000643 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000644 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000645 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000646 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000647 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000648 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000649 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000650 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000651 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000652 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000653 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000654 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000655 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000656 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000657 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000658 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000659 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000660 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000661 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000662 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000663 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000664 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000665 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000666 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000667 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000668 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000669 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000670 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000671 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000672 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000673 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000674 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000675 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000676 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000677 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000678 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000679 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000680 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000681 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000682 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000683 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000684 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000685 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000686 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000687 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000688 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000689 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000690 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000691 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000692 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000693 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000694 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000695 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000696 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000697 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000698 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000699 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000700 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000701 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000702 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000703 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000704 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000705 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000706 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000707 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000708 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000709 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000710 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000711 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000712 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000713 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000714 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000715 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000716 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000717 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000718 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000719 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000720 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000721 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000722 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000723 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000724 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000725 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000726 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000727 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000728 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000729 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000730 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000731 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000732 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000733 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000734 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000735 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000736 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000737 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000738 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000739 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000740 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000741 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000742 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000743 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000744 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000745 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000746 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000747 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000748 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000749 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000750 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000751 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000752 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000753 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000754 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000755 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000756 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000757 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000758 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000759 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000760 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000761 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000762 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000763 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000764 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000765 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000766 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000767 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000768 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000769 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000770 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000771 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000772 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000773 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000774 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000775 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000776 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000777 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000778 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000779 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000780 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000781 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000782 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000783 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000784 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000785 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000786 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000787 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000788 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000789 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000790 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000791 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000792 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000793 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000794 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000795 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000796 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000797 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000798 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000799 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000800 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000801 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000802 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000803 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000804 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000805 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000806 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000807 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000808 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000809 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000810 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000811 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000812 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000813 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000814 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000815 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000816 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000817 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000818 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000819 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000820 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000821 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000822 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000823 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000824 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000825 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000826 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000827 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000828 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000829 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000830 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000831 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000832 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000833 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000834 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000835 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000836 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000837 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000838 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000839 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000840 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000841 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000842 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000843 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000844 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000845 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000846 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000847 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000848 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000849 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000850 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000851 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000852 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000853 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000854 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000855 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000856 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000857 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000858 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000859 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000860 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000861 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000862 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000863 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000864 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000865 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000866 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000867 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000868 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000869 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000870 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000871 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000872 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000873 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000874 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000875 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000876 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000877 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000878 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000879 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000880 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000881 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000882 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000883 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000884 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000885 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000886 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000887 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000888 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000889 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000890 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000891 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000892 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000893 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000894 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000895 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000896 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000897 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000898 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000899 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000900 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000901 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000902 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000903 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000904 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000905 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000906 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000907 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000908 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000909 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000910 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000911 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000912 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000913 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000914 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000915 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000916 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000917 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000918 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000919 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000920 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000921 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000922 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000923 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000924 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000925 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000926 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000927 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000928 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000929 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000930 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000931 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000932 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000933 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000934 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000935 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000936 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000937 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000938 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000939 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000940 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000941 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000942 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000943 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000944 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000945 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000946 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000947 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000948 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000949 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000950 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000951 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000952 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000953 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000954 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000955 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000956 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000957 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000958 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000959 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000960 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000961 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000962 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000963 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000964 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000965 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000966 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000967 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000968 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000969 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000970 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000971 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000972 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000973 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000974 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000975 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000976 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000977 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000978 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000979 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000980 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000981 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000982 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000983 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000984 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000985 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000986 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000987 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000988 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000989 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000990 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000991 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000992 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000993 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000994 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000995 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000996 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000997 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000998 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000000999 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		| 1000001000 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001002 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001003 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001004 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001005 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001006 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001007 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001008 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001009 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001010 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001011 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001012 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001013 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001014 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001015 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001016 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001017 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001018 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001019 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001020 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001021 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001022 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001023 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001024 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001025 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001026 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001027 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001028 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001029 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001030 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001031 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001032 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001033 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001034 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001035 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001036 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001037 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001038 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001039 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001040 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001041 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001042 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001043 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001044 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001045 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001046 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001047 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001048 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001049 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001050 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001051 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001052 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001053 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001054 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001055 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001056 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001057 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001058 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001059 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001060 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001061 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001062 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001063 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001064 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001065 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001066 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001067 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001068 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001069 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001070 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001071 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001072 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001073 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001074 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001075 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001076 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001077 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001078 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001079 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001080 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001081 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001082 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001083 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001084 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001085 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001086 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001087 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001088 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001089 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001090 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001091 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001092 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001093 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001094 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001095 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001096 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001097 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001098 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001099 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001100 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001101 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001102 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001103 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001104 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001105 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001106 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001107 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001108 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001109 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001110 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001111 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001112 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001113 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001114 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001115 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001116 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001117 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001118 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001119 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001120 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001121 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001122 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001123 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001124 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001125 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001126 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001127 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001128 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001129 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001130 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001131 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001132 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001133 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001134 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001135 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001136 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001137 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001138 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001139 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001140 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001141 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001142 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001143 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001144 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001145 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001146 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001147 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001148 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001149 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001150 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001151 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001152 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001153 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001154 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001155 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001156 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001157 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001158 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001159 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001160 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001161 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001162 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001163 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001164 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001165 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001166 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001167 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001168 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001169 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001170 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001171 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001172 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001173 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001174 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001175 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001176 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001177 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001178 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001179 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001180 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001181 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001182 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001183 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001184 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001185 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001186 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001187 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001188 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001189 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001190 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001191 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001192 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001193 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001194 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001195 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001196 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001197 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001198 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001199 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001200 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001201 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001202 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001203 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001204 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001205 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001206 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001207 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001208 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001209 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001210 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001211 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001212 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001213 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001214 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001215 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001216 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001217 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001218 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001219 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001220 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001221 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001222 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001223 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001224 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001225 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001226 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001227 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001228 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001229 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001230 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001231 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001232 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001233 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001234 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001235 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001236 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001237 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001238 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001239 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001240 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001241 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001242 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001243 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001244 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001245 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001246 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001247 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001248 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001249 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001250 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001251 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001252 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001253 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001254 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001255 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001256 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001257 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001258 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001259 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001260 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001261 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001262 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001263 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001264 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001265 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001266 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001267 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001268 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001269 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001270 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001271 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001272 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001273 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001274 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001275 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001276 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001277 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001278 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001279 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001280 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001281 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001282 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001283 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001284 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001285 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001286 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001287 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001288 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001289 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001290 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001291 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001292 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001293 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001294 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001295 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001296 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001297 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001298 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001299 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001300 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001301 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001302 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001303 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001304 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001305 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001306 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001307 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001308 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001309 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001310 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001311 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001312 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001313 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001314 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001315 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001316 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001317 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001318 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001319 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001320 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001321 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001322 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001323 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001324 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001325 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001326 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001327 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001328 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001329 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001330 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001331 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001332 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001333 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001334 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001335 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001336 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001337 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001338 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001339 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001340 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001341 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001342 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001343 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001344 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001345 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001346 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001347 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001348 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001349 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001350 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001351 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001352 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001353 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001354 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001355 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001356 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001357 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001358 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001359 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001360 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001361 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001362 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001363 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001364 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001365 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001366 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001367 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001368 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001369 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001370 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001371 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001372 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001373 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001374 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001375 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001376 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001377 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001378 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001379 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001380 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001381 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001382 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001383 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001384 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001385 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001386 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001387 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001388 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001389 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001390 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001391 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001392 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001393 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001394 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001395 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001396 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001397 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001398 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001399 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001400 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001401 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001402 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001403 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001404 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001405 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001406 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001407 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001408 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001409 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001410 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001411 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001412 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001413 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001414 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001415 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001416 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001417 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001418 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001419 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001420 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001421 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001422 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001423 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001424 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001425 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001426 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001427 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001428 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001429 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001430 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001431 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001432 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001433 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001434 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001435 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001436 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001437 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001438 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001439 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001440 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001441 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001442 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001443 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001444 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001445 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001446 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001447 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001448 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001449 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001450 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001451 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001452 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001453 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001454 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001455 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001456 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001457 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001458 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001459 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001460 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001461 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001462 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001463 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001464 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001465 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001466 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001467 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001468 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001469 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001470 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001471 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001472 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001473 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001474 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001475 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001476 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001477 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001478 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001479 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001480 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001481 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001482 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001483 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001484 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001485 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001486 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001487 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001488 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001489 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001490 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001491 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001492 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001493 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001494 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001495 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001496 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001497 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001498 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001499 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001500 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001501 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001502 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001503 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001504 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001505 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001506 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001507 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001508 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001509 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001510 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001511 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001512 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001513 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001514 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001515 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001516 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001517 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001518 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001519 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001520 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001521 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001522 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001523 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001524 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001525 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001526 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001527 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001528 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001529 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001530 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001531 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001532 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001533 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001534 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001535 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001536 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001537 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001538 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001539 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001540 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001541 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001542 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001543 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001544 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001545 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001546 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001547 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001548 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001549 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001550 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001551 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001552 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001553 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001554 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001555 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001556 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001557 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001558 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001559 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001560 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001561 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001562 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001563 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001564 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001565 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001566 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001567 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001568 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001569 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001570 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001571 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001572 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001573 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001574 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001575 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001576 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001577 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001578 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001579 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001580 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001581 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001582 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001583 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001584 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001585 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001586 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001587 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001588 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001589 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001590 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001591 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001592 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001593 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001594 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001595 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001596 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001597 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001598 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001599 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001600 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001601 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001602 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001603 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001604 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001605 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001606 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001607 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001608 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001609 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001610 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001611 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001612 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001613 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001614 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001615 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001616 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001617 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001618 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001619 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001620 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001621 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001622 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001623 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001624 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001625 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001626 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001627 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001628 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001629 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001630 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001631 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001632 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001633 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001634 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001635 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001636 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001637 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001638 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001639 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001640 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001641 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001642 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001643 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001644 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001645 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001646 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001647 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001648 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001649 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001650 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001651 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001652 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001653 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001654 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001655 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001656 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001657 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001658 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001659 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001660 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001661 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001662 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001663 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001664 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001665 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001666 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001667 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001668 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001669 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001670 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001671 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001672 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001673 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001674 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001675 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001676 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001677 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001678 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001679 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001680 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001681 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001682 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001683 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001684 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001685 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001686 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001687 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001688 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001689 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001690 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001691 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001692 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001693 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001694 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001695 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001696 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001697 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001698 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001699 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001700 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001701 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001702 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001703 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001704 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001705 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001706 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001707 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001708 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001709 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001710 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001711 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001712 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001713 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001714 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001715 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001716 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001717 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001718 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001719 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001720 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001721 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001722 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001723 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001724 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001725 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001726 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001727 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001728 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001729 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001730 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001731 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001732 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001733 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001734 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001735 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001736 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001737 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001738 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001739 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001740 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001741 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001742 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001743 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001744 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001745 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001746 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001747 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001748 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001749 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001750 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001751 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001752 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001753 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001754 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001755 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001756 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001757 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001758 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001759 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001760 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001761 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001762 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001763 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001764 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001765 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001766 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001767 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001768 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001769 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001770 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001771 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001772 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001773 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001774 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001775 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001776 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001777 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001778 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001779 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001780 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001781 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001782 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001783 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001784 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001785 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001786 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001787 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001788 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001789 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001790 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001791 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001792 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001793 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001794 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001795 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001796 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001797 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001798 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001799 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001800 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001801 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001802 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001803 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001804 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001805 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001806 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001807 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001808 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001809 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001810 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001811 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001812 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001813 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001814 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001815 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001816 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001817 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001818 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001819 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001820 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001821 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001822 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001823 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001824 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001825 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001826 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001827 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001828 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001829 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001830 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001831 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001832 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001833 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001834 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001835 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001836 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001837 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001838 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001839 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001840 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001841 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001842 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001843 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001844 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001845 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001846 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001847 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001848 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001849 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001850 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001851 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001852 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001853 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001854 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001855 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001856 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001857 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001858 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001859 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001860 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001861 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001862 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001863 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001864 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001865 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001866 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001867 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001868 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001869 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001870 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001871 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001872 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001873 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001874 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001875 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001876 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001877 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001878 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001879 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001880 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001881 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001882 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001883 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001884 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001885 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001886 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001887 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001888 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001889 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001890 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001891 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001892 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001893 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001894 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001895 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001896 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001897 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001898 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001899 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001900 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001901 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001902 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001903 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001904 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001905 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001906 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001907 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001908 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001909 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001910 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001911 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001912 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001913 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001914 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001915 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001916 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001917 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001918 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001919 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001920 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001921 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001922 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001923 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001924 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001925 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001926 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001927 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001928 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001929 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001930 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001931 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001932 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001933 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001934 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001935 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001936 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001937 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001938 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001939 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001940 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001941 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001942 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001943 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001944 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001945 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001946 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001947 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001948 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001949 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001950 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001951 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001952 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001953 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001954 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001955 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001956 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001957 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001958 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001959 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001960 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001961 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001962 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001963 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001964 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001965 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001966 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001967 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001968 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001969 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001970 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001971 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001972 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001973 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001974 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001975 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001976 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001977 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001978 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001979 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001980 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001981 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001982 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001983 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001984 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001985 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001986 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001987 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001988 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001989 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001990 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001991 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001992 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001993 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001994 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001995 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001996 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001997 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001998 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000001999 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002000 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002002 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002003 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002004 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002005 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002006 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002007 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002008 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002009 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002010 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002011 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002012 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002013 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002014 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002015 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002016 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002017 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002018 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002019 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002020 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002021 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002022 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002023 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002024 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002025 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002026 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002027 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002028 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002029 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002030 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002031 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002032 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002033 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002034 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002035 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002036 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002037 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002038 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002039 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002040 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002041 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002042 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002043 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002044 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002045 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002046 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002047 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002048 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002049 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002050 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002051 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002052 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002053 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002054 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002055 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002056 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002057 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002058 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002059 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002060 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002061 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002062 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002063 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002064 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002065 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002066 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002067 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002068 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002069 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002070 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002071 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002072 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002073 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002074 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002075 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002076 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002077 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002078 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002079 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002080 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002081 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002082 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002083 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002084 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002085 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002086 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002087 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002088 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002089 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002090 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002091 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002092 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002093 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002094 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002095 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002096 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002097 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002098 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002099 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002100 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002101 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002102 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002103 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002104 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002105 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002106 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002107 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002108 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002109 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002110 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002111 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002112 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002113 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002114 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002115 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002116 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002117 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002118 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002119 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002120 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002121 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002122 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002123 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002124 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002125 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002126 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002127 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002128 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002129 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002130 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002131 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002132 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002133 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002134 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002135 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002136 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002137 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002138 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002139 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002140 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002141 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002142 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002143 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002144 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002145 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002146 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002147 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002148 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002149 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002150 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002151 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002152 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002153 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002154 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002155 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002156 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002157 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002158 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002159 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002160 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002161 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002162 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002163 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002164 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002165 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002166 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002167 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002168 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002169 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002170 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002171 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002172 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002173 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002174 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002175 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002176 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002177 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002178 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002179 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002180 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002181 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002182 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002183 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002184 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002185 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002186 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002187 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002188 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002189 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002190 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002191 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002192 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002193 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002194 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002195 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002196 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002197 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002198 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002199 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002200 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002201 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002202 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002203 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002204 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002205 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002206 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002207 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002208 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002209 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002210 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002211 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002212 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002213 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002214 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002215 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002216 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002217 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002218 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002219 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002220 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002221 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002222 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002223 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002224 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002225 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002226 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002227 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002228 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002229 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002230 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002231 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002232 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002233 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002234 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002235 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002236 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002237 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002238 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002239 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002240 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002241 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002242 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002243 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002244 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002245 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002246 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002247 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002248 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002249 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002250 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002251 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002252 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002253 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002254 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002255 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002256 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002257 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002258 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002259 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002260 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002261 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002262 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002263 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002264 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002265 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002266 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002267 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002268 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002269 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002270 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002271 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002272 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002273 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002274 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002275 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002276 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002277 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002278 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002279 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002280 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002281 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002282 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002283 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002284 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002285 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002286 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002287 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002288 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002289 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002290 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002291 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002292 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002293 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002294 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002295 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002296 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002297 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002298 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002299 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002300 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002301 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002302 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002303 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002304 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002305 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002306 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002307 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002308 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002309 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002310 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002311 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002312 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002313 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002314 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002315 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002316 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002317 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002318 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002319 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002320 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002321 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002322 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002323 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002324 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002325 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002326 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002327 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002328 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002329 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002330 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002331 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002332 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002333 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002334 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002335 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002336 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002337 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002338 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002339 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002340 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002341 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002342 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002343 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002344 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002345 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002346 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002347 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002348 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002349 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002350 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002351 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002352 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002353 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002354 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002355 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002356 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002357 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002358 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002359 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002360 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002361 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002362 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002363 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002364 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002365 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002366 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002367 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002368 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002369 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002370 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002371 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002372 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002373 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002374 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002375 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002376 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002377 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002378 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002379 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002380 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002381 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002382 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002383 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002384 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002385 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002386 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002387 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002388 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002389 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002390 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002391 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002392 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002393 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002394 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002395 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002396 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002397 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002398 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002399 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002400 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002401 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002402 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002403 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002404 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002405 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002406 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002407 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002408 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002409 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002410 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002411 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002412 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002413 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002414 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002415 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002416 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002417 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002418 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002419 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002420 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002421 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002422 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002423 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002424 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002425 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002426 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002427 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002428 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002429 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002430 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002431 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002432 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002433 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002434 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002435 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002436 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002437 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002438 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002439 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002440 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002441 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002442 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002443 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002444 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002445 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002446 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002447 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002448 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002449 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002450 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002451 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002452 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002453 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002454 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002455 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002456 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002457 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002458 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002459 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002460 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002461 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002462 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002463 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002464 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002465 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002466 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002467 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002468 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002469 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002470 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002471 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002472 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002473 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002474 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002475 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002476 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002477 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002478 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002479 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002480 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002481 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002482 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002483 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002484 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002485 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002486 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002487 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002488 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002489 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002490 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002491 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002492 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002493 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002494 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002495 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002496 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002497 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002498 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002499 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002500 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002501 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002502 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002503 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002504 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002505 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002506 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002507 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002508 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002509 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002510 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002511 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002512 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002513 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002514 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002515 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002516 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002517 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002518 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002519 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002520 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002521 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002522 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002523 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002524 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002525 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002526 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002527 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002528 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002529 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002530 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002531 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002532 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002533 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002534 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002535 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002536 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002537 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002538 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002539 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002540 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002541 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002542 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002543 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002544 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002545 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002546 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002547 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002548 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002549 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002550 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002551 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002552 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002553 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002554 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002555 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002556 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002557 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002558 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002559 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002560 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002561 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002562 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002563 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002564 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002565 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002566 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002567 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002568 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002569 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002570 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002571 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002572 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002573 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002574 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002575 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002576 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002577 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002578 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002579 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002580 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002581 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002582 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002583 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002584 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002585 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002586 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002587 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002588 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002589 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002590 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002591 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002592 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002593 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002594 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002595 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002596 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002597 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002598 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002599 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002600 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002601 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002602 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002603 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002604 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002605 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002606 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002607 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002608 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002609 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002610 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002611 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002612 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002613 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002614 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002615 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002616 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002617 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002618 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002619 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002620 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002621 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002622 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002623 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002624 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002625 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002626 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002627 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002628 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002629 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002630 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002631 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002632 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002633 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002634 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002635 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002636 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002637 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002638 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002639 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002640 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002641 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002642 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002643 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002644 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002645 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002646 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002647 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002648 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002649 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002650 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002651 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002652 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002653 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002654 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002655 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002656 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002657 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002658 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002659 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002660 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002661 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002662 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002663 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002664 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002665 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002666 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002667 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002668 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002669 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002670 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002671 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002672 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002673 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002674 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002675 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002676 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002677 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002678 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002679 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002680 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002681 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002682 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002683 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002684 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002685 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002686 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002687 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002688 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002689 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002690 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002691 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002692 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002693 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002694 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002695 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002696 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002697 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002698 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002699 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002700 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002701 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002702 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002703 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002704 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002705 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002706 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002707 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002708 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002709 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002710 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002711 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002712 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002713 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002714 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002715 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002716 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002717 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002718 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002719 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002720 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002721 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002722 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002723 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002724 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002725 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002726 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002727 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002728 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002729 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002730 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002731 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002732 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002733 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002734 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002735 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002736 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002737 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002738 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002739 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002740 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002741 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002742 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002743 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002744 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002745 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002746 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002747 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002748 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002749 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002750 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002751 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002752 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002753 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002754 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002755 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002756 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002757 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002758 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002759 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002760 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002761 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002762 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002763 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002764 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002765 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002766 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002767 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002768 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002769 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002770 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002771 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002772 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002773 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002774 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002775 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002776 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002777 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002778 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002779 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002780 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002781 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002782 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002783 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002784 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002785 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002786 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002787 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002788 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002789 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002790 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002791 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002792 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002793 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002794 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002795 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002796 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002797 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002798 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002799 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002800 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002801 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002802 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002803 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002804 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002805 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002806 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002807 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002808 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002809 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002810 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002811 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002812 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002813 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002814 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002815 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002816 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002817 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002818 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002819 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002820 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002821 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002822 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002823 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002824 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002825 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002826 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002827 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002828 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002829 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002830 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002831 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002832 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002833 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002834 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002835 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002836 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002837 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002838 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002839 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002840 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002841 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002842 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002843 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002844 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002845 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002846 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002847 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002848 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002849 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002850 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002851 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002852 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002853 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002854 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002855 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002856 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002857 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002858 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002859 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002860 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002861 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002862 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002863 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002864 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002865 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002866 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002867 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002868 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002869 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002870 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002871 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002872 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002873 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002874 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002875 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002876 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002877 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002878 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002879 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002880 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002881 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002882 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002883 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002884 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002885 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002886 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002887 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002888 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002889 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002890 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002891 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002892 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002893 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002894 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002895 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002896 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002897 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002898 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002899 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002900 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002901 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002902 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002903 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002904 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002905 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002906 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002907 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002908 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002909 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002910 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002911 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002912 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002913 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002914 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002915 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002916 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002917 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002918 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002919 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002920 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002921 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002922 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002923 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002924 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002925 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002926 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002927 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002928 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002929 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002930 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002931 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002932 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002933 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002934 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002935 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002936 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002937 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002938 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002939 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002940 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002941 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002942 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002943 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002944 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002945 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002946 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002947 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002948 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002949 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002950 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002951 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002952 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002953 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002954 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002955 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002956 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002957 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002958 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002959 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002960 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002961 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002962 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002963 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002964 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002965 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002966 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002967 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002968 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002969 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002970 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002971 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002972 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002973 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002974 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002975 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002976 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002977 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002978 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002979 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002980 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002981 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002982 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002983 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002984 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002985 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002986 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002987 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002988 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002989 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002990 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002991 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002992 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002993 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002994 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002995 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002996 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002997 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002998 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000002999 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003000 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003002 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003003 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003004 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003005 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003006 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003007 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003008 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003009 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003010 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003011 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003012 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003013 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003014 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003015 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003016 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003017 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003018 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003019 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003020 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003021 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003022 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003023 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003024 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003025 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003026 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003027 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003028 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003029 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003030 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003031 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003032 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003033 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003034 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003035 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003036 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003037 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003038 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003039 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003040 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003041 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003042 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003043 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003044 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003045 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003046 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003047 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003048 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003049 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003050 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003051 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003052 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003053 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003054 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003055 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003056 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003057 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003058 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003059 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003060 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003061 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003062 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003063 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003064 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003065 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003066 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003067 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003068 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003069 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003070 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003071 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003072 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003073 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003074 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003075 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003076 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003077 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003078 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003079 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003080 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003081 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003082 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003083 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003084 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003085 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003086 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003087 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003088 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003089 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003090 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003091 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003092 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003093 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003094 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003095 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003096 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003097 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003098 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003099 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003100 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003101 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003102 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003103 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003104 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003105 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003106 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003107 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003108 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003109 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003110 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003111 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003112 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003113 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003114 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003115 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003116 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003117 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003118 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003119 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003120 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003121 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003122 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003123 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003124 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003125 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003126 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003127 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003128 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003129 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003130 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003131 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003132 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003133 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003134 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003135 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003136 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003137 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003138 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003139 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003140 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003141 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003142 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003143 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003144 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003145 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003146 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003147 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003148 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003149 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003150 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003151 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003152 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003153 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003154 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003155 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003156 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003157 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003158 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003159 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003160 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003161 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003162 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003163 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003164 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003165 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003166 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003167 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003168 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003169 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003170 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003171 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003172 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003173 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003174 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003175 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003176 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003177 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003178 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003179 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003180 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003181 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003182 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003183 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003184 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003185 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003186 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003187 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003188 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003189 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003190 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003191 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003192 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003193 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003194 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003195 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003196 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003197 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003198 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003199 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003200 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003201 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003202 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003203 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003204 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003205 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003206 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003207 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003208 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003209 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003210 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003211 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003212 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003213 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003214 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003215 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003216 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003217 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003218 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003219 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003220 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003221 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003222 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003223 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003224 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003225 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003226 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003227 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003228 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003229 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003230 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003231 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003232 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003233 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003234 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003235 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003236 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003237 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003238 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003239 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003240 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003241 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003242 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003243 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003244 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003245 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003246 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003247 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003248 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003249 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003250 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003251 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003252 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003253 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003254 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003255 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003256 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003257 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003258 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003259 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003260 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003261 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003262 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003263 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003264 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003265 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003266 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003267 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003268 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003269 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003270 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003271 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003272 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003273 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003274 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003275 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003276 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003277 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003278 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003279 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003280 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003281 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003282 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003283 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003284 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003285 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003286 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003287 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003288 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003289 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003290 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003291 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003292 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003293 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003294 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003295 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003296 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003297 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003298 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003299 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003300 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003301 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003302 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003303 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003304 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003305 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003306 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003307 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003308 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003309 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003310 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003311 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003312 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003313 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003314 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003315 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003316 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003317 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003318 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003319 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003320 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003321 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003322 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003323 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003324 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003325 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003326 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003327 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003328 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003329 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003330 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003331 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003332 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003333 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003334 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003335 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003336 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003337 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003338 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003339 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003340 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003341 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003342 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003343 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003344 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003345 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003346 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003347 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003348 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003349 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003350 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003351 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003352 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003353 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003354 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003355 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003356 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003357 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003358 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003359 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003360 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003361 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003362 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003363 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003364 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003365 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003366 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003367 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003368 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003369 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003370 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003371 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003372 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003373 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003374 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003375 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003376 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003377 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003378 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003379 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003380 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003381 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003382 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003383 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003384 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003385 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003386 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003387 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003388 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003389 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003390 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003391 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003392 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003393 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003394 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003395 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003396 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003397 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003398 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003399 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003400 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003401 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003402 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003403 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003404 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003405 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003406 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003407 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003408 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003409 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003410 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003411 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003412 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003413 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003414 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003415 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003416 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003417 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003418 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003419 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003420 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003421 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003422 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003423 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003424 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003425 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003426 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003427 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003428 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003429 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003430 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003431 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003432 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003433 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003434 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003435 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003436 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003437 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003438 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003439 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003440 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003441 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003442 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003443 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003444 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003445 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003446 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003447 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003448 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003449 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003450 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003451 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003452 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003453 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003454 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003455 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003456 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003457 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003458 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003459 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003460 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003461 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003462 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003463 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003464 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003465 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003466 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003467 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003468 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003469 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003470 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003471 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003472 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003473 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003474 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003475 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003476 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003477 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003478 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003479 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003480 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003481 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003482 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003483 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003484 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003485 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003486 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003487 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003488 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003489 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003490 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003491 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003492 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003493 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003494 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003495 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003496 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003497 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003498 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003499 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003500 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003501 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003502 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003503 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003504 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003505 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003506 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003507 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003508 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003509 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003510 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003511 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003512 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003513 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003514 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003515 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003516 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003517 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003518 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003519 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003520 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003521 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003522 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003523 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003524 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003525 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003526 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003527 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003528 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003529 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003530 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003531 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003532 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003533 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003534 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003535 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003536 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003537 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003538 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003539 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003540 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003541 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003542 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003543 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003544 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003545 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003546 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003547 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003548 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003549 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003550 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003551 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003552 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003553 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003554 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003555 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003556 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003557 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003558 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003559 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003560 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003561 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003562 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003563 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003564 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003565 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003566 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003567 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003568 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003569 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003570 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003571 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003572 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003573 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003574 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003575 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003576 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003577 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003578 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003579 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003580 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003581 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003582 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003583 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003584 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003585 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003586 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003587 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003588 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003589 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003590 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003591 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003592 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003593 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003594 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003595 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003596 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003597 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003598 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003599 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003600 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003601 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003602 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003603 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003604 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003605 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003606 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003607 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003608 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003609 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003610 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003611 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003612 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003613 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003614 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003615 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003616 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003617 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003618 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003619 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003620 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003621 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003622 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003623 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003624 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003625 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003626 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003627 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003628 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003629 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003630 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003631 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003632 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003633 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003634 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003635 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003636 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003637 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003638 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003639 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003640 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003641 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003642 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003643 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003644 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003645 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003646 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003647 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003648 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003649 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003650 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003651 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003652 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003653 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003654 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003655 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003656 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003657 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003658 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003659 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003660 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003661 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003662 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003663 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003664 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003665 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003666 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003667 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003668 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003669 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003670 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003671 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003672 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003673 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003674 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003675 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003676 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003677 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003678 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003679 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003680 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003681 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003682 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003683 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003684 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003685 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003686 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003687 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003688 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003689 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003690 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003691 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003692 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003693 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003694 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003695 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003696 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003697 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003698 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003699 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003700 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003701 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003702 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003703 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003704 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003705 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003706 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003707 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003708 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003709 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003710 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003711 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003712 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003713 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003714 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003715 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003716 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003717 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003718 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003719 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003720 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003721 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003722 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003723 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003724 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003725 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003726 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003727 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003728 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003729 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003730 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003731 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003732 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003733 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003734 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003735 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003736 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003737 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003738 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003739 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003740 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003741 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003742 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003743 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003744 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003745 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003746 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003747 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003748 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003749 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003750 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003751 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003752 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003753 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003754 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003755 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003756 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003757 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003758 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003759 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003760 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003761 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003762 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003763 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003764 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003765 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003766 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003767 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003768 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003769 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003770 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003771 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003772 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003773 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003774 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003775 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003776 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003777 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003778 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003779 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003780 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003781 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003782 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003783 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003784 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003785 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003786 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003787 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003788 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003789 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003790 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003791 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003792 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003793 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003794 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003795 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003796 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003797 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003798 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003799 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003800 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003801 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003802 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003803 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003804 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003805 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003806 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003807 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003808 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003809 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003810 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003811 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003812 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003813 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003814 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003815 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003816 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003817 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003818 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003819 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003820 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003821 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003822 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003823 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003824 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003825 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003826 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003827 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003828 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003829 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003830 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003831 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003832 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003833 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003834 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003835 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003836 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003837 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003838 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003839 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003840 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003841 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003842 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003843 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003844 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003845 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003846 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003847 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003848 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003849 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003850 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003851 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003852 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003853 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003854 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003855 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003856 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003857 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003858 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003859 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003860 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003861 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003862 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003863 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003864 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003865 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003866 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003867 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003868 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003869 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003870 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003871 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003872 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003873 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003874 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003875 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003876 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003877 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003878 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003879 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003880 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003881 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003882 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003883 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003884 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003885 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003886 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003887 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003888 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003889 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003890 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003891 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003892 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003893 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003894 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003895 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003896 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003897 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003898 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003899 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003900 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003901 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003902 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003903 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003904 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003905 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003906 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003907 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003908 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003909 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003910 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003911 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003912 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003913 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003914 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003915 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003916 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003917 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003918 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003919 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003920 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003921 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003922 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003923 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003924 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003925 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003926 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003927 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003928 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003929 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003930 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003931 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003932 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003933 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003934 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003935 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003936 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003937 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003938 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003939 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003940 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003941 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003942 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003943 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003944 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003945 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003946 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003947 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003948 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003949 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003950 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003951 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003952 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003953 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003954 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003955 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003956 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003957 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003958 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003959 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003960 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003961 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003962 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003963 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003964 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003965 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003966 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003967 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003968 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003969 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003970 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003971 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003972 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003973 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003974 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003975 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003976 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003977 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003978 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003979 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003980 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003981 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003982 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003983 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003984 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003985 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003986 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003987 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003988 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003989 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003990 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003991 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003992 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003993 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003994 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003995 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003996 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003997 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003998 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000003999 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004000 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004002 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004003 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004004 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004005 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004006 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004007 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004008 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004009 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004010 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004011 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004012 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004013 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004014 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004015 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004016 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004017 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004018 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004019 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004020 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004021 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004022 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004023 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004024 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004025 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004026 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004027 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004028 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004029 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004030 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004031 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004032 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004033 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004034 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004035 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004036 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004037 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004038 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004039 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004040 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004041 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004042 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004043 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004044 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004045 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004046 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004047 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004048 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004049 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004050 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004051 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004052 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004053 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004054 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004055 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004056 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004057 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004058 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004059 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004060 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004061 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004062 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004063 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004064 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004065 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004066 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004067 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004068 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004069 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004070 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004071 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004072 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004073 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004074 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004075 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004076 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004077 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004078 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004079 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004080 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004081 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004082 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004083 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004084 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004085 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004086 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004087 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004088 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004089 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004090 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004091 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004092 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004093 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004094 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004095 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004096 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004097 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004098 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004099 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004100 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004101 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004102 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004103 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004104 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004105 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004106 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004107 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004108 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004109 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004110 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004111 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004112 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004113 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004114 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004115 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004116 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004117 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004118 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004119 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004120 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004121 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004122 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004123 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004124 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004125 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004126 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004127 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004128 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004129 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004130 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004131 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004132 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004133 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004134 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004135 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004136 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004137 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004138 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004139 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004140 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004141 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004142 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004143 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004144 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004145 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004146 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004147 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004148 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004149 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004150 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004151 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004152 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004153 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004154 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004155 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004156 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004157 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004158 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004159 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004160 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004161 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004162 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004163 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004164 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004165 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004166 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004167 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004168 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004169 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004170 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004171 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004172 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004173 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004174 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004175 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004176 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004177 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004178 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004179 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004180 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004181 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004182 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004183 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004184 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004185 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004186 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004187 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004188 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004189 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004190 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004191 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004192 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004193 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004194 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004195 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004196 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004197 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004198 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004199 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004200 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004201 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004202 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004203 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004204 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004205 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004206 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004207 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004208 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004209 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004210 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004211 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004212 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004213 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004214 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004215 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004216 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004217 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004218 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004219 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004220 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004221 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004222 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004223 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004224 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004225 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004226 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004227 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004228 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004229 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004230 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004231 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004232 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004233 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004234 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004235 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004236 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004237 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004238 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004239 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004240 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004241 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004242 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004243 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004244 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004245 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004246 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004247 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004248 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004249 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004250 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004251 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004252 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004253 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004254 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004255 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004256 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004257 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004258 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004259 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004260 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004261 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004262 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004263 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004264 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004265 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004266 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004267 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004268 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004269 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004270 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004271 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004272 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004273 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004274 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004275 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004276 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004277 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004278 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004279 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004280 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004281 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004282 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004283 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004284 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004285 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004286 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004287 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004288 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004289 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004290 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004291 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004292 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004293 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004294 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004295 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004296 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004297 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004298 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004299 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004300 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004301 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004302 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004303 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004304 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004305 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004306 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004307 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004308 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004309 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004310 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004311 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004312 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004313 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004314 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004315 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004316 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004317 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004318 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004319 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004320 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004321 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004322 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004323 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004324 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004325 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004326 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004327 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004328 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004329 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004330 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004331 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004332 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004333 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004334 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004335 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004336 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004337 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004338 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004339 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004340 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004341 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004342 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004343 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004344 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004345 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004346 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004347 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004348 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004349 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004350 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004351 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004352 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004353 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004354 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004355 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004356 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004357 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004358 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004359 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004360 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004361 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004362 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004363 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004364 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004365 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004366 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004367 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004368 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004369 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004370 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004371 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004372 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004373 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004374 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004375 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004376 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004377 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004378 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004379 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004380 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004381 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004382 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004383 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004384 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004385 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004386 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004387 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004388 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004389 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004390 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004391 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004392 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004393 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004394 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004395 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004396 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004397 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004398 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004399 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004400 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004401 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004402 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004403 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004404 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004405 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004406 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004407 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004408 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004409 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004410 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004411 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004412 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004413 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004414 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004415 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004416 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004417 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004418 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004419 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004420 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004421 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004422 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004423 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004424 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004425 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004426 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004427 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004428 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004429 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004430 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004431 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004432 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004433 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004434 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004435 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004436 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004437 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004438 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004439 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004440 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004441 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004442 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004443 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004444 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004445 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004446 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004447 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004448 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004449 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004450 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004451 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004452 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004453 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004454 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004455 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004456 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004457 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004458 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004459 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004460 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004461 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004462 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004463 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004464 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004465 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004466 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004467 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004468 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004469 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004470 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004471 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004472 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004473 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004474 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004475 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004476 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004477 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004478 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004479 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004480 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004481 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004482 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004483 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004484 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004485 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004486 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004487 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004488 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004489 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004490 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004491 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004492 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004493 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004494 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004495 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004496 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004497 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004498 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004499 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004500 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004501 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004502 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004503 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004504 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004505 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004506 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004507 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004508 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004509 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004510 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004511 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004512 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004513 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004514 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004515 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004516 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004517 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004518 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004519 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004520 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004521 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004522 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004523 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004524 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004525 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004526 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004527 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004528 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004529 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004530 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004531 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004532 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004533 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004534 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004535 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004536 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004537 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004538 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004539 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004540 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004541 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004542 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004543 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004544 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004545 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004546 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004547 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004548 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004549 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004550 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004551 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004552 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004553 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004554 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004555 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004556 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004557 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004558 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004559 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004560 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004561 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004562 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004563 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004564 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004565 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004566 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004567 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004568 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004569 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004570 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004571 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004572 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004573 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004574 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004575 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004576 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004577 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004578 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004579 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004580 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004581 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004582 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004583 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004584 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004585 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004586 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004587 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004588 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004589 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004590 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004591 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004592 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004593 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004594 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004595 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004596 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004597 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004598 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004599 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004600 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004601 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004602 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004603 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004604 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004605 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004606 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004607 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004608 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004609 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004610 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004611 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004612 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004613 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004614 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004615 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004616 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004617 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004618 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004619 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004620 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004621 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004622 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004623 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004624 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004625 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004626 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004627 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004628 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004629 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004630 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004631 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004632 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004633 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004634 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004635 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004636 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004637 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004638 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004639 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004640 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004641 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004642 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004643 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004644 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004645 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004646 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004647 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004648 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004649 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004650 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004651 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004652 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004653 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004654 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004655 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004656 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004657 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004658 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004659 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004660 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004661 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004662 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004663 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004664 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004665 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004666 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004667 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004668 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004669 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004670 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004671 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004672 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004673 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004674 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004675 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004676 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004677 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004678 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004679 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004680 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004681 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004682 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004683 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004684 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004685 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004686 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004687 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004688 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004689 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004690 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004691 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004692 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004693 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004694 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004695 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004696 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004697 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004698 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004699 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004700 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004701 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004702 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004703 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004704 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004705 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004706 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004707 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004708 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004709 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004710 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004711 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004712 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004713 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004714 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004715 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004716 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004717 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004718 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004719 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004720 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004721 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004722 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004723 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004724 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004725 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004726 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004727 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004728 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004729 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004730 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004731 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004732 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004733 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004734 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004735 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004736 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004737 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004738 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004739 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004740 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004741 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004742 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004743 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004744 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004745 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004746 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004747 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004748 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004749 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004750 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004751 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004752 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004753 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004754 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004755 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004756 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004757 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004758 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004759 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004760 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004761 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004762 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004763 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004764 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004765 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004766 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004767 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004768 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004769 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004770 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004771 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004772 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004773 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004774 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004775 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004776 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004777 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004778 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004779 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004780 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004781 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004782 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004783 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004784 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004785 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004786 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004787 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004788 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004789 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004790 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004791 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004792 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004793 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004794 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004795 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004796 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004797 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004798 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004799 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004800 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004801 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004802 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004803 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004804 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004805 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004806 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004807 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004808 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004809 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004810 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004811 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004812 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004813 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004814 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004815 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004816 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004817 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004818 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004819 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004820 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004821 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004822 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004823 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004824 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004825 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004826 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004827 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004828 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004829 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004830 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004831 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004832 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004833 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004834 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004835 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004836 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004837 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004838 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004839 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004840 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004841 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004842 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004843 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004844 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004845 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004846 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004847 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004848 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004849 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004850 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004851 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004852 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004853 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004854 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004855 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004856 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004857 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004858 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004859 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004860 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004861 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004862 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004863 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004864 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004865 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004866 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004867 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004868 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004869 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004870 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004871 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004872 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004873 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004874 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004875 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004876 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004877 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004878 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004879 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004880 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004881 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004882 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004883 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004884 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004885 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004886 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004887 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004888 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004889 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004890 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004891 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004892 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004893 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004894 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004895 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004896 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004897 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004898 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004899 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004900 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004901 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004902 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004903 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004904 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004905 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004906 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004907 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004908 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004909 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004910 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004911 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004912 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004913 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004914 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004915 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004916 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004917 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004918 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004919 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004920 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004921 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004922 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004923 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004924 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004925 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004926 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004927 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004928 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004929 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004930 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004931 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004932 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004933 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004934 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004935 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004936 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004937 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004938 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004939 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004940 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004941 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004942 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004943 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004944 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004945 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004946 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004947 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004948 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004949 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004950 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004951 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004952 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004953 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004954 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004955 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004956 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004957 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004958 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004959 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004960 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004961 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004962 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004963 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004964 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004965 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004966 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004967 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004968 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004969 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004970 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004971 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004972 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004973 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004974 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004975 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004976 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004977 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004978 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004979 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004980 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004981 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004982 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004983 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004984 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004985 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004986 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004987 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004988 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004989 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004990 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004991 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004992 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004993 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004994 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004995 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004996 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004997 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004998 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000004999 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005000 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005002 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005003 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005004 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005005 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005006 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005007 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005008 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005009 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005010 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005011 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005012 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005013 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005014 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005015 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005016 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005017 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005018 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005019 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005020 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005021 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005022 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005023 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005024 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005025 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005026 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005027 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005028 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005029 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005030 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005031 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005032 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005033 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005034 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005035 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005036 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005037 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005038 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005039 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005040 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005041 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005042 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005043 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005044 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005045 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005046 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005047 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005048 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005049 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005050 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005051 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005052 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005053 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005054 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005055 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005056 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005057 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005058 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005059 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005060 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005061 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005062 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005063 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005064 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005065 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005066 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005067 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005068 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005069 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005070 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005071 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005072 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005073 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005074 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005075 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005076 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005077 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005078 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005079 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005080 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005081 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005082 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005083 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005084 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005085 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005086 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005087 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005088 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005089 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005090 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005091 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005092 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005093 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005094 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005095 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005096 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005097 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005098 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005099 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005100 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005101 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005102 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005103 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005104 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005105 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005106 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005107 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005108 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005109 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005110 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005111 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005112 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005113 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005114 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005115 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005116 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005117 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005118 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005119 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005120 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005121 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005122 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005123 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005124 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005125 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005126 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005127 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005128 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005129 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005130 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005131 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005132 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005133 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005134 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005135 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005136 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005137 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005138 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005139 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005140 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005141 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005142 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005143 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005144 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005145 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005146 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005147 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005148 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005149 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005150 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005151 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005152 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005153 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005154 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005155 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005156 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005157 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005158 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005159 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005160 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005161 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005162 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005163 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005164 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005165 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005166 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005167 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005168 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005169 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005170 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005171 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005172 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005173 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005174 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005175 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005176 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005177 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005178 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005179 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005180 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005181 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005182 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005183 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005184 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005185 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005186 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005187 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005188 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005189 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005190 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005191 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005192 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005193 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005194 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005195 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005196 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005197 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005198 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005199 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005200 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005201 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005202 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005203 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005204 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005205 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005206 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005207 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005208 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005209 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005210 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005211 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005212 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005213 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005214 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005215 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005216 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005217 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005218 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005219 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005220 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005221 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005222 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005223 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005224 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005225 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005226 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005227 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005228 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005229 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005230 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005231 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005232 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005233 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005234 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005235 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005236 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005237 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005238 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005239 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005240 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005241 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005242 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005243 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005244 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005245 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005246 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005247 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005248 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005249 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005250 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005251 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005252 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005253 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005254 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005255 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005256 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005257 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005258 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005259 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005260 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005261 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005262 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005263 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005264 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005265 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005266 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005267 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005268 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005269 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005270 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005271 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005272 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005273 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005274 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005275 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005276 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005277 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005278 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005279 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005280 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005281 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005282 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005283 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005284 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005285 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005286 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005287 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005288 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005289 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005290 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005291 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005292 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005293 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005294 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005295 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005296 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005297 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005298 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005299 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005300 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005301 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005302 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005303 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005304 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005305 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005306 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005307 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005308 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005309 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005310 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005311 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005312 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005313 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005314 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005315 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005316 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005317 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005318 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005319 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005320 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005321 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005322 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005323 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005324 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005325 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005326 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005327 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005328 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005329 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005330 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005331 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005332 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005333 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005334 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005335 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005336 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005337 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005338 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005339 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005340 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005341 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005342 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005343 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005344 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005345 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005346 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005347 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005348 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005349 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005350 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005351 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005352 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005353 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005354 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005355 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005356 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005357 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005358 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005359 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005360 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005361 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005362 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005363 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005364 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005365 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005366 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005367 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005368 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005369 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005370 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005371 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005372 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005373 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005374 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005375 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005376 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005377 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005378 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005379 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005380 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005381 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005382 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005383 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005384 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005385 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005386 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005387 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005388 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005389 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005390 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005391 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005392 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005393 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005394 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005395 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005396 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005397 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005398 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005399 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005400 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005401 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005402 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005403 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005404 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005405 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005406 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005407 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005408 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005409 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005410 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005411 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005412 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005413 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005414 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005415 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005416 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005417 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005418 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005419 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005420 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005421 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005422 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005423 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005424 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005425 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005426 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005427 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005428 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005429 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005430 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005431 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005432 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005433 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005434 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005435 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005436 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005437 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005438 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005439 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005440 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005441 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005442 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005443 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005444 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005445 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005446 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005447 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005448 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005449 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005450 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005451 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005452 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005453 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005454 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005455 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005456 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005457 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005458 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005459 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005460 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005461 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005462 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005463 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005464 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005465 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005466 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005467 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005468 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005469 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005470 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005471 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005472 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005473 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005474 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005475 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005476 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005477 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005478 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005479 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005480 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005481 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005482 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005483 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005484 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005485 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005486 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005487 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005488 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005489 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005490 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005491 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005492 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005493 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005494 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005495 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005496 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005497 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005498 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005499 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005500 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005501 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005502 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005503 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005504 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005505 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005506 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005507 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005508 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005509 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005510 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005511 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005512 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005513 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005514 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005515 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005516 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005517 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005518 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005519 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005520 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005521 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005522 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005523 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005524 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005525 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005526 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005527 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005528 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005529 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005530 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005531 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005532 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005533 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005534 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005535 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005536 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005537 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005538 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005539 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005540 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005541 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005542 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005543 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005544 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005545 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005546 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005547 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005548 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005549 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005550 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005551 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005552 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005553 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005554 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005555 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005556 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005557 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005558 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005559 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005560 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005561 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005562 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005563 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005564 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005565 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005566 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005567 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005568 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005569 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005570 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005571 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005572 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005573 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005574 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005575 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005576 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005577 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005578 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005579 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005580 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005581 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005582 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005583 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005584 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005585 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005586 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005587 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005588 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005589 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005590 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005591 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005592 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005593 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005594 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005595 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005596 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005597 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005598 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005599 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005600 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005601 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005602 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005603 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005604 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005605 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005606 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005607 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005608 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005609 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005610 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005611 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005612 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005613 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005614 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005615 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005616 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005617 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005618 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005619 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005620 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005621 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005622 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005623 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005624 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005625 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005626 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005627 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005628 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005629 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005630 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005631 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005632 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005633 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005634 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005635 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005636 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005637 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005638 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005639 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005640 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005641 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005642 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005643 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005644 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005645 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005646 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005647 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005648 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005649 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005650 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005651 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005652 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005653 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005654 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005655 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005656 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005657 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005658 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005659 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005660 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005661 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005662 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005663 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005664 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005665 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005666 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005667 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005668 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005669 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005670 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005671 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005672 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005673 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005674 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005675 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005676 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005677 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005678 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005679 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005680 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005681 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005682 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005683 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005684 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005685 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005686 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005687 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005688 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005689 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005690 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005691 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005692 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005693 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005694 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005695 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005696 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005697 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005698 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005699 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005700 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005701 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005702 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005703 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005704 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005705 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005706 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005707 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005708 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005709 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005710 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005711 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005712 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005713 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005714 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005715 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005716 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005717 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005718 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005719 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005720 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005721 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005722 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005723 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005724 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005725 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005726 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005727 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005728 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005729 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005730 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005731 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005732 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005733 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005734 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005735 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005736 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005737 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005738 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005739 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005740 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005741 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005742 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005743 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005744 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005745 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005746 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005747 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005748 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005749 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005750 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005751 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005752 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005753 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005754 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005755 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005756 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005757 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005758 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005759 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005760 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005761 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005762 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005763 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005764 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005765 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005766 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005767 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005768 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005769 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005770 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005771 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005772 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005773 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005774 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005775 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005776 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005777 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005778 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005779 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005780 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005781 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005782 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005783 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005784 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005785 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005786 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005787 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005788 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005789 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005790 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005791 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005792 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005793 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005794 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005795 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005796 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005797 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005798 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005799 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005800 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005801 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005802 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005803 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005804 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005805 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005806 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005807 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005808 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005809 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005810 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005811 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005812 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005813 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005814 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005815 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005816 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005817 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005818 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005819 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005820 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005821 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005822 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005823 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005824 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005825 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005826 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005827 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005828 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005829 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005830 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005831 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005832 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005833 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005834 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005835 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005836 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005837 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005838 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005839 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005840 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005841 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005842 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005843 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005844 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005845 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005846 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005847 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005848 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005849 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005850 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005851 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005852 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005853 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005854 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005855 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005856 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005857 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005858 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005859 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005860 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005861 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005862 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005863 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005864 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005865 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005866 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005867 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005868 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005869 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005870 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005871 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005872 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005873 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005874 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005875 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005876 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005877 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005878 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005879 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005880 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005881 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005882 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005883 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005884 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005885 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005886 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005887 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005888 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005889 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005890 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005891 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005892 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005893 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005894 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005895 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005896 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005897 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005898 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005899 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005900 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005901 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005902 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005903 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005904 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005905 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005906 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005907 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005908 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005909 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005910 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005911 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005912 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005913 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005914 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005915 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005916 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005917 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005918 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005919 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005920 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005921 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005922 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005923 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005924 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005925 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005926 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005927 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005928 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005929 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005930 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005931 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005932 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005933 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005934 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005935 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005936 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005937 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005938 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005939 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005940 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005941 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005942 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005943 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005944 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005945 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005946 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005947 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005948 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005949 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005950 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005951 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005952 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005953 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005954 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005955 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005956 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005957 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005958 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005959 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005960 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005961 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005962 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005963 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005964 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005965 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005966 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005967 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005968 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005969 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005970 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005971 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005972 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005973 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005974 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005975 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005976 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005977 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005978 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005979 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005980 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005981 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005982 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005983 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005984 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005985 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005986 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005987 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005988 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005989 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005990 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005991 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005992 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005993 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005994 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005995 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005996 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005997 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005998 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000005999 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006000 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006002 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006003 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006004 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006005 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006006 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006007 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006008 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006009 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006010 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006011 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006012 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006013 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006014 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006015 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006016 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006017 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006018 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006019 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006020 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006021 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006022 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006023 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006024 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006025 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006026 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006027 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006028 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006029 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006030 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006031 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006032 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006033 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006034 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006035 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006036 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006037 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006038 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006039 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006040 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006041 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006042 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006043 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006044 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006045 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006046 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006047 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006048 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006049 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006050 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006051 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006052 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006053 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006054 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006055 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006056 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006057 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006058 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006059 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006060 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006061 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006062 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006063 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006064 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006065 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006066 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006067 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006068 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006069 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006070 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006071 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006072 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006073 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006074 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006075 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006076 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006077 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006078 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006079 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006080 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006081 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006082 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006083 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006084 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006085 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006086 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006087 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006088 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006089 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006090 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006091 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006092 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006093 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006094 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006095 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006096 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006097 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006098 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006099 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006100 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006101 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006102 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006103 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006104 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006105 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006106 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006107 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006108 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006109 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006110 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006111 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006112 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006113 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006114 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006115 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006116 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006117 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006118 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006119 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006120 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006121 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006122 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006123 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006124 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006125 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006126 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006127 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006128 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006129 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006130 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006131 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006132 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006133 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006134 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006135 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006136 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006137 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006138 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006139 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006140 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006141 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006142 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006143 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006144 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006145 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006146 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006147 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006148 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006149 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006150 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006151 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006152 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006153 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006154 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006155 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006156 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006157 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006158 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006159 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006160 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006161 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006162 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006163 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006164 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006165 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006166 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006167 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006168 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006169 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006170 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006171 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006172 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006173 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006174 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006175 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006176 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006177 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006178 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006179 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006180 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006181 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006182 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006183 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006184 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006185 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006186 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006187 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006188 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006189 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006190 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006191 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006192 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006193 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006194 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006195 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006196 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006197 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006198 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006199 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006200 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006201 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006202 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006203 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006204 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006205 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006206 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006207 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006208 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006209 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006210 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006211 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006212 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006213 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006214 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006215 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006216 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006217 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006218 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006219 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006220 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006221 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006222 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006223 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006224 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006225 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006226 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006227 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006228 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006229 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006230 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006231 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006232 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006233 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006234 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006235 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006236 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006237 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006238 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006239 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006240 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006241 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006242 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006243 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006244 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006245 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006246 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006247 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006248 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006249 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006250 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006251 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006252 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006253 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006254 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006255 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006256 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006257 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006258 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006259 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006260 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006261 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006262 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006263 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006264 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006265 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006266 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006267 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006268 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006269 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006270 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006271 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006272 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006273 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006274 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006275 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006276 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006277 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006278 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006279 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006280 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006281 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006282 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006283 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006284 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006285 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006286 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006287 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006288 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006289 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006290 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006291 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006292 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006293 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006294 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006295 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006296 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006297 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006298 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006299 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006300 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006301 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006302 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006303 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006304 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006305 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006306 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006307 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006308 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006309 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006310 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006311 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006312 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006313 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006314 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006315 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006316 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006317 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006318 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006319 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006320 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006321 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006322 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006323 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006324 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006325 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006326 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006327 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006328 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006329 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006330 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006331 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006332 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006333 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006334 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006335 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006336 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006337 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006338 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006339 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006340 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006341 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006342 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006343 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006344 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006345 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006346 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006347 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006348 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006349 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006350 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006351 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006352 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006353 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006354 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006355 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006356 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006357 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006358 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006359 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006360 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006361 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006362 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006363 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006364 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006365 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006366 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006367 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006368 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006369 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006370 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006371 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006372 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006373 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006374 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006375 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006376 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006377 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006378 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006379 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006380 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006381 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006382 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006383 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006384 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006385 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006386 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006387 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006388 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006389 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006390 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006391 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006392 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006393 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006394 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006395 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006396 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006397 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006398 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006399 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006400 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006401 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006402 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006403 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006404 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006405 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006406 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006407 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006408 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006409 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006410 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006411 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006412 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006413 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006414 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006415 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006416 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006417 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006418 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006419 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006420 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006421 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006422 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006423 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006424 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006425 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006426 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006427 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006428 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006429 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006430 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006431 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006432 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006433 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006434 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006435 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006436 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006437 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006438 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006439 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006440 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006441 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006442 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006443 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006444 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006445 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006446 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006447 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006448 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006449 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006450 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006451 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006452 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006453 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006454 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006455 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006456 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006457 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006458 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006459 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006460 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006461 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006462 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006463 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006464 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006465 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006466 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006467 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006468 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006469 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006470 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006471 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006472 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006473 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006474 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006475 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006476 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006477 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006478 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006479 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006480 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006481 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006482 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006483 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006484 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006485 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006486 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006487 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006488 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006489 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006490 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006491 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006492 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006493 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006494 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006495 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006496 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006497 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006498 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006499 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006500 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006501 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006502 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006503 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006504 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006505 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006506 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006507 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006508 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006509 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006510 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006511 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006512 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006513 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006514 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006515 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006516 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006517 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006518 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006519 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006520 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006521 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006522 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006523 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006524 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006525 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006526 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006527 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006528 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006529 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006530 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006531 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006532 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006533 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006534 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006535 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006536 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006537 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006538 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006539 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006540 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006541 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006542 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006543 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006544 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006545 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006546 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006547 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006548 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006549 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006550 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006551 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006552 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006553 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006554 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006555 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006556 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006557 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006558 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006559 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006560 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006561 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006562 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006563 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006564 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006565 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006566 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006567 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006568 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006569 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006570 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006571 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006572 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006573 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006574 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006575 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006576 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006577 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006578 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006579 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006580 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006581 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006582 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006583 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006584 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006585 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006586 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006587 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006588 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006589 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006590 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006591 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006592 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006593 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006594 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006595 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006596 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006597 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006598 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006599 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006600 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006601 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006602 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006603 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006604 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006605 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006606 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006607 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006608 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006609 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006610 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006611 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006612 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006613 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006614 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006615 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006616 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006617 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006618 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006619 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006620 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006621 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006622 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006623 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006624 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006625 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006626 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006627 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006628 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006629 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006630 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006631 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006632 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006633 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006634 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006635 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006636 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006637 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006638 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006639 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006640 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006641 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006642 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006643 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006644 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006645 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006646 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006647 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006648 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006649 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006650 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006651 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006652 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006653 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006654 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006655 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006656 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006657 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006658 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006659 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006660 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006661 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006662 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006663 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006664 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006665 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006666 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006667 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006668 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006669 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006670 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006671 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006672 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006673 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006674 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006675 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006676 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006677 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006678 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006679 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006680 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006681 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006682 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006683 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006684 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006685 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006686 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006687 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006688 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006689 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006690 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006691 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006692 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006693 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006694 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006695 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006696 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006697 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006698 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006699 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006700 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006701 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006702 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006703 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006704 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006705 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006706 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006707 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006708 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006709 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006710 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006711 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006712 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006713 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006714 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006715 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006716 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006717 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006718 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006719 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006720 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006721 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006722 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006723 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006724 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006725 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006726 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006727 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006728 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006729 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006730 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006731 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006732 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006733 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006734 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006735 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006736 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006737 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006738 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006739 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006740 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006741 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006742 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006743 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006744 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006745 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006746 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006747 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006748 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006749 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006750 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006751 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006752 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006753 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006754 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006755 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006756 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006757 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006758 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006759 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006760 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006761 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006762 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006763 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006764 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006765 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006766 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006767 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006768 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006769 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006770 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006771 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006772 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006773 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006774 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006775 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006776 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006777 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006778 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006779 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006780 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006781 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006782 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006783 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006784 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006785 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006786 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006787 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006788 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006789 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006790 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006791 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006792 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006793 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006794 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006795 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006796 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006797 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006798 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006799 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006800 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006801 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006802 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006803 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006804 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006805 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006806 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006807 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006808 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006809 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006810 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006811 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006812 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006813 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006814 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006815 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006816 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006817 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006818 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006819 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006820 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006821 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006822 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006823 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006824 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006825 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006826 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006827 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006828 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006829 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006830 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006831 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006832 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006833 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006834 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006835 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006836 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006837 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006838 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006839 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006840 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006841 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006842 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006843 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006844 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006845 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006846 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006847 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006848 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006849 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006850 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006851 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006852 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006853 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006854 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006855 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006856 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006857 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006858 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006859 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006860 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006861 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006862 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006863 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006864 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006865 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006866 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006867 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006868 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006869 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006870 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006871 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006872 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006873 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006874 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006875 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006876 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006877 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006878 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006879 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006880 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006881 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006882 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006883 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006884 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006885 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006886 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006887 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006888 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006889 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006890 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006891 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006892 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006893 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006894 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006895 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006896 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006897 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006898 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006899 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006900 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006901 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006902 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006903 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006904 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006905 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006906 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006907 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006908 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006909 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006910 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006911 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006912 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006913 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006914 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006915 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006916 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006917 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006918 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006919 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006920 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006921 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006922 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006923 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006924 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006925 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006926 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006927 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006928 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006929 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006930 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006931 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006932 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006933 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006934 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006935 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006936 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006937 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006938 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006939 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006940 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006941 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006942 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006943 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006944 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006945 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006946 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006947 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006948 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006949 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006950 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006951 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006952 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006953 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006954 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006955 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006956 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006957 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006958 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006959 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006960 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006961 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006962 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006963 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006964 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006965 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006966 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006967 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006968 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006969 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006970 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006971 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006972 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006973 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006974 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006975 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006976 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006977 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006978 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006979 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006980 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006981 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006982 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006983 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006984 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006985 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006986 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006987 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006988 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006989 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006990 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006991 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006992 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006993 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006994 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006995 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006996 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006997 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006998 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000006999 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007000 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007002 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007003 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007004 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007005 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007006 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007007 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007008 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007009 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007010 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007011 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007012 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007013 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007014 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007015 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007016 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007017 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007018 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007019 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007020 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007021 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007022 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007023 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007024 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007025 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007026 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007027 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007028 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007029 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007030 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007031 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007032 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007033 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007034 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007035 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007036 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007037 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007038 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007039 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007040 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007041 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007042 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007043 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007044 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007045 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007046 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007047 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007048 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007049 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007050 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007051 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007052 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007053 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007054 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007055 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007056 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007057 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007058 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007059 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007060 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007061 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007062 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007063 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007064 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007065 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007066 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007067 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007068 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007069 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007070 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007071 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007072 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007073 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007074 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007075 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007076 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007077 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007078 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007079 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007080 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007081 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007082 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007083 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007084 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007085 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007086 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007087 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007088 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007089 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007090 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007091 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007092 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007093 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007094 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007095 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007096 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007097 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007098 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007099 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007100 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007101 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007102 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007103 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007104 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007105 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007106 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007107 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007108 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007109 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007110 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007111 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007112 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007113 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007114 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007115 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007116 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007117 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007118 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007119 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007120 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007121 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007122 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007123 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007124 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007125 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007126 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007127 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007128 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007129 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007130 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007131 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007132 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007133 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007134 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007135 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007136 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007137 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007138 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007139 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007140 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007141 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007142 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007143 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007144 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007145 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007146 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007147 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007148 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007149 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007150 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007151 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007152 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007153 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007154 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007155 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007156 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007157 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007158 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007159 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007160 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007161 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007162 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007163 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007164 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007165 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007166 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007167 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007168 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007169 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007170 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007171 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007172 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007173 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007174 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007175 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007176 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007177 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007178 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007179 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007180 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007181 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007182 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007183 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007184 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007185 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007186 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007187 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007188 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007189 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007190 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007191 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007192 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007193 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007194 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007195 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007196 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007197 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007198 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007199 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007200 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007201 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007202 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007203 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007204 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007205 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007206 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007207 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007208 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007209 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007210 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007211 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007212 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007213 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007214 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007215 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007216 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007217 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007218 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007219 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007220 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007221 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007222 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007223 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007224 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007225 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007226 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007227 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007228 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007229 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007230 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007231 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007232 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007233 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007234 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007235 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007236 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007237 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007238 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007239 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007240 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007241 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007242 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007243 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007244 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007245 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007246 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007247 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007248 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007249 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007250 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007251 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007252 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007253 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007254 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007255 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007256 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007257 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007258 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007259 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007260 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007261 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007262 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007263 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007264 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007265 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007266 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007267 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007268 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007269 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007270 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007271 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007272 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007273 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007274 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007275 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007276 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007277 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007278 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007279 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007280 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007281 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007282 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007283 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007284 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007285 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007286 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007287 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007288 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007289 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007290 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007291 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007292 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007293 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007294 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007295 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007296 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007297 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007298 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007299 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007300 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007301 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007302 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007303 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007304 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007305 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007306 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007307 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007308 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007309 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007310 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007311 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007312 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007313 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007314 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007315 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007316 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007317 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007318 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007319 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007320 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007321 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007322 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007323 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007324 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007325 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007326 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007327 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007328 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007329 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007330 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007331 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007332 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007333 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007334 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007335 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007336 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007337 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007338 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007339 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007340 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007341 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007342 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007343 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007344 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007345 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007346 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007347 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007348 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007349 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007350 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007351 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007352 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007353 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007354 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007355 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007356 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007357 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007358 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007359 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007360 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007361 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007362 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007363 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007364 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007365 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007366 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007367 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007368 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007369 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007370 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007371 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007372 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007373 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007374 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007375 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007376 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007377 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007378 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007379 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007380 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007381 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007382 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007383 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007384 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007385 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007386 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007387 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007388 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007389 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007390 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007391 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007392 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007393 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007394 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007395 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007396 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007397 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007398 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007399 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007400 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007401 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007402 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007403 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007404 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007405 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007406 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007407 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007408 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007409 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007410 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007411 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007412 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007413 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007414 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007415 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007416 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007417 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007418 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007419 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007420 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007421 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007422 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007423 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007424 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007425 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007426 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007427 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007428 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007429 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007430 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007431 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007432 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007433 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007434 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007435 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007436 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007437 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007438 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007439 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007440 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007441 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007442 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007443 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007444 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007445 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007446 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007447 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007448 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007449 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007450 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007451 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007452 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007453 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007454 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007455 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007456 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007457 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007458 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007459 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007460 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007461 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007462 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007463 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007464 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007465 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007466 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007467 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007468 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007469 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007470 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007471 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007472 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007473 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007474 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007475 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007476 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007477 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007478 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007479 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007480 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007481 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007482 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007483 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007484 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007485 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007486 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007487 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007488 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007489 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007490 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007491 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007492 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007493 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007494 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007495 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007496 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007497 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007498 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007499 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007500 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007501 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007502 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007503 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007504 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007505 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007506 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007507 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007508 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007509 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007510 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007511 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007512 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007513 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007514 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007515 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007516 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007517 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007518 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007519 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007520 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007521 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007522 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007523 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007524 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007525 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007526 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007527 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007528 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007529 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007530 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007531 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007532 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007533 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007534 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007535 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007536 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007537 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007538 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007539 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007540 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007541 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007542 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007543 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007544 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007545 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007546 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007547 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007548 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007549 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007550 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007551 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007552 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007553 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007554 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007555 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007556 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007557 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007558 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007559 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007560 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007561 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007562 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007563 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007564 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007565 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007566 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007567 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007568 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007569 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007570 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007571 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007572 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007573 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007574 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007575 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007576 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007577 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007578 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007579 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007580 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007581 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007582 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007583 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007584 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007585 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007586 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007587 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007588 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007589 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007590 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007591 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007592 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007593 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007594 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007595 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007596 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007597 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007598 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007599 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007600 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007601 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007602 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007603 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007604 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007605 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007606 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007607 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007608 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007609 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007610 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007611 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007612 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007613 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007614 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007615 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007616 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007617 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007618 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007619 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007620 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007621 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007622 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007623 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007624 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007625 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007626 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007627 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007628 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007629 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007630 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007631 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007632 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007633 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007634 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007635 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007636 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007637 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007638 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007639 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007640 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007641 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007642 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007643 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007644 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007645 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007646 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007647 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007648 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007649 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007650 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007651 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007652 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007653 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007654 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007655 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007656 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007657 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007658 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007659 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007660 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007661 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007662 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007663 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007664 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007665 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007666 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007667 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007668 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007669 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007670 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007671 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007672 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007673 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007674 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007675 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007676 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007677 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007678 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007679 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007680 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007681 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007682 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007683 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007684 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007685 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007686 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007687 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007688 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007689 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007690 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007691 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007692 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007693 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007694 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007695 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007696 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007697 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007698 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007699 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007700 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007701 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007702 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007703 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007704 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007705 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007706 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007707 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007708 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007709 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007710 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007711 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007712 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007713 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007714 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007715 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007716 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007717 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007718 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007719 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007720 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007721 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007722 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007723 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007724 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007725 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007726 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007727 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007728 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007729 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007730 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007731 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007732 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007733 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007734 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007735 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007736 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007737 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007738 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007739 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007740 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007741 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007742 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007743 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007744 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007745 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007746 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007747 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007748 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007749 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007750 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007751 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007752 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007753 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007754 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007755 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007756 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007757 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007758 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007759 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007760 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007761 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007762 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007763 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007764 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007765 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007766 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007767 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007768 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007769 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007770 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007771 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007772 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007773 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007774 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007775 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007776 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007777 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007778 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007779 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007780 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007781 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007782 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007783 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007784 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007785 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007786 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007787 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007788 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007789 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007790 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007791 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007792 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007793 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007794 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007795 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007796 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007797 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007798 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007799 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007800 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007801 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007802 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007803 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007804 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007805 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007806 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007807 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007808 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007809 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007810 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007811 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007812 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007813 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007814 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007815 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007816 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007817 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007818 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007819 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007820 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007821 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007822 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007823 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007824 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007825 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007826 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007827 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007828 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007829 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007830 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007831 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007832 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007833 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007834 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007835 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007836 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007837 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007838 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007839 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007840 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007841 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007842 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007843 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007844 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007845 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007846 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007847 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007848 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007849 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007850 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007851 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007852 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007853 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007854 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007855 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007856 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007857 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007858 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007859 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007860 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007861 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007862 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007863 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007864 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007865 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007866 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007867 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007868 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007869 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007870 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007871 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007872 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007873 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007874 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007875 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007876 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007877 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007878 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007879 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007880 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007881 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007882 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007883 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007884 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007885 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007886 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007887 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007888 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007889 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007890 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007891 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007892 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007893 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007894 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007895 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007896 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007897 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007898 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007899 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007900 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007901 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007902 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007903 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007904 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007905 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007906 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007907 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007908 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007909 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007910 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007911 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007912 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007913 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007914 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007915 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007916 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007917 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007918 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007919 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007920 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007921 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007922 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007923 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007924 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007925 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007926 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007927 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007928 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007929 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007930 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007931 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007932 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007933 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007934 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007935 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007936 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007937 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007938 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007939 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007940 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007941 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007942 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007943 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007944 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007945 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007946 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007947 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007948 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007949 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007950 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007951 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007952 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007953 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007954 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007955 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007956 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007957 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007958 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007959 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007960 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007961 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007962 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007963 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007964 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007965 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007966 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007967 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007968 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007969 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007970 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007971 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007972 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007973 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007974 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007975 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007976 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007977 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007978 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007979 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007980 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007981 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007982 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007983 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007984 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007985 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007986 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007987 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007988 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007989 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007990 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007991 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007992 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007993 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007994 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007995 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007996 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007997 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007998 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000007999 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008000 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008002 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008003 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008004 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008005 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008006 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008007 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008008 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008009 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008010 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008011 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008012 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008013 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008014 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008015 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008016 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008017 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008018 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008019 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008020 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008021 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008022 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008023 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008024 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008025 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008026 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008027 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008028 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008029 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008030 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008031 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008032 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008033 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008034 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008035 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008036 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008037 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008038 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008039 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008040 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008041 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008042 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008043 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008044 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008045 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008046 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008047 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008048 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008049 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008050 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008051 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008052 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008053 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008054 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008055 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008056 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008057 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008058 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008059 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008060 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008061 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008062 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008063 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008064 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008065 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008066 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008067 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008068 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008069 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008070 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008071 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008072 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008073 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008074 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008075 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008076 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008077 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008078 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008079 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008080 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008081 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008082 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008083 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008084 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008085 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008086 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008087 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008088 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008089 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008090 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008091 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008092 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008093 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008094 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008095 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008096 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008097 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008098 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008099 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008100 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008101 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008102 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008103 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008104 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008105 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008106 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008107 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008108 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008109 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008110 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008111 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008112 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008113 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008114 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008115 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008116 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008117 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008118 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008119 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008120 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008121 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008122 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008123 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008124 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008125 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008126 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008127 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008128 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008129 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008130 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008131 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008132 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008133 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008134 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008135 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008136 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008137 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008138 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008139 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008140 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008141 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008142 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008143 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008144 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008145 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008146 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008147 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008148 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008149 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008150 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008151 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008152 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008153 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008154 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008155 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008156 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008157 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008158 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008159 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008160 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008161 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008162 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008163 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008164 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008165 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008166 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008167 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008168 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008169 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008170 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008171 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008172 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008173 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008174 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008175 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008176 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008177 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008178 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008179 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008180 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008181 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008182 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008183 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008184 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008185 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008186 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008187 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008188 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008189 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008190 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008191 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008192 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008193 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008194 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008195 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008196 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008197 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008198 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008199 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008200 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008201 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008202 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008203 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008204 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008205 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008206 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008207 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008208 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008209 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008210 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008211 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008212 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008213 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008214 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008215 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008216 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008217 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008218 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008219 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008220 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008221 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008222 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008223 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008224 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008225 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008226 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008227 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008228 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008229 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008230 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008231 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008232 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008233 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008234 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008235 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008236 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008237 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008238 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008239 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008240 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008241 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008242 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008243 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008244 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008245 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008246 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008247 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008248 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008249 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008250 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008251 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008252 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008253 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008254 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008255 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008256 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008257 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008258 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008259 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008260 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008261 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008262 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008263 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008264 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008265 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008266 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008267 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008268 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008269 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008270 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008271 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008272 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008273 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008274 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008275 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008276 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008277 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008278 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008279 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008280 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008281 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008282 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008283 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008284 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008285 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008286 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008287 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008288 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008289 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008290 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008291 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008292 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008293 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008294 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008295 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008296 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008297 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008298 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008299 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008300 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008301 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008302 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008303 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008304 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008305 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008306 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008307 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008308 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008309 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008310 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008311 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008312 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008313 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008314 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008315 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008316 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008317 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008318 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008319 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008320 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008321 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008322 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008323 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008324 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008325 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008326 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008327 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008328 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008329 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008330 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008331 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008332 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008333 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008334 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008335 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008336 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008337 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008338 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008339 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008340 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008341 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008342 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008343 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008344 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008345 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008346 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008347 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008348 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008349 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008350 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008351 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008352 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008353 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008354 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008355 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008356 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008357 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008358 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008359 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008360 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008361 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008362 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008363 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008364 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008365 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008366 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008367 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008368 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008369 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008370 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008371 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008372 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008373 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008374 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008375 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008376 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008377 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008378 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008379 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008380 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008381 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008382 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008383 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008384 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008385 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008386 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008387 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008388 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008389 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008390 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008391 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008392 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008393 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008394 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008395 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008396 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008397 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008398 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008399 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008400 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008401 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008402 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008403 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008404 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008405 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008406 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008407 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008408 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008409 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008410 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008411 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008412 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008413 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008414 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008415 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008416 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008417 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008418 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008419 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008420 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008421 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008422 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008423 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008424 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008425 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008426 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008427 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008428 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008429 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008430 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008431 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008432 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008433 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008434 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008435 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008436 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008437 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008438 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008439 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008440 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008441 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008442 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008443 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008444 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008445 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008446 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008447 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008448 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008449 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008450 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008451 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008452 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008453 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008454 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008455 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008456 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008457 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008458 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008459 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008460 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008461 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008462 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008463 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008464 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008465 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008466 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008467 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008468 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008469 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008470 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008471 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008472 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008473 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008474 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008475 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008476 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008477 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008478 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008479 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008480 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008481 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008482 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008483 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008484 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008485 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008486 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008487 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008488 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008489 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008490 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008491 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008492 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008493 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008494 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008495 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008496 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008497 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008498 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008499 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008500 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008501 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008502 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008503 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008504 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008505 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008506 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008507 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008508 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008509 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008510 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008511 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008512 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008513 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008514 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008515 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008516 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008517 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008518 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008519 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008520 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008521 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008522 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008523 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008524 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008525 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008526 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008527 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008528 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008529 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008530 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008531 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008532 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008533 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008534 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008535 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008536 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008537 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008538 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008539 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008540 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008541 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008542 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008543 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008544 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008545 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008546 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008547 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008548 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008549 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008550 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008551 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008552 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008553 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008554 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008555 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008556 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008557 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008558 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008559 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008560 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008561 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008562 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008563 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008564 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008565 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008566 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008567 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008568 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008569 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008570 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008571 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008572 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008573 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008574 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008575 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008576 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008577 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008578 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008579 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008580 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008581 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008582 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008583 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008584 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008585 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008586 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008587 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008588 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008589 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008590 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008591 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008592 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008593 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008594 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008595 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008596 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008597 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008598 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008599 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008600 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008601 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008602 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008603 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008604 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008605 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008606 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008607 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008608 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008609 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008610 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008611 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008612 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008613 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008614 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008615 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008616 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008617 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008618 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008619 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008620 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008621 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008622 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008623 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008624 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008625 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008626 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008627 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008628 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008629 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008630 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008631 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008632 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008633 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008634 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008635 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008636 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008637 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008638 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008639 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008640 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008641 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008642 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008643 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008644 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008645 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008646 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008647 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008648 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008649 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008650 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008651 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008652 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008653 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008654 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008655 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008656 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008657 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008658 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008659 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008660 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008661 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008662 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008663 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008664 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008665 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008666 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008667 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008668 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008669 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008670 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008671 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008672 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008673 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008674 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008675 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008676 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008677 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008678 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008679 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008680 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008681 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008682 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008683 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008684 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008685 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008686 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008687 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008688 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008689 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008690 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008691 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008692 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008693 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008694 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008695 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008696 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008697 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008698 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008699 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008700 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008701 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008702 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008703 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008704 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008705 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008706 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008707 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008708 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008709 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008710 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008711 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008712 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008713 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008714 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008715 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008716 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008717 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008718 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008719 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008720 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008721 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008722 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008723 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008724 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008725 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008726 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008727 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008728 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008729 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008730 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008731 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008732 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008733 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008734 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008735 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008736 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008737 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008738 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008739 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008740 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008741 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008742 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008743 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008744 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008745 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008746 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008747 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008748 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008749 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008750 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008751 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008752 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008753 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008754 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008755 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008756 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008757 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008758 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008759 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008760 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008761 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008762 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008763 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008764 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008765 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008766 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008767 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008768 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008769 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008770 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008771 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008772 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008773 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008774 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008775 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008776 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008777 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008778 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008779 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008780 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008781 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008782 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008783 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008784 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008785 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008786 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008787 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008788 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008789 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008790 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008791 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008792 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008793 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008794 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008795 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008796 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008797 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008798 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008799 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008800 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008801 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008802 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008803 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008804 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008805 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008806 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008807 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008808 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008809 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008810 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008811 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008812 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008813 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008814 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008815 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008816 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008817 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008818 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008819 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008820 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008821 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008822 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008823 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008824 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008825 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008826 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008827 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008828 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008829 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008830 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008831 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008832 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008833 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008834 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008835 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008836 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008837 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008838 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008839 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008840 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008841 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008842 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008843 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008844 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008845 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008846 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008847 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008848 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008849 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008850 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008851 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008852 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008853 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008854 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008855 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008856 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008857 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008858 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008859 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008860 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008861 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008862 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008863 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008864 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008865 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008866 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008867 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008868 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008869 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008870 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008871 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008872 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008873 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008874 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008875 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008876 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008877 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008878 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008879 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008880 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008881 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008882 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008883 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008884 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008885 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008886 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008887 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008888 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008889 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008890 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008891 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008892 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008893 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008894 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008895 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008896 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008897 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008898 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008899 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008900 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008901 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008902 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008903 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008904 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008905 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008906 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008907 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008908 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008909 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008910 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008911 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008912 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008913 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008914 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008915 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008916 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008917 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008918 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008919 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008920 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008921 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008922 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008923 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008924 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008925 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008926 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008927 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008928 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008929 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008930 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008931 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008932 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008933 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008934 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008935 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008936 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008937 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008938 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008939 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008940 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008941 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008942 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008943 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008944 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008945 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008946 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008947 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008948 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008949 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008950 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008951 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008952 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008953 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008954 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008955 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008956 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008957 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008958 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008959 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008960 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008961 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008962 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008963 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008964 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008965 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008966 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008967 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008968 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008969 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008970 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008971 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008972 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008973 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008974 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008975 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008976 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008977 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008978 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008979 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008980 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008981 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008982 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008983 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008984 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008985 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008986 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008987 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008988 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008989 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008990 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008991 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008992 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008993 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008994 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008995 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008996 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008997 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008998 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000008999 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009000 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009002 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009003 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009004 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009005 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009006 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009007 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009008 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009009 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009010 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009011 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009012 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009013 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009014 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009015 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009016 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009017 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009018 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009019 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009020 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009021 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009022 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009023 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009024 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009025 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009026 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009027 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009028 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009029 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009030 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009031 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009032 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009033 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009034 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009035 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009036 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009037 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009038 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009039 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009040 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009041 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009042 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009043 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009044 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009045 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009046 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009047 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009048 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009049 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009050 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009051 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009052 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009053 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009054 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009055 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009056 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009057 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009058 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009059 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009060 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009061 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009062 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009063 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009064 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009065 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009066 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009067 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009068 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009069 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009070 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009071 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009072 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009073 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009074 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009075 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009076 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009077 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009078 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009079 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009080 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009081 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009082 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009083 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009084 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009085 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009086 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009087 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009088 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009089 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009090 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009091 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009092 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009093 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009094 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009095 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009096 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009097 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009098 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009099 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009100 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009101 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009102 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009103 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009104 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009105 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009106 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009107 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009108 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009109 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009110 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009111 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009112 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009113 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009114 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009115 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009116 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009117 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009118 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009119 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009120 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009121 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009122 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009123 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009124 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009125 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009126 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009127 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009128 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009129 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009130 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009131 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009132 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009133 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009134 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009135 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009136 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009137 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009138 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009139 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009140 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009141 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009142 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009143 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009144 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009145 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009146 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009147 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009148 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009149 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009150 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009151 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009152 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009153 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009154 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009155 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009156 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009157 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009158 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009159 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009160 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009161 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009162 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009163 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009164 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009165 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009166 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009167 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009168 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009169 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009170 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009171 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009172 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009173 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009174 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009175 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009176 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009177 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009178 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009179 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009180 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009181 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009182 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009183 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009184 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009185 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009186 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009187 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009188 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009189 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009190 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009191 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009192 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009193 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009194 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009195 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009196 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009197 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009198 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009199 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009200 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009201 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009202 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009203 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009204 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009205 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009206 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009207 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009208 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009209 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009210 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009211 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009212 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009213 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009214 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009215 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009216 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009217 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009218 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009219 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009220 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009221 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009222 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009223 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009224 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009225 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009226 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009227 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009228 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009229 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009230 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009231 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009232 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009233 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009234 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009235 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009236 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009237 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009238 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009239 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009240 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009241 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009242 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009243 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009244 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009245 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009246 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009247 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009248 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009249 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009250 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009251 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009252 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009253 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009254 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009255 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009256 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009257 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009258 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009259 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009260 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009261 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009262 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009263 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009264 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009265 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009266 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009267 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009268 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009269 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009270 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009271 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009272 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009273 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009274 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009275 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009276 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009277 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009278 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009279 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009280 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009281 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009282 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009283 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009284 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009285 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009286 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009287 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009288 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009289 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009290 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009291 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009292 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009293 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009294 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009295 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009296 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009297 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009298 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009299 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009300 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009301 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009302 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009303 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009304 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009305 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009306 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009307 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009308 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009309 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009310 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009311 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009312 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009313 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009314 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009315 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009316 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009317 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009318 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009319 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009320 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009321 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009322 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009323 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009324 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009325 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009326 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009327 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009328 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009329 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009330 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009331 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009332 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009333 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009334 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009335 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009336 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009337 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009338 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009339 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009340 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009341 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009342 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009343 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009344 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009345 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009346 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009347 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009348 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009349 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009350 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009351 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009352 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009353 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009354 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009355 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009356 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009357 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009358 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009359 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009360 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009361 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009362 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009363 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009364 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009365 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009366 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009367 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009368 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009369 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009370 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009371 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009372 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009373 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009374 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009375 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009376 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009377 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009378 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009379 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009380 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009381 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009382 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009383 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009384 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009385 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009386 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009387 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009388 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009389 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009390 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009391 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009392 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009393 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009394 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009395 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009396 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009397 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009398 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009399 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009400 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009401 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009402 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009403 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009404 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009405 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009406 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009407 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009408 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009409 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009410 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009411 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009412 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009413 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009414 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009415 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009416 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009417 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009418 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009419 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009420 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009421 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009422 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009423 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009424 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009425 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009426 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009427 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009428 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009429 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009430 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009431 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009432 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009433 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009434 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009435 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009436 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009437 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009438 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009439 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009440 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009441 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009442 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009443 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009444 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009445 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009446 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009447 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009448 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009449 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009450 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009451 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009452 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009453 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009454 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009455 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009456 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009457 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009458 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009459 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009460 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009461 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009462 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009463 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009464 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009465 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009466 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009467 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009468 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009469 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009470 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009471 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009472 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009473 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009474 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009475 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009476 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009477 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009478 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009479 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009480 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009481 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009482 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009483 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009484 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009485 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009486 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009487 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009488 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009489 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009490 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009491 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009492 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009493 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009494 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009495 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009496 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009497 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009498 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009499 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009500 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009501 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009502 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009503 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009504 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009505 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009506 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009507 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009508 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009509 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009510 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009511 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009512 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009513 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009514 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009515 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009516 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009517 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009518 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009519 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009520 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009521 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009522 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009523 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009524 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009525 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009526 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009527 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009528 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009529 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009530 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009531 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009532 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009533 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009534 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009535 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009536 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009537 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009538 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009539 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009540 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009541 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009542 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009543 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009544 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009545 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009546 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009547 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009548 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009549 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009550 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009551 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009552 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009553 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009554 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009555 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009556 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009557 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009558 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009559 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009560 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009561 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009562 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009563 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009564 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009565 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009566 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009567 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009568 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009569 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009570 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009571 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009572 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009573 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009574 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009575 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009576 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009577 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009578 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009579 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009580 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009581 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009582 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009583 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009584 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009585 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009586 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009587 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009588 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009589 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009590 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009591 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009592 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009593 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009594 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009595 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009596 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009597 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009598 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009599 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009600 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009601 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009602 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009603 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009604 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009605 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009606 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009607 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009608 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009609 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009610 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009611 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009612 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009613 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009614 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009615 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009616 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009617 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009618 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009619 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009620 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009621 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009622 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009623 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009624 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009625 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009626 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009627 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009628 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009629 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009630 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009631 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009632 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009633 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009634 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009635 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009636 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009637 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009638 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009639 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009640 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009641 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009642 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009643 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009644 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009645 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009646 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009647 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009648 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009649 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009650 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009651 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009652 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009653 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009654 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009655 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009656 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009657 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009658 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009659 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009660 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009661 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009662 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009663 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009664 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009665 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009666 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009667 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009668 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009669 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009670 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009671 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009672 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009673 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009674 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009675 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009676 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009677 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009678 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009679 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009680 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009681 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009682 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009683 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009684 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009685 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009686 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009687 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009688 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009689 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009690 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009691 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009692 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009693 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009694 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009695 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009696 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009697 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009698 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009699 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009700 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009701 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009702 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009703 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009704 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009705 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009706 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009707 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009708 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009709 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009710 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009711 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009712 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009713 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009714 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009715 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009716 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009717 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009718 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009719 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009720 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009721 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009722 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009723 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009724 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009725 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009726 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009727 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009728 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009729 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009730 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009731 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009732 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009733 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009734 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009735 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009736 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009737 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009738 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009739 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009740 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009741 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009742 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009743 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009744 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009745 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009746 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009747 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009748 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009749 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009750 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009751 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009752 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009753 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009754 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009755 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009756 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009757 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009758 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009759 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009760 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009761 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009762 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009763 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009764 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009765 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009766 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009767 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009768 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009769 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009770 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009771 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009772 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009773 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009774 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009775 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009776 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009777 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009778 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009779 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009780 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009781 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009782 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009783 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009784 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009785 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009786 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009787 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009788 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009789 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009790 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009791 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009792 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009793 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009794 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009795 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009796 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009797 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009798 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009799 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009800 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009801 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009802 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009803 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009804 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009805 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009806 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009807 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009808 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009809 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009810 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009811 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009812 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009813 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009814 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009815 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009816 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009817 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009818 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009819 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009820 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009821 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009822 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009823 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009824 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009825 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009826 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009827 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009828 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009829 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009830 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009831 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009832 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009833 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009834 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009835 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009836 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009837 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009838 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009839 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009840 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009841 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009842 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009843 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009844 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009845 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009846 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009847 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009848 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009849 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009850 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009851 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009852 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009853 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009854 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009855 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009856 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009857 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009858 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009859 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009860 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009861 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009862 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009863 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009864 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009865 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009866 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009867 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009868 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009869 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009870 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009871 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009872 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009873 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009874 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009875 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009876 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009877 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009878 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009879 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009880 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009881 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009882 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009883 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009884 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009885 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009886 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009887 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009888 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009889 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009890 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009891 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009892 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009893 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009894 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009895 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009896 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009897 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009898 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009899 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009900 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009901 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009902 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009903 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009904 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009905 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009906 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009907 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009908 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009909 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009910 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009911 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009912 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009913 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009914 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009915 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009916 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009917 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009918 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009919 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009920 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009921 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009922 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009923 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009924 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009925 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009926 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009927 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009928 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009929 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009930 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009931 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009932 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009933 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009934 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009935 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009936 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009937 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009938 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009939 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009940 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009941 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009942 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009943 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009944 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009945 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009946 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009947 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009948 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009949 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009950 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009951 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009952 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009953 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009954 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009955 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009956 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009957 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009958 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009959 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009960 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009961 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009962 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009963 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009964 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009965 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009966 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009967 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009968 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009969 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009970 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009971 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009972 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009973 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009974 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009975 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009976 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009977 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009978 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009979 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009980 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009981 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009982 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009983 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009984 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009985 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009986 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009987 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009988 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009989 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009990 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009991 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009992 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009993 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009994 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009995 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009996 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009997 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009998 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000009999 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010000 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010002 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010003 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010004 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010005 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010006 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010007 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010008 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010009 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010010 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010011 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010012 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010013 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010014 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010015 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010016 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010017 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010018 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010019 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010020 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010021 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010022 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010023 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010024 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010025 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010026 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010027 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010028 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010029 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010030 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010031 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010032 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010033 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010034 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010035 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010036 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010037 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010038 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010039 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010040 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010041 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010042 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010043 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010044 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010045 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010046 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010047 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010048 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010049 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010050 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010051 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010052 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010053 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010054 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010055 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010056 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010057 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010058 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010059 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010060 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010061 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010062 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010063 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010064 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010065 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010066 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010067 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010068 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010069 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010070 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010071 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010072 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010073 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010074 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010075 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010076 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010077 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010078 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010079 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010080 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010081 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010082 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010083 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010084 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010085 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010086 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010087 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010088 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010089 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010090 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010091 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010092 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010093 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010094 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010095 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010096 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010097 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010098 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010099 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010100 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010101 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010102 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010103 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010104 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010105 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010106 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010107 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010108 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010109 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010110 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010111 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010112 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010113 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010114 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010115 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010116 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010117 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010118 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010119 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010120 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010121 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010122 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010123 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010124 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010125 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010126 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010127 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010128 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010129 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010130 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010131 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010132 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010133 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010134 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010135 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010136 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010137 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010138 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010139 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010140 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010141 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010142 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010143 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010144 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010145 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010146 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010147 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010148 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010149 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010150 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010151 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010152 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010153 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010154 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010155 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010156 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010157 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010158 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010159 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010160 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010161 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010162 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010163 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010164 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010165 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010166 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010167 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010168 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010169 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010170 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010171 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010172 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010173 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010174 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010175 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010176 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010177 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010178 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010179 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010180 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010181 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010182 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010183 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010184 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010185 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010186 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010187 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010188 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010189 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010190 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010191 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010192 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010193 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010194 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010195 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010196 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010197 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010198 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010199 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010200 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010201 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010202 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010203 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010204 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010205 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010206 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010207 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010208 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010209 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010210 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010211 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010212 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010213 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010214 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010215 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010216 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010217 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010218 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010219 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010220 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010221 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010222 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010223 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010224 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010225 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010226 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010227 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010228 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010229 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010230 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010231 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010232 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010233 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010234 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010235 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010236 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010237 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010238 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010239 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000010240 | buy volume=345 symbol=EURUSD price=1.5 | 100      |
		#| 1000000001 | buy volume=345 symbol=EURUSD price=1.5 | 100      |

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
	| login      |
	| 1000000001 |
	| 1000000002 |
	| 1000000003 |
	| 1000000004 |
	| 1000000005 |
	| 1000000006 |
	| 1000000007 |
	| 1000000008 |
	| 1000000009 |
	| 1000000010 |
	| 1000000011 |
	| 1000000012 |
	| 1000000013 |
	| 1000000014 |
	| 1000000015 |
	| 1000000016 |
	| 1000000017 |
	| 1000000018 |
	| 1000000019 |
	| 1000000020 |
	| 1000000021 |
	| 1000000022 |
	| 1000000023 |
	| 1000000024 |
	| 1000000025 |
	| 1000000026 |
	| 1000000027 |
	| 1000000028 |
	| 1000000029 |
	| 1000000030 |
	| 1000000031 |
	| 1000000032 |
	| 1000000033 |
	| 1000000034 |
	| 1000000035 |
	| 1000000036 |
	| 1000000037 |
	| 1000000038 |
	| 1000000039 |
	| 1000000040 |
	| 1000000041 |
	| 1000000042 |
	| 1000000043 |
	| 1000000044 |
	| 1000000045 |
	| 1000000046 |
	| 1000000047 |
	| 1000000048 |
	| 1000000049 |
	| 1000000050 |
	| 1000000051 |
	| 1000000052 |
	| 1000000053 |
	| 1000000054 |
	| 1000000055 |
	| 1000000056 |
	| 1000000057 |
	| 1000000058 |
	| 1000000059 |
	| 1000000060 |
	| 1000000061 |
	| 1000000062 |
	| 1000000063 |
	| 1000000064 |
	| 1000000065 |
	| 1000000066 |
	| 1000000067 |
	| 1000000068 |
	| 1000000069 |
	| 1000000070 |
	| 1000000071 |
	| 1000000072 |
	| 1000000073 |
	| 1000000074 |
	| 1000000075 |
	| 1000000076 |
	| 1000000077 |
	| 1000000078 |
	| 1000000079 |
	| 1000000080 |
	| 1000000081 |
	| 1000000082 |
	| 1000000083 |
	| 1000000084 |
	| 1000000085 |
	| 1000000086 |
	| 1000000087 |
	| 1000000088 |
	| 1000000089 |
	| 1000000090 |
	| 1000000091 |
	| 1000000092 |
	| 1000000093 |
	| 1000000094 |
	| 1000000095 |
	| 1000000096 |
	| 1000000097 |
	| 1000000098 |
	| 1000000099 |
	| 1000000100 |
	| 1000000101 |
	| 1000000102 |
	| 1000000103 |
	| 1000000104 |
	| 1000000105 |
	| 1000000106 |
	| 1000000107 |
	| 1000000108 |
	| 1000000109 |
	| 1000000110 |
	| 1000000111 |
	| 1000000112 |
	| 1000000113 |
	| 1000000114 |
	| 1000000115 |
	| 1000000116 |
	| 1000000117 |
	| 1000000118 |
	| 1000000119 |
	| 1000000120 |
	| 1000000121 |
	| 1000000122 |
	| 1000000123 |
	| 1000000124 |
	| 1000000125 |
	| 1000000126 |
	| 1000000127 |
	| 1000000128 |
	| 1000000129 |
	| 1000000130 |
	| 1000000131 |
	| 1000000132 |
	| 1000000133 |
	| 1000000134 |
	| 1000000135 |
	| 1000000136 |
	| 1000000137 |
	| 1000000138 |
	| 1000000139 |
	| 1000000140 |
	| 1000000141 |
	| 1000000142 |
	| 1000000143 |
	| 1000000144 |
	| 1000000145 |
	| 1000000146 |
	| 1000000147 |
	| 1000000148 |
	| 1000000149 |
	| 1000000150 |
	| 1000000151 |
	| 1000000152 |
	| 1000000153 |
	| 1000000154 |
	| 1000000155 |
	| 1000000156 |
	| 1000000157 |
	| 1000000158 |
	| 1000000159 |
	| 1000000160 |
	| 1000000161 |
	| 1000000162 |
	| 1000000163 |
	| 1000000164 |
	| 1000000165 |
	| 1000000166 |
	| 1000000167 |
	| 1000000168 |
	| 1000000169 |
	| 1000000170 |
	| 1000000171 |
	| 1000000172 |
	| 1000000173 |
	| 1000000174 |
	| 1000000175 |
	| 1000000176 |
	| 1000000177 |
	| 1000000178 |
	| 1000000179 |
	| 1000000180 |
	| 1000000181 |
	| 1000000182 |
	| 1000000183 |
	| 1000000184 |
	| 1000000185 |
	| 1000000186 |
	| 1000000187 |
	| 1000000188 |
	| 1000000189 |
	| 1000000190 |
	| 1000000191 |
	| 1000000192 |
	| 1000000193 |
	| 1000000194 |
	| 1000000195 |
	| 1000000196 |
	| 1000000197 |
	| 1000000198 |
	| 1000000199 |
	| 1000000200 |
	| 1000000201 |
	| 1000000202 |
	| 1000000203 |
	| 1000000204 |
	| 1000000205 |
	| 1000000206 |
	| 1000000207 |
	| 1000000208 |
	| 1000000209 |
	| 1000000210 |
	| 1000000211 |
	| 1000000212 |
	| 1000000213 |
	| 1000000214 |
	| 1000000215 |
	| 1000000216 |
	| 1000000217 |
	| 1000000218 |
	| 1000000219 |
	| 1000000220 |
	| 1000000221 |
	| 1000000222 |
	| 1000000223 |
	| 1000000224 |
	| 1000000225 |
	| 1000000226 |
	| 1000000227 |
	| 1000000228 |
	| 1000000229 |
	| 1000000230 |
	| 1000000231 |
	| 1000000232 |
	| 1000000233 |
	| 1000000234 |
	| 1000000235 |
	| 1000000236 |
	| 1000000237 |
	| 1000000238 |
	| 1000000239 |
	| 1000000240 |
	| 1000000241 |
	| 1000000242 |
	| 1000000243 |
	| 1000000244 |
	| 1000000245 |
	| 1000000246 |
	| 1000000247 |
	| 1000000248 |
	| 1000000249 |
	| 1000000250 |
	| 1000000251 |
	| 1000000252 |
	| 1000000253 |
	| 1000000254 |
	| 1000000255 |
	| 1000000256 |
	| 1000000257 |
	| 1000000258 |
	| 1000000259 |
	| 1000000260 |
	| 1000000261 |
	| 1000000262 |
	| 1000000263 |
	| 1000000264 |
	| 1000000265 |
	| 1000000266 |
	| 1000000267 |
	| 1000000268 |
	| 1000000269 |
	| 1000000270 |
	| 1000000271 |
	| 1000000272 |
	| 1000000273 |
	| 1000000274 |
	| 1000000275 |
	| 1000000276 |
	| 1000000277 |
	| 1000000278 |
	| 1000000279 |
	| 1000000280 |
	| 1000000281 |
	| 1000000282 |
	| 1000000283 |
	| 1000000284 |
	| 1000000285 |
	| 1000000286 |
	| 1000000287 |
	| 1000000288 |
	| 1000000289 |
	| 1000000290 |
	| 1000000291 |
	| 1000000292 |
	| 1000000293 |
	| 1000000294 |
	| 1000000295 |
	| 1000000296 |
	| 1000000297 |
	| 1000000298 |
	| 1000000299 |
	| 1000000300 |
	| 1000000301 |
	| 1000000302 |
	| 1000000303 |
	| 1000000304 |
	| 1000000305 |
	| 1000000306 |
	| 1000000307 |
	| 1000000308 |
	| 1000000309 |
	| 1000000310 |
	| 1000000311 |
	| 1000000312 |
	| 1000000313 |
	| 1000000314 |
	| 1000000315 |
	| 1000000316 |
	| 1000000317 |
	| 1000000318 |
	| 1000000319 |
	| 1000000320 |
	| 1000000321 |
	| 1000000322 |
	| 1000000323 |
	| 1000000324 |
	| 1000000325 |
	| 1000000326 |
	| 1000000327 |
	| 1000000328 |
	| 1000000329 |
	| 1000000330 |
	| 1000000331 |
	| 1000000332 |
	| 1000000333 |
	| 1000000334 |
	| 1000000335 |
	| 1000000336 |
	| 1000000337 |
	| 1000000338 |
	| 1000000339 |
	| 1000000340 |
	| 1000000341 |
	| 1000000342 |
	| 1000000343 |
	| 1000000344 |
	| 1000000345 |
	| 1000000346 |
	| 1000000347 |
	| 1000000348 |
	| 1000000349 |
	| 1000000350 |
	| 1000000351 |
	| 1000000352 |
	| 1000000353 |
	| 1000000354 |
	| 1000000355 |
	| 1000000356 |
	| 1000000357 |
	| 1000000358 |
	| 1000000359 |
	| 1000000360 |
	| 1000000361 |
	| 1000000362 |
	| 1000000363 |
	| 1000000364 |
	| 1000000365 |
	| 1000000366 |
	| 1000000367 |
	| 1000000368 |
	| 1000000369 |
	| 1000000370 |
	| 1000000371 |
	| 1000000372 |
	| 1000000373 |
	| 1000000374 |
	| 1000000375 |
	| 1000000376 |
	| 1000000377 |
	| 1000000378 |
	| 1000000379 |
	| 1000000380 |
	| 1000000381 |
	| 1000000382 |
	| 1000000383 |
	| 1000000384 |
	| 1000000385 |
	| 1000000386 |
	| 1000000387 |
	| 1000000388 |
	| 1000000389 |
	| 1000000390 |
	| 1000000391 |
	| 1000000392 |
	| 1000000393 |
	| 1000000394 |
	| 1000000395 |
	| 1000000396 |
	| 1000000397 |
	| 1000000398 |
	| 1000000399 |
	| 1000000400 |
	| 1000000401 |
	| 1000000402 |
	| 1000000403 |
	| 1000000404 |
	| 1000000405 |
	| 1000000406 |
	| 1000000407 |
	| 1000000408 |
	| 1000000409 |
	| 1000000410 |
	| 1000000411 |
	| 1000000412 |
	| 1000000413 |
	| 1000000414 |
	| 1000000415 |
	| 1000000416 |
	| 1000000417 |
	| 1000000418 |
	| 1000000419 |
	| 1000000420 |
	| 1000000421 |
	| 1000000422 |
	| 1000000423 |
	| 1000000424 |
	| 1000000425 |
	| 1000000426 |
	| 1000000427 |
	| 1000000428 |
	| 1000000429 |
	| 1000000430 |
	| 1000000431 |
	| 1000000432 |
	| 1000000433 |
	| 1000000434 |
	| 1000000435 |
	| 1000000436 |
	| 1000000437 |
	| 1000000438 |
	| 1000000439 |
	| 1000000440 |
	| 1000000441 |
	| 1000000442 |
	| 1000000443 |
	| 1000000444 |
	| 1000000445 |
	| 1000000446 |
	| 1000000447 |
	| 1000000448 |
	| 1000000449 |
	| 1000000450 |
	| 1000000451 |
	| 1000000452 |
	| 1000000453 |
	| 1000000454 |
	| 1000000455 |
	| 1000000456 |
	| 1000000457 |
	| 1000000458 |
	| 1000000459 |
	| 1000000460 |
	| 1000000461 |
	| 1000000462 |
	| 1000000463 |
	| 1000000464 |
	| 1000000465 |
	| 1000000466 |
	| 1000000467 |
	| 1000000468 |
	| 1000000469 |
	| 1000000470 |
	| 1000000471 |
	| 1000000472 |
	| 1000000473 |
	| 1000000474 |
	| 1000000475 |
	| 1000000476 |
	| 1000000477 |
	| 1000000478 |
	| 1000000479 |
	| 1000000480 |
	| 1000000481 |
	| 1000000482 |
	| 1000000483 |
	| 1000000484 |
	| 1000000485 |
	| 1000000486 |
	| 1000000487 |
	| 1000000488 |
	| 1000000489 |
	| 1000000490 |
	| 1000000491 |
	| 1000000492 |
	| 1000000493 |
	| 1000000494 |
	| 1000000495 |
	| 1000000496 |
	| 1000000497 |
	| 1000000498 |
	| 1000000499 |
	| 1000000500 |
	| 1000000501 |
	| 1000000502 |
	| 1000000503 |
	| 1000000504 |
	| 1000000505 |
	| 1000000506 |
	| 1000000507 |
	| 1000000508 |
	| 1000000509 |
	| 1000000510 |
	| 1000000511 |
	| 1000000512 |
	| 1000000513 |
	| 1000000514 |
	| 1000000515 |
	| 1000000516 |
	| 1000000517 |
	| 1000000518 |
	| 1000000519 |
	| 1000000520 |
	| 1000000521 |
	| 1000000522 |
	| 1000000523 |
	| 1000000524 |
	| 1000000525 |
	| 1000000526 |
	| 1000000527 |
	| 1000000528 |
	| 1000000529 |
	| 1000000530 |
	| 1000000531 |
	| 1000000532 |
	| 1000000533 |
	| 1000000534 |
	| 1000000535 |
	| 1000000536 |
	| 1000000537 |
	| 1000000538 |
	| 1000000539 |
	| 1000000540 |
	| 1000000541 |
	| 1000000542 |
	| 1000000543 |
	| 1000000544 |
	| 1000000545 |
	| 1000000546 |
	| 1000000547 |
	| 1000000548 |
	| 1000000549 |
	| 1000000550 |
	| 1000000551 |
	| 1000000552 |
	| 1000000553 |
	| 1000000554 |
	| 1000000555 |
	| 1000000556 |
	| 1000000557 |
	| 1000000558 |
	| 1000000559 |
	| 1000000560 |
	| 1000000561 |
	| 1000000562 |
	| 1000000563 |
	| 1000000564 |
	| 1000000565 |
	| 1000000566 |
	| 1000000567 |
	| 1000000568 |
	| 1000000569 |
	| 1000000570 |
	| 1000000571 |
	| 1000000572 |
	| 1000000573 |
	| 1000000574 |
	| 1000000575 |
	| 1000000576 |
	| 1000000577 |
	| 1000000578 |
	| 1000000579 |
	| 1000000580 |
	| 1000000581 |
	| 1000000582 |
	| 1000000583 |
	| 1000000584 |
	| 1000000585 |
	| 1000000586 |
	| 1000000587 |
	| 1000000588 |
	| 1000000589 |
	| 1000000590 |
	| 1000000591 |
	| 1000000592 |
	| 1000000593 |
	| 1000000594 |
	| 1000000595 |
	| 1000000596 |
	| 1000000597 |
	| 1000000598 |
	| 1000000599 |
	| 1000000600 |
	| 1000000601 |
	| 1000000602 |
	| 1000000603 |
	| 1000000604 |
	| 1000000605 |
	| 1000000606 |
	| 1000000607 |
	| 1000000608 |
	| 1000000609 |
	| 1000000610 |
	| 1000000611 |
	| 1000000612 |
	| 1000000613 |
	| 1000000614 |
	| 1000000615 |
	| 1000000616 |
	| 1000000617 |
	| 1000000618 |
	| 1000000619 |
	| 1000000620 |
	| 1000000621 |
	| 1000000622 |
	| 1000000623 |
	| 1000000624 |
	| 1000000625 |
	| 1000000626 |
	| 1000000627 |
	| 1000000628 |
	| 1000000629 |
	| 1000000630 |
	| 1000000631 |
	| 1000000632 |
	| 1000000633 |
	| 1000000634 |
	| 1000000635 |
	| 1000000636 |
	| 1000000637 |
	| 1000000638 |
	| 1000000639 |
	| 1000000640 |
	| 1000000641 |
	| 1000000642 |
	| 1000000643 |
	| 1000000644 |
	| 1000000645 |
	| 1000000646 |
	| 1000000647 |
	| 1000000648 |
	| 1000000649 |
	| 1000000650 |
	| 1000000651 |
	| 1000000652 |
	| 1000000653 |
	| 1000000654 |
	| 1000000655 |
	| 1000000656 |
	| 1000000657 |
	| 1000000658 |
	| 1000000659 |
	| 1000000660 |
	| 1000000661 |
	| 1000000662 |
	| 1000000663 |
	| 1000000664 |
	| 1000000665 |
	| 1000000666 |
	| 1000000667 |
	| 1000000668 |
	| 1000000669 |
	| 1000000670 |
	| 1000000671 |
	| 1000000672 |
	| 1000000673 |
	| 1000000674 |
	| 1000000675 |
	| 1000000676 |
	| 1000000677 |
	| 1000000678 |
	| 1000000679 |
	| 1000000680 |
	| 1000000681 |
	| 1000000682 |
	| 1000000683 |
	| 1000000684 |
	| 1000000685 |
	| 1000000686 |
	| 1000000687 |
	| 1000000688 |
	| 1000000689 |
	| 1000000690 |
	| 1000000691 |
	| 1000000692 |
	| 1000000693 |
	| 1000000694 |
	| 1000000695 |
	| 1000000696 |
	| 1000000697 |
	| 1000000698 |
	| 1000000699 |
	| 1000000700 |
	| 1000000701 |
	| 1000000702 |
	| 1000000703 |
	| 1000000704 |
	| 1000000705 |
	| 1000000706 |
	| 1000000707 |
	| 1000000708 |
	| 1000000709 |
	| 1000000710 |
	| 1000000711 |
	| 1000000712 |
	| 1000000713 |
	| 1000000714 |
	| 1000000715 |
	| 1000000716 |
	| 1000000717 |
	| 1000000718 |
	| 1000000719 |
	| 1000000720 |
	| 1000000721 |
	| 1000000722 |
	| 1000000723 |
	| 1000000724 |
	| 1000000725 |
	| 1000000726 |
	| 1000000727 |
	| 1000000728 |
	| 1000000729 |
	| 1000000730 |
	| 1000000731 |
	| 1000000732 |
	| 1000000733 |
	| 1000000734 |
	| 1000000735 |
	| 1000000736 |
	| 1000000737 |
	| 1000000738 |
	| 1000000739 |
	| 1000000740 |
	| 1000000741 |
	| 1000000742 |
	| 1000000743 |
	| 1000000744 |
	| 1000000745 |
	| 1000000746 |
	| 1000000747 |
	| 1000000748 |
	| 1000000749 |
	| 1000000750 |
	| 1000000751 |
	| 1000000752 |
	| 1000000753 |
	| 1000000754 |
	| 1000000755 |
	| 1000000756 |
	| 1000000757 |
	| 1000000758 |
	| 1000000759 |
	| 1000000760 |
	| 1000000761 |
	| 1000000762 |
	| 1000000763 |
	| 1000000764 |
	| 1000000765 |
	| 1000000766 |
	| 1000000767 |
	| 1000000768 |
	| 1000000769 |
	| 1000000770 |
	| 1000000771 |
	| 1000000772 |
	| 1000000773 |
	| 1000000774 |
	| 1000000775 |
	| 1000000776 |
	| 1000000777 |
	| 1000000778 |
	| 1000000779 |
	| 1000000780 |
	| 1000000781 |
	| 1000000782 |
	| 1000000783 |
	| 1000000784 |
	| 1000000785 |
	| 1000000786 |
	| 1000000787 |
	| 1000000788 |
	| 1000000789 |
	| 1000000790 |
	| 1000000791 |
	| 1000000792 |
	| 1000000793 |
	| 1000000794 |
	| 1000000795 |
	| 1000000796 |
	| 1000000797 |
	| 1000000798 |
	| 1000000799 |
	| 1000000800 |
	| 1000000801 |
	| 1000000802 |
	| 1000000803 |
	| 1000000804 |
	| 1000000805 |
	| 1000000806 |
	| 1000000807 |
	| 1000000808 |
	| 1000000809 |
	| 1000000810 |
	| 1000000811 |
	| 1000000812 |
	| 1000000813 |
	| 1000000814 |
	| 1000000815 |
	| 1000000816 |
	| 1000000817 |
	| 1000000818 |
	| 1000000819 |
	| 1000000820 |
	| 1000000821 |
	| 1000000822 |
	| 1000000823 |
	| 1000000824 |
	| 1000000825 |
	| 1000000826 |
	| 1000000827 |
	| 1000000828 |
	| 1000000829 |
	| 1000000830 |
	| 1000000831 |
	| 1000000832 |
	| 1000000833 |
	| 1000000834 |
	| 1000000835 |
	| 1000000836 |
	| 1000000837 |
	| 1000000838 |
	| 1000000839 |
	| 1000000840 |
	| 1000000841 |
	| 1000000842 |
	| 1000000843 |
	| 1000000844 |
	| 1000000845 |
	| 1000000846 |
	| 1000000847 |
	| 1000000848 |
	| 1000000849 |
	| 1000000850 |
	| 1000000851 |
	| 1000000852 |
	| 1000000853 |
	| 1000000854 |
	| 1000000855 |
	| 1000000856 |
	| 1000000857 |
	| 1000000858 |
	| 1000000859 |
	| 1000000860 |
	| 1000000861 |
	| 1000000862 |
	| 1000000863 |
	| 1000000864 |
	| 1000000865 |
	| 1000000866 |
	| 1000000867 |
	| 1000000868 |
	| 1000000869 |
	| 1000000870 |
	| 1000000871 |
	| 1000000872 |
	| 1000000873 |
	| 1000000874 |
	| 1000000875 |
	| 1000000876 |
	| 1000000877 |
	| 1000000878 |
	| 1000000879 |
	| 1000000880 |
	| 1000000881 |
	| 1000000882 |
	| 1000000883 |
	| 1000000884 |
	| 1000000885 |
	| 1000000886 |
	| 1000000887 |
	| 1000000888 |
	| 1000000889 |
	| 1000000890 |
	| 1000000891 |
	| 1000000892 |
	| 1000000893 |
	| 1000000894 |
	| 1000000895 |
	| 1000000896 |
	| 1000000897 |
	| 1000000898 |
	| 1000000899 |
	| 1000000900 |
	| 1000000901 |
	| 1000000902 |
	| 1000000903 |
	| 1000000904 |
	| 1000000905 |
	| 1000000906 |
	| 1000000907 |
	| 1000000908 |
	| 1000000909 |
	| 1000000910 |
	| 1000000911 |
	| 1000000912 |
	| 1000000913 |
	| 1000000914 |
	| 1000000915 |
	| 1000000916 |
	| 1000000917 |
	| 1000000918 |
	| 1000000919 |
	| 1000000920 |
	| 1000000921 |
	| 1000000922 |
	| 1000000923 |
	| 1000000924 |
	| 1000000925 |
	| 1000000926 |
	| 1000000927 |
	| 1000000928 |
	| 1000000929 |
	| 1000000930 |
	| 1000000931 |
	| 1000000932 |
	| 1000000933 |
	| 1000000934 |
	| 1000000935 |
	| 1000000936 |
	| 1000000937 |
	| 1000000938 |
	| 1000000939 |
	| 1000000940 |
	| 1000000941 |
	| 1000000942 |
	| 1000000943 |
	| 1000000944 |
	| 1000000945 |
	| 1000000946 |
	| 1000000947 |
	| 1000000948 |
	| 1000000949 |
	| 1000000950 |
	| 1000000951 |
	| 1000000952 |
	| 1000000953 |
	| 1000000954 |
	| 1000000955 |
	| 1000000956 |
	| 1000000957 |
	| 1000000958 |
	| 1000000959 |
	| 1000000960 |
	| 1000000961 |
	| 1000000962 |
	| 1000000963 |
	| 1000000964 |
	| 1000000965 |
	| 1000000966 |
	| 1000000967 |
	| 1000000968 |
	| 1000000969 |
	| 1000000970 |
	| 1000000971 |
	| 1000000972 |
	| 1000000973 |
	| 1000000974 |
	| 1000000975 |
	| 1000000976 |
	| 1000000977 |
	| 1000000978 |
	| 1000000979 |
	| 1000000980 |
	| 1000000981 |
	| 1000000982 |
	| 1000000983 |
	| 1000000984 |
	| 1000000985 |
	| 1000000986 |
	| 1000000987 |
	| 1000000988 |
	| 1000000989 |
	| 1000000990 |
	| 1000000991 |
	| 1000000992 |
	| 1000000993 |
	| 1000000994 |
	| 1000000995 |
	| 1000000996 |
	| 1000000997 |
	| 1000000998 |
	| 1000000999 |
	| 1000001000 |
	| 1000001001 |
	| 1000001002 |
	| 1000001003 |
	| 1000001004 |
	| 1000001005 |
	| 1000001006 |
	| 1000001007 |
	| 1000001008 |
	| 1000001009 |
	| 1000001010 |
	| 1000001011 |
	| 1000001012 |
	| 1000001013 |
	| 1000001014 |
	| 1000001015 |
	| 1000001016 |
	| 1000001017 |
	| 1000001018 |
	| 1000001019 |
	| 1000001020 |
	| 1000001021 |
	| 1000001022 |
	| 1000001023 |
	| 1000001024 |
	| 1000001025 |
	| 1000001026 |
	| 1000001027 |
	| 1000001028 |
	| 1000001029 |
	| 1000001030 |
	| 1000001031 |
	| 1000001032 |
	| 1000001033 |
	| 1000001034 |
	| 1000001035 |
	| 1000001036 |
	| 1000001037 |
	| 1000001038 |
	| 1000001039 |
	| 1000001040 |
	| 1000001041 |
	| 1000001042 |
	| 1000001043 |
	| 1000001044 |
	| 1000001045 |
	| 1000001046 |
	| 1000001047 |
	| 1000001048 |
	| 1000001049 |
	| 1000001050 |
	| 1000001051 |
	| 1000001052 |
	| 1000001053 |
	| 1000001054 |
	| 1000001055 |
	| 1000001056 |
	| 1000001057 |
	| 1000001058 |
	| 1000001059 |
	| 1000001060 |
	| 1000001061 |
	| 1000001062 |
	| 1000001063 |
	| 1000001064 |
	| 1000001065 |
	| 1000001066 |
	| 1000001067 |
	| 1000001068 |
	| 1000001069 |
	| 1000001070 |
	| 1000001071 |
	| 1000001072 |
	| 1000001073 |
	| 1000001074 |
	| 1000001075 |
	| 1000001076 |
	| 1000001077 |
	| 1000001078 |
	| 1000001079 |
	| 1000001080 |
	| 1000001081 |
	| 1000001082 |
	| 1000001083 |
	| 1000001084 |
	| 1000001085 |
	| 1000001086 |
	| 1000001087 |
	| 1000001088 |
	| 1000001089 |
	| 1000001090 |
	| 1000001091 |
	| 1000001092 |
	| 1000001093 |
	| 1000001094 |
	| 1000001095 |
	| 1000001096 |
	| 1000001097 |
	| 1000001098 |
	| 1000001099 |
	| 1000001100 |
	| 1000001101 |
	| 1000001102 |
	| 1000001103 |
	| 1000001104 |
	| 1000001105 |
	| 1000001106 |
	| 1000001107 |
	| 1000001108 |
	| 1000001109 |
	| 1000001110 |
	| 1000001111 |
	| 1000001112 |
	| 1000001113 |
	| 1000001114 |
	| 1000001115 |
	| 1000001116 |
	| 1000001117 |
	| 1000001118 |
	| 1000001119 |
	| 1000001120 |
	| 1000001121 |
	| 1000001122 |
	| 1000001123 |
	| 1000001124 |
	| 1000001125 |
	| 1000001126 |
	| 1000001127 |
	| 1000001128 |
	| 1000001129 |
	| 1000001130 |
	| 1000001131 |
	| 1000001132 |
	| 1000001133 |
	| 1000001134 |
	| 1000001135 |
	| 1000001136 |
	| 1000001137 |
	| 1000001138 |
	| 1000001139 |
	| 1000001140 |
	| 1000001141 |
	| 1000001142 |
	| 1000001143 |
	| 1000001144 |
	| 1000001145 |
	| 1000001146 |
	| 1000001147 |
	| 1000001148 |
	| 1000001149 |
	| 1000001150 |
	| 1000001151 |
	| 1000001152 |
	| 1000001153 |
	| 1000001154 |
	| 1000001155 |
	| 1000001156 |
	| 1000001157 |
	| 1000001158 |
	| 1000001159 |
	| 1000001160 |
	| 1000001161 |
	| 1000001162 |
	| 1000001163 |
	| 1000001164 |
	| 1000001165 |
	| 1000001166 |
	| 1000001167 |
	| 1000001168 |
	| 1000001169 |
	| 1000001170 |
	| 1000001171 |
	| 1000001172 |
	| 1000001173 |
	| 1000001174 |
	| 1000001175 |
	| 1000001176 |
	| 1000001177 |
	| 1000001178 |
	| 1000001179 |
	| 1000001180 |
	| 1000001181 |
	| 1000001182 |
	| 1000001183 |
	| 1000001184 |
	| 1000001185 |
	| 1000001186 |
	| 1000001187 |
	| 1000001188 |
	| 1000001189 |
	| 1000001190 |
	| 1000001191 |
	| 1000001192 |
	| 1000001193 |
	| 1000001194 |
	| 1000001195 |
	| 1000001196 |
	| 1000001197 |
	| 1000001198 |
	| 1000001199 |
	| 1000001200 |
	| 1000001201 |
	| 1000001202 |
	| 1000001203 |
	| 1000001204 |
	| 1000001205 |
	| 1000001206 |
	| 1000001207 |
	| 1000001208 |
	| 1000001209 |
	| 1000001210 |
	| 1000001211 |
	| 1000001212 |
	| 1000001213 |
	| 1000001214 |
	| 1000001215 |
	| 1000001216 |
	| 1000001217 |
	| 1000001218 |
	| 1000001219 |
	| 1000001220 |
	| 1000001221 |
	| 1000001222 |
	| 1000001223 |
	| 1000001224 |
	| 1000001225 |
	| 1000001226 |
	| 1000001227 |
	| 1000001228 |
	| 1000001229 |
	| 1000001230 |
	| 1000001231 |
	| 1000001232 |
	| 1000001233 |
	| 1000001234 |
	| 1000001235 |
	| 1000001236 |
	| 1000001237 |
	| 1000001238 |
	| 1000001239 |
	| 1000001240 |
	| 1000001241 |
	| 1000001242 |
	| 1000001243 |
	| 1000001244 |
	| 1000001245 |
	| 1000001246 |
	| 1000001247 |
	| 1000001248 |
	| 1000001249 |
	| 1000001250 |
	| 1000001251 |
	| 1000001252 |
	| 1000001253 |
	| 1000001254 |
	| 1000001255 |
	| 1000001256 |
	| 1000001257 |
	| 1000001258 |
	| 1000001259 |
	| 1000001260 |
	| 1000001261 |
	| 1000001262 |
	| 1000001263 |
	| 1000001264 |
	| 1000001265 |
	| 1000001266 |
	| 1000001267 |
	| 1000001268 |
	| 1000001269 |
	| 1000001270 |
	| 1000001271 |
	| 1000001272 |
	| 1000001273 |
	| 1000001274 |
	| 1000001275 |
	| 1000001276 |
	| 1000001277 |
	| 1000001278 |
	| 1000001279 |
	| 1000001280 |
	| 1000001281 |
	| 1000001282 |
	| 1000001283 |
	| 1000001284 |
	| 1000001285 |
	| 1000001286 |
	| 1000001287 |
	| 1000001288 |
	| 1000001289 |
	| 1000001290 |
	| 1000001291 |
	| 1000001292 |
	| 1000001293 |
	| 1000001294 |
	| 1000001295 |
	| 1000001296 |
	| 1000001297 |
	| 1000001298 |
	| 1000001299 |
	| 1000001300 |
	| 1000001301 |
	| 1000001302 |
	| 1000001303 |
	| 1000001304 |
	| 1000001305 |
	| 1000001306 |
	| 1000001307 |
	| 1000001308 |
	| 1000001309 |
	| 1000001310 |
	| 1000001311 |
	| 1000001312 |
	| 1000001313 |
	| 1000001314 |
	| 1000001315 |
	| 1000001316 |
	| 1000001317 |
	| 1000001318 |
	| 1000001319 |
	| 1000001320 |
	| 1000001321 |
	| 1000001322 |
	| 1000001323 |
	| 1000001324 |
	| 1000001325 |
	| 1000001326 |
	| 1000001327 |
	| 1000001328 |
	| 1000001329 |
	| 1000001330 |
	| 1000001331 |
	| 1000001332 |
	| 1000001333 |
	| 1000001334 |
	| 1000001335 |
	| 1000001336 |
	| 1000001337 |
	| 1000001338 |
	| 1000001339 |
	| 1000001340 |
	| 1000001341 |
	| 1000001342 |
	| 1000001343 |
	| 1000001344 |
	| 1000001345 |
	| 1000001346 |
	| 1000001347 |
	| 1000001348 |
	| 1000001349 |
	| 1000001350 |
	| 1000001351 |
	| 1000001352 |
	| 1000001353 |
	| 1000001354 |
	| 1000001355 |
	| 1000001356 |
	| 1000001357 |
	| 1000001358 |
	| 1000001359 |
	| 1000001360 |
	| 1000001361 |
	| 1000001362 |
	| 1000001363 |
	| 1000001364 |
	| 1000001365 |
	| 1000001366 |
	| 1000001367 |
	| 1000001368 |
	| 1000001369 |
	| 1000001370 |
	| 1000001371 |
	| 1000001372 |
	| 1000001373 |
	| 1000001374 |
	| 1000001375 |
	| 1000001376 |
	| 1000001377 |
	| 1000001378 |
	| 1000001379 |
	| 1000001380 |
	| 1000001381 |
	| 1000001382 |
	| 1000001383 |
	| 1000001384 |
	| 1000001385 |
	| 1000001386 |
	| 1000001387 |
	| 1000001388 |
	| 1000001389 |
	| 1000001390 |
	| 1000001391 |
	| 1000001392 |
	| 1000001393 |
	| 1000001394 |
	| 1000001395 |
	| 1000001396 |
	| 1000001397 |
	| 1000001398 |
	| 1000001399 |
	| 1000001400 |
	| 1000001401 |
	| 1000001402 |
	| 1000001403 |
	| 1000001404 |
	| 1000001405 |
	| 1000001406 |
	| 1000001407 |
	| 1000001408 |
	| 1000001409 |
	| 1000001410 |
	| 1000001411 |
	| 1000001412 |
	| 1000001413 |
	| 1000001414 |
	| 1000001415 |
	| 1000001416 |
	| 1000001417 |
	| 1000001418 |
	| 1000001419 |
	| 1000001420 |
	| 1000001421 |
	| 1000001422 |
	| 1000001423 |
	| 1000001424 |
	| 1000001425 |
	| 1000001426 |
	| 1000001427 |
	| 1000001428 |
	| 1000001429 |
	| 1000001430 |
	| 1000001431 |
	| 1000001432 |
	| 1000001433 |
	| 1000001434 |
	| 1000001435 |
	| 1000001436 |
	| 1000001437 |
	| 1000001438 |
	| 1000001439 |
	| 1000001440 |
	| 1000001441 |
	| 1000001442 |
	| 1000001443 |
	| 1000001444 |
	| 1000001445 |
	| 1000001446 |
	| 1000001447 |
	| 1000001448 |
	| 1000001449 |
	| 1000001450 |
	| 1000001451 |
	| 1000001452 |
	| 1000001453 |
	| 1000001454 |
	| 1000001455 |
	| 1000001456 |
	| 1000001457 |
	| 1000001458 |
	| 1000001459 |
	| 1000001460 |
	| 1000001461 |
	| 1000001462 |
	| 1000001463 |
	| 1000001464 |
	| 1000001465 |
	| 1000001466 |
	| 1000001467 |
	| 1000001468 |
	| 1000001469 |
	| 1000001470 |
	| 1000001471 |
	| 1000001472 |
	| 1000001473 |
	| 1000001474 |
	| 1000001475 |
	| 1000001476 |
	| 1000001477 |
	| 1000001478 |
	| 1000001479 |
	| 1000001480 |
	| 1000001481 |
	| 1000001482 |
	| 1000001483 |
	| 1000001484 |
	| 1000001485 |
	| 1000001486 |
	| 1000001487 |
	| 1000001488 |
	| 1000001489 |
	| 1000001490 |
	| 1000001491 |
	| 1000001492 |
	| 1000001493 |
	| 1000001494 |
	| 1000001495 |
	| 1000001496 |
	| 1000001497 |
	| 1000001498 |
	| 1000001499 |
	| 1000001500 |
	| 1000001501 |
	| 1000001502 |
	| 1000001503 |
	| 1000001504 |
	| 1000001505 |
	| 1000001506 |
	| 1000001507 |
	| 1000001508 |
	| 1000001509 |
	| 1000001510 |
	| 1000001511 |
	| 1000001512 |
	| 1000001513 |
	| 1000001514 |
	| 1000001515 |
	| 1000001516 |
	| 1000001517 |
	| 1000001518 |
	| 1000001519 |
	| 1000001520 |
	| 1000001521 |
	| 1000001522 |
	| 1000001523 |
	| 1000001524 |
	| 1000001525 |
	| 1000001526 |
	| 1000001527 |
	| 1000001528 |
	| 1000001529 |
	| 1000001530 |
	| 1000001531 |
	| 1000001532 |
	| 1000001533 |
	| 1000001534 |
	| 1000001535 |
	| 1000001536 |
	| 1000001537 |
	| 1000001538 |
	| 1000001539 |
	| 1000001540 |
	| 1000001541 |
	| 1000001542 |
	| 1000001543 |
	| 1000001544 |
	| 1000001545 |
	| 1000001546 |
	| 1000001547 |
	| 1000001548 |
	| 1000001549 |
	| 1000001550 |
	| 1000001551 |
	| 1000001552 |
	| 1000001553 |
	| 1000001554 |
	| 1000001555 |
	| 1000001556 |
	| 1000001557 |
	| 1000001558 |
	| 1000001559 |
	| 1000001560 |
	| 1000001561 |
	| 1000001562 |
	| 1000001563 |
	| 1000001564 |
	| 1000001565 |
	| 1000001566 |
	| 1000001567 |
	| 1000001568 |
	| 1000001569 |
	| 1000001570 |
	| 1000001571 |
	| 1000001572 |
	| 1000001573 |
	| 1000001574 |
	| 1000001575 |
	| 1000001576 |
	| 1000001577 |
	| 1000001578 |
	| 1000001579 |
	| 1000001580 |
	| 1000001581 |
	| 1000001582 |
	| 1000001583 |
	| 1000001584 |
	| 1000001585 |
	| 1000001586 |
	| 1000001587 |
	| 1000001588 |
	| 1000001589 |
	| 1000001590 |
	| 1000001591 |
	| 1000001592 |
	| 1000001593 |
	| 1000001594 |
	| 1000001595 |
	| 1000001596 |
	| 1000001597 |
	| 1000001598 |
	| 1000001599 |
	| 1000001600 |
	| 1000001601 |
	| 1000001602 |
	| 1000001603 |
	| 1000001604 |
	| 1000001605 |
	| 1000001606 |
	| 1000001607 |
	| 1000001608 |
	| 1000001609 |
	| 1000001610 |
	| 1000001611 |
	| 1000001612 |
	| 1000001613 |
	| 1000001614 |
	| 1000001615 |
	| 1000001616 |
	| 1000001617 |
	| 1000001618 |
	| 1000001619 |
	| 1000001620 |
	| 1000001621 |
	| 1000001622 |
	| 1000001623 |
	| 1000001624 |
	| 1000001625 |
	| 1000001626 |
	| 1000001627 |
	| 1000001628 |
	| 1000001629 |
	| 1000001630 |
	| 1000001631 |
	| 1000001632 |
	| 1000001633 |
	| 1000001634 |
	| 1000001635 |
	| 1000001636 |
	| 1000001637 |
	| 1000001638 |
	| 1000001639 |
	| 1000001640 |
	| 1000001641 |
	| 1000001642 |
	| 1000001643 |
	| 1000001644 |
	| 1000001645 |
	| 1000001646 |
	| 1000001647 |
	| 1000001648 |
	| 1000001649 |
	| 1000001650 |
	| 1000001651 |
	| 1000001652 |
	| 1000001653 |
	| 1000001654 |
	| 1000001655 |
	| 1000001656 |
	| 1000001657 |
	| 1000001658 |
	| 1000001659 |
	| 1000001660 |
	| 1000001661 |
	| 1000001662 |
	| 1000001663 |
	| 1000001664 |
	| 1000001665 |
	| 1000001666 |
	| 1000001667 |
	| 1000001668 |
	| 1000001669 |
	| 1000001670 |
	| 1000001671 |
	| 1000001672 |
	| 1000001673 |
	| 1000001674 |
	| 1000001675 |
	| 1000001676 |
	| 1000001677 |
	| 1000001678 |
	| 1000001679 |
	| 1000001680 |
	| 1000001681 |
	| 1000001682 |
	| 1000001683 |
	| 1000001684 |
	| 1000001685 |
	| 1000001686 |
	| 1000001687 |
	| 1000001688 |
	| 1000001689 |
	| 1000001690 |
	| 1000001691 |
	| 1000001692 |
	| 1000001693 |
	| 1000001694 |
	| 1000001695 |
	| 1000001696 |
	| 1000001697 |
	| 1000001698 |
	| 1000001699 |
	| 1000001700 |
	| 1000001701 |
	| 1000001702 |
	| 1000001703 |
	| 1000001704 |
	| 1000001705 |
	| 1000001706 |
	| 1000001707 |
	| 1000001708 |
	| 1000001709 |
	| 1000001710 |
	| 1000001711 |
	| 1000001712 |
	| 1000001713 |
	| 1000001714 |
	| 1000001715 |
	| 1000001716 |
	| 1000001717 |
	| 1000001718 |
	| 1000001719 |
	| 1000001720 |
	| 1000001721 |
	| 1000001722 |
	| 1000001723 |
	| 1000001724 |
	| 1000001725 |
	| 1000001726 |
	| 1000001727 |
	| 1000001728 |
	| 1000001729 |
	| 1000001730 |
	| 1000001731 |
	| 1000001732 |
	| 1000001733 |
	| 1000001734 |
	| 1000001735 |
	| 1000001736 |
	| 1000001737 |
	| 1000001738 |
	| 1000001739 |
	| 1000001740 |
	| 1000001741 |
	| 1000001742 |
	| 1000001743 |
	| 1000001744 |
	| 1000001745 |
	| 1000001746 |
	| 1000001747 |
	| 1000001748 |
	| 1000001749 |
	| 1000001750 |
	| 1000001751 |
	| 1000001752 |
	| 1000001753 |
	| 1000001754 |
	| 1000001755 |
	| 1000001756 |
	| 1000001757 |
	| 1000001758 |
	| 1000001759 |
	| 1000001760 |
	| 1000001761 |
	| 1000001762 |
	| 1000001763 |
	| 1000001764 |
	| 1000001765 |
	| 1000001766 |
	| 1000001767 |
	| 1000001768 |
	| 1000001769 |
	| 1000001770 |
	| 1000001771 |
	| 1000001772 |
	| 1000001773 |
	| 1000001774 |
	| 1000001775 |
	| 1000001776 |
	| 1000001777 |
	| 1000001778 |
	| 1000001779 |
	| 1000001780 |
	| 1000001781 |
	| 1000001782 |
	| 1000001783 |
	| 1000001784 |
	| 1000001785 |
	| 1000001786 |
	| 1000001787 |
	| 1000001788 |
	| 1000001789 |
	| 1000001790 |
	| 1000001791 |
	| 1000001792 |
	| 1000001793 |
	| 1000001794 |
	| 1000001795 |
	| 1000001796 |
	| 1000001797 |
	| 1000001798 |
	| 1000001799 |
	| 1000001800 |
	| 1000001801 |
	| 1000001802 |
	| 1000001803 |
	| 1000001804 |
	| 1000001805 |
	| 1000001806 |
	| 1000001807 |
	| 1000001808 |
	| 1000001809 |
	| 1000001810 |
	| 1000001811 |
	| 1000001812 |
	| 1000001813 |
	| 1000001814 |
	| 1000001815 |
	| 1000001816 |
	| 1000001817 |
	| 1000001818 |
	| 1000001819 |
	| 1000001820 |
	| 1000001821 |
	| 1000001822 |
	| 1000001823 |
	| 1000001824 |
	| 1000001825 |
	| 1000001826 |
	| 1000001827 |
	| 1000001828 |
	| 1000001829 |
	| 1000001830 |
	| 1000001831 |
	| 1000001832 |
	| 1000001833 |
	| 1000001834 |
	| 1000001835 |
	| 1000001836 |
	| 1000001837 |
	| 1000001838 |
	| 1000001839 |
	| 1000001840 |
	| 1000001841 |
	| 1000001842 |
	| 1000001843 |
	| 1000001844 |
	| 1000001845 |
	| 1000001846 |
	| 1000001847 |
	| 1000001848 |
	| 1000001849 |
	| 1000001850 |
	| 1000001851 |
	| 1000001852 |
	| 1000001853 |
	| 1000001854 |
	| 1000001855 |
	| 1000001856 |
	| 1000001857 |
	| 1000001858 |
	| 1000001859 |
	| 1000001860 |
	| 1000001861 |
	| 1000001862 |
	| 1000001863 |
	| 1000001864 |
	| 1000001865 |
	| 1000001866 |
	| 1000001867 |
	| 1000001868 |
	| 1000001869 |
	| 1000001870 |
	| 1000001871 |
	| 1000001872 |
	| 1000001873 |
	| 1000001874 |
	| 1000001875 |
	| 1000001876 |
	| 1000001877 |
	| 1000001878 |
	| 1000001879 |
	| 1000001880 |
	| 1000001881 |
	| 1000001882 |
	| 1000001883 |
	| 1000001884 |
	| 1000001885 |
	| 1000001886 |
	| 1000001887 |
	| 1000001888 |
	| 1000001889 |
	| 1000001890 |
	| 1000001891 |
	| 1000001892 |
	| 1000001893 |
	| 1000001894 |
	| 1000001895 |
	| 1000001896 |
	| 1000001897 |
	| 1000001898 |
	| 1000001899 |
	| 1000001900 |
	| 1000001901 |
	| 1000001902 |
	| 1000001903 |
	| 1000001904 |
	| 1000001905 |
	| 1000001906 |
	| 1000001907 |
	| 1000001908 |
	| 1000001909 |
	| 1000001910 |
	| 1000001911 |
	| 1000001912 |
	| 1000001913 |
	| 1000001914 |
	| 1000001915 |
	| 1000001916 |
	| 1000001917 |
	| 1000001918 |
	| 1000001919 |
	| 1000001920 |
	| 1000001921 |
	| 1000001922 |
	| 1000001923 |
	| 1000001924 |
	| 1000001925 |
	| 1000001926 |
	| 1000001927 |
	| 1000001928 |
	| 1000001929 |
	| 1000001930 |
	| 1000001931 |
	| 1000001932 |
	| 1000001933 |
	| 1000001934 |
	| 1000001935 |
	| 1000001936 |
	| 1000001937 |
	| 1000001938 |
	| 1000001939 |
	| 1000001940 |
	| 1000001941 |
	| 1000001942 |
	| 1000001943 |
	| 1000001944 |
	| 1000001945 |
	| 1000001946 |
	| 1000001947 |
	| 1000001948 |
	| 1000001949 |
	| 1000001950 |
	| 1000001951 |
	| 1000001952 |
	| 1000001953 |
	| 1000001954 |
	| 1000001955 |
	| 1000001956 |
	| 1000001957 |
	| 1000001958 |
	| 1000001959 |
	| 1000001960 |
	| 1000001961 |
	| 1000001962 |
	| 1000001963 |
	| 1000001964 |
	| 1000001965 |
	| 1000001966 |
	| 1000001967 |
	| 1000001968 |
	| 1000001969 |
	| 1000001970 |
	| 1000001971 |
	| 1000001972 |
	| 1000001973 |
	| 1000001974 |
	| 1000001975 |
	| 1000001976 |
	| 1000001977 |
	| 1000001978 |
	| 1000001979 |
	| 1000001980 |
	| 1000001981 |
	| 1000001982 |
	| 1000001983 |
	| 1000001984 |
	| 1000001985 |
	| 1000001986 |
	| 1000001987 |
	| 1000001988 |
	| 1000001989 |
	| 1000001990 |
	| 1000001991 |
	| 1000001992 |
	| 1000001993 |
	| 1000001994 |
	| 1000001995 |
	| 1000001996 |
	| 1000001997 |
	| 1000001998 |
	| 1000001999 |
	| 1000002000 |
	| 1000002001 |
	| 1000002002 |
	| 1000002003 |
	| 1000002004 |
	| 1000002005 |
	| 1000002006 |
	| 1000002007 |
	| 1000002008 |
	| 1000002009 |
	| 1000002010 |
	| 1000002011 |
	| 1000002012 |
	| 1000002013 |
	| 1000002014 |
	| 1000002015 |
	| 1000002016 |
	| 1000002017 |
	| 1000002018 |
	| 1000002019 |
	| 1000002020 |
	| 1000002021 |
	| 1000002022 |
	| 1000002023 |
	| 1000002024 |
	| 1000002025 |
	| 1000002026 |
	| 1000002027 |
	| 1000002028 |
	| 1000002029 |
	| 1000002030 |
	| 1000002031 |
	| 1000002032 |
	| 1000002033 |
	| 1000002034 |
	| 1000002035 |
	| 1000002036 |
	| 1000002037 |
	| 1000002038 |
	| 1000002039 |
	| 1000002040 |
	| 1000002041 |
	| 1000002042 |
	| 1000002043 |
	| 1000002044 |
	| 1000002045 |
	| 1000002046 |
	| 1000002047 |
	| 1000002048 |
	| 1000002049 |
	| 1000002050 |
	| 1000002051 |
	| 1000002052 |
	| 1000002053 |
	| 1000002054 |
	| 1000002055 |
	| 1000002056 |
	| 1000002057 |
	| 1000002058 |
	| 1000002059 |
	| 1000002060 |
	| 1000002061 |
	| 1000002062 |
	| 1000002063 |
	| 1000002064 |
	| 1000002065 |
	| 1000002066 |
	| 1000002067 |
	| 1000002068 |
	| 1000002069 |
	| 1000002070 |
	| 1000002071 |
	| 1000002072 |
	| 1000002073 |
	| 1000002074 |
	| 1000002075 |
	| 1000002076 |
	| 1000002077 |
	| 1000002078 |
	| 1000002079 |
	| 1000002080 |
	| 1000002081 |
	| 1000002082 |
	| 1000002083 |
	| 1000002084 |
	| 1000002085 |
	| 1000002086 |
	| 1000002087 |
	| 1000002088 |
	| 1000002089 |
	| 1000002090 |
	| 1000002091 |
	| 1000002092 |
	| 1000002093 |
	| 1000002094 |
	| 1000002095 |
	| 1000002096 |
	| 1000002097 |
	| 1000002098 |
	| 1000002099 |
	| 1000002100 |
	| 1000002101 |
	| 1000002102 |
	| 1000002103 |
	| 1000002104 |
	| 1000002105 |
	| 1000002106 |
	| 1000002107 |
	| 1000002108 |
	| 1000002109 |
	| 1000002110 |
	| 1000002111 |
	| 1000002112 |
	| 1000002113 |
	| 1000002114 |
	| 1000002115 |
	| 1000002116 |
	| 1000002117 |
	| 1000002118 |
	| 1000002119 |
	| 1000002120 |
	| 1000002121 |
	| 1000002122 |
	| 1000002123 |
	| 1000002124 |
	| 1000002125 |
	| 1000002126 |
	| 1000002127 |
	| 1000002128 |
	| 1000002129 |
	| 1000002130 |
	| 1000002131 |
	| 1000002132 |
	| 1000002133 |
	| 1000002134 |
	| 1000002135 |
	| 1000002136 |
	| 1000002137 |
	| 1000002138 |
	| 1000002139 |
	| 1000002140 |
	| 1000002141 |
	| 1000002142 |
	| 1000002143 |
	| 1000002144 |
	| 1000002145 |
	| 1000002146 |
	| 1000002147 |
	| 1000002148 |
	| 1000002149 |
	| 1000002150 |
	| 1000002151 |
	| 1000002152 |
	| 1000002153 |
	| 1000002154 |
	| 1000002155 |
	| 1000002156 |
	| 1000002157 |
	| 1000002158 |
	| 1000002159 |
	| 1000002160 |
	| 1000002161 |
	| 1000002162 |
	| 1000002163 |
	| 1000002164 |
	| 1000002165 |
	| 1000002166 |
	| 1000002167 |
	| 1000002168 |
	| 1000002169 |
	| 1000002170 |
	| 1000002171 |
	| 1000002172 |
	| 1000002173 |
	| 1000002174 |
	| 1000002175 |
	| 1000002176 |
	| 1000002177 |
	| 1000002178 |
	| 1000002179 |
	| 1000002180 |
	| 1000002181 |
	| 1000002182 |
	| 1000002183 |
	| 1000002184 |
	| 1000002185 |
	| 1000002186 |
	| 1000002187 |
	| 1000002188 |
	| 1000002189 |
	| 1000002190 |
	| 1000002191 |
	| 1000002192 |
	| 1000002193 |
	| 1000002194 |
	| 1000002195 |
	| 1000002196 |
	| 1000002197 |
	| 1000002198 |
	| 1000002199 |
	| 1000002200 |
	| 1000002201 |
	| 1000002202 |
	| 1000002203 |
	| 1000002204 |
	| 1000002205 |
	| 1000002206 |
	| 1000002207 |
	| 1000002208 |
	| 1000002209 |
	| 1000002210 |
	| 1000002211 |
	| 1000002212 |
	| 1000002213 |
	| 1000002214 |
	| 1000002215 |
	| 1000002216 |
	| 1000002217 |
	| 1000002218 |
	| 1000002219 |
	| 1000002220 |
	| 1000002221 |
	| 1000002222 |
	| 1000002223 |
	| 1000002224 |
	| 1000002225 |
	| 1000002226 |
	| 1000002227 |
	| 1000002228 |
	| 1000002229 |
	| 1000002230 |
	| 1000002231 |
	| 1000002232 |
	| 1000002233 |
	| 1000002234 |
	| 1000002235 |
	| 1000002236 |
	| 1000002237 |
	| 1000002238 |
	| 1000002239 |
	| 1000002240 |
	| 1000002241 |
	| 1000002242 |
	| 1000002243 |
	| 1000002244 |
	| 1000002245 |
	| 1000002246 |
	| 1000002247 |
	| 1000002248 |
	| 1000002249 |
	| 1000002250 |
	| 1000002251 |
	| 1000002252 |
	| 1000002253 |
	| 1000002254 |
	| 1000002255 |
	| 1000002256 |
	| 1000002257 |
	| 1000002258 |
	| 1000002259 |
	| 1000002260 |
	| 1000002261 |
	| 1000002262 |
	| 1000002263 |
	| 1000002264 |
	| 1000002265 |
	| 1000002266 |
	| 1000002267 |
	| 1000002268 |
	| 1000002269 |
	| 1000002270 |
	| 1000002271 |
	| 1000002272 |
	| 1000002273 |
	| 1000002274 |
	| 1000002275 |
	| 1000002276 |
	| 1000002277 |
	| 1000002278 |
	| 1000002279 |
	| 1000002280 |
	| 1000002281 |
	| 1000002282 |
	| 1000002283 |
	| 1000002284 |
	| 1000002285 |
	| 1000002286 |
	| 1000002287 |
	| 1000002288 |
	| 1000002289 |
	| 1000002290 |
	| 1000002291 |
	| 1000002292 |
	| 1000002293 |
	| 1000002294 |
	| 1000002295 |
	| 1000002296 |
	| 1000002297 |
	| 1000002298 |
	| 1000002299 |
	| 1000002300 |
	| 1000002301 |
	| 1000002302 |
	| 1000002303 |
	| 1000002304 |
	| 1000002305 |
	| 1000002306 |
	| 1000002307 |
	| 1000002308 |
	| 1000002309 |
	| 1000002310 |
	| 1000002311 |
	| 1000002312 |
	| 1000002313 |
	| 1000002314 |
	| 1000002315 |
	| 1000002316 |
	| 1000002317 |
	| 1000002318 |
	| 1000002319 |
	| 1000002320 |
	| 1000002321 |
	| 1000002322 |
	| 1000002323 |
	| 1000002324 |
	| 1000002325 |
	| 1000002326 |
	| 1000002327 |
	| 1000002328 |
	| 1000002329 |
	| 1000002330 |
	| 1000002331 |
	| 1000002332 |
	| 1000002333 |
	| 1000002334 |
	| 1000002335 |
	| 1000002336 |
	| 1000002337 |
	| 1000002338 |
	| 1000002339 |
	| 1000002340 |
	| 1000002341 |
	| 1000002342 |
	| 1000002343 |
	| 1000002344 |
	| 1000002345 |
	| 1000002346 |
	| 1000002347 |
	| 1000002348 |
	| 1000002349 |
	| 1000002350 |
	| 1000002351 |
	| 1000002352 |
	| 1000002353 |
	| 1000002354 |
	| 1000002355 |
	| 1000002356 |
	| 1000002357 |
	| 1000002358 |
	| 1000002359 |
	| 1000002360 |
	| 1000002361 |
	| 1000002362 |
	| 1000002363 |
	| 1000002364 |
	| 1000002365 |
	| 1000002366 |
	| 1000002367 |
	| 1000002368 |
	| 1000002369 |
	| 1000002370 |
	| 1000002371 |
	| 1000002372 |
	| 1000002373 |
	| 1000002374 |
	| 1000002375 |
	| 1000002376 |
	| 1000002377 |
	| 1000002378 |
	| 1000002379 |
	| 1000002380 |
	| 1000002381 |
	| 1000002382 |
	| 1000002383 |
	| 1000002384 |
	| 1000002385 |
	| 1000002386 |
	| 1000002387 |
	| 1000002388 |
	| 1000002389 |
	| 1000002390 |
	| 1000002391 |
	| 1000002392 |
	| 1000002393 |
	| 1000002394 |
	| 1000002395 |
	| 1000002396 |
	| 1000002397 |
	| 1000002398 |
	| 1000002399 |
	| 1000002400 |
	| 1000002401 |
	| 1000002402 |
	| 1000002403 |
	| 1000002404 |
	| 1000002405 |
	| 1000002406 |
	| 1000002407 |
	| 1000002408 |
	| 1000002409 |
	| 1000002410 |
	| 1000002411 |
	| 1000002412 |
	| 1000002413 |
	| 1000002414 |
	| 1000002415 |
	| 1000002416 |
	| 1000002417 |
	| 1000002418 |
	| 1000002419 |
	| 1000002420 |
	| 1000002421 |
	| 1000002422 |
	| 1000002423 |
	| 1000002424 |
	| 1000002425 |
	| 1000002426 |
	| 1000002427 |
	| 1000002428 |
	| 1000002429 |
	| 1000002430 |
	| 1000002431 |
	| 1000002432 |
	| 1000002433 |
	| 1000002434 |
	| 1000002435 |
	| 1000002436 |
	| 1000002437 |
	| 1000002438 |
	| 1000002439 |
	| 1000002440 |
	| 1000002441 |
	| 1000002442 |
	| 1000002443 |
	| 1000002444 |
	| 1000002445 |
	| 1000002446 |
	| 1000002447 |
	| 1000002448 |
	| 1000002449 |
	| 1000002450 |
	| 1000002451 |
	| 1000002452 |
	| 1000002453 |
	| 1000002454 |
	| 1000002455 |
	| 1000002456 |
	| 1000002457 |
	| 1000002458 |
	| 1000002459 |
	| 1000002460 |
	| 1000002461 |
	| 1000002462 |
	| 1000002463 |
	| 1000002464 |
	| 1000002465 |
	| 1000002466 |
	| 1000002467 |
	| 1000002468 |
	| 1000002469 |
	| 1000002470 |
	| 1000002471 |
	| 1000002472 |
	| 1000002473 |
	| 1000002474 |
	| 1000002475 |
	| 1000002476 |
	| 1000002477 |
	| 1000002478 |
	| 1000002479 |
	| 1000002480 |
	| 1000002481 |
	| 1000002482 |
	| 1000002483 |
	| 1000002484 |
	| 1000002485 |
	| 1000002486 |
	| 1000002487 |
	| 1000002488 |
	| 1000002489 |
	| 1000002490 |
	| 1000002491 |
	| 1000002492 |
	| 1000002493 |
	| 1000002494 |
	| 1000002495 |
	| 1000002496 |
	| 1000002497 |
	| 1000002498 |
	| 1000002499 |
	| 1000002500 |
	| 1000002501 |
	| 1000002502 |
	| 1000002503 |
	| 1000002504 |
	| 1000002505 |
	| 1000002506 |
	| 1000002507 |
	| 1000002508 |
	| 1000002509 |
	| 1000002510 |
	| 1000002511 |
	| 1000002512 |
	| 1000002513 |
	| 1000002514 |
	| 1000002515 |
	| 1000002516 |
	| 1000002517 |
	| 1000002518 |
	| 1000002519 |
	| 1000002520 |
	| 1000002521 |
	| 1000002522 |
	| 1000002523 |
	| 1000002524 |
	| 1000002525 |
	| 1000002526 |
	| 1000002527 |
	| 1000002528 |
	| 1000002529 |
	| 1000002530 |
	| 1000002531 |
	| 1000002532 |
	| 1000002533 |
	| 1000002534 |
	| 1000002535 |
	| 1000002536 |
	| 1000002537 |
	| 1000002538 |
	| 1000002539 |
	| 1000002540 |
	| 1000002541 |
	| 1000002542 |
	| 1000002543 |
	| 1000002544 |
	| 1000002545 |
	| 1000002546 |
	| 1000002547 |
	| 1000002548 |
	| 1000002549 |
	| 1000002550 |
	| 1000002551 |
	| 1000002552 |
	| 1000002553 |
	| 1000002554 |
	| 1000002555 |
	| 1000002556 |
	| 1000002557 |
	| 1000002558 |
	| 1000002559 |
	| 1000002560 |
	| 1000002561 |
	| 1000002562 |
	| 1000002563 |
	| 1000002564 |
	| 1000002565 |
	| 1000002566 |
	| 1000002567 |
	| 1000002568 |
	| 1000002569 |
	| 1000002570 |
	| 1000002571 |
	| 1000002572 |
	| 1000002573 |
	| 1000002574 |
	| 1000002575 |
	| 1000002576 |
	| 1000002577 |
	| 1000002578 |
	| 1000002579 |
	| 1000002580 |
	| 1000002581 |
	| 1000002582 |
	| 1000002583 |
	| 1000002584 |
	| 1000002585 |
	| 1000002586 |
	| 1000002587 |
	| 1000002588 |
	| 1000002589 |
	| 1000002590 |
	| 1000002591 |
	| 1000002592 |
	| 1000002593 |
	| 1000002594 |
	| 1000002595 |
	| 1000002596 |
	| 1000002597 |
	| 1000002598 |
	| 1000002599 |
	| 1000002600 |
	| 1000002601 |
	| 1000002602 |
	| 1000002603 |
	| 1000002604 |
	| 1000002605 |
	| 1000002606 |
	| 1000002607 |
	| 1000002608 |
	| 1000002609 |
	| 1000002610 |
	| 1000002611 |
	| 1000002612 |
	| 1000002613 |
	| 1000002614 |
	| 1000002615 |
	| 1000002616 |
	| 1000002617 |
	| 1000002618 |
	| 1000002619 |
	| 1000002620 |
	| 1000002621 |
	| 1000002622 |
	| 1000002623 |
	| 1000002624 |
	| 1000002625 |
	| 1000002626 |
	| 1000002627 |
	| 1000002628 |
	| 1000002629 |
	| 1000002630 |
	| 1000002631 |
	| 1000002632 |
	| 1000002633 |
	| 1000002634 |
	| 1000002635 |
	| 1000002636 |
	| 1000002637 |
	| 1000002638 |
	| 1000002639 |
	| 1000002640 |
	| 1000002641 |
	| 1000002642 |
	| 1000002643 |
	| 1000002644 |
	| 1000002645 |
	| 1000002646 |
	| 1000002647 |
	| 1000002648 |
	| 1000002649 |
	| 1000002650 |
	| 1000002651 |
	| 1000002652 |
	| 1000002653 |
	| 1000002654 |
	| 1000002655 |
	| 1000002656 |
	| 1000002657 |
	| 1000002658 |
	| 1000002659 |
	| 1000002660 |
	| 1000002661 |
	| 1000002662 |
	| 1000002663 |
	| 1000002664 |
	| 1000002665 |
	| 1000002666 |
	| 1000002667 |
	| 1000002668 |
	| 1000002669 |
	| 1000002670 |
	| 1000002671 |
	| 1000002672 |
	| 1000002673 |
	| 1000002674 |
	| 1000002675 |
	| 1000002676 |
	| 1000002677 |
	| 1000002678 |
	| 1000002679 |
	| 1000002680 |
	| 1000002681 |
	| 1000002682 |
	| 1000002683 |
	| 1000002684 |
	| 1000002685 |
	| 1000002686 |
	| 1000002687 |
	| 1000002688 |
	| 1000002689 |
	| 1000002690 |
	| 1000002691 |
	| 1000002692 |
	| 1000002693 |
	| 1000002694 |
	| 1000002695 |
	| 1000002696 |
	| 1000002697 |
	| 1000002698 |
	| 1000002699 |
	| 1000002700 |
	| 1000002701 |
	| 1000002702 |
	| 1000002703 |
	| 1000002704 |
	| 1000002705 |
	| 1000002706 |
	| 1000002707 |
	| 1000002708 |
	| 1000002709 |
	| 1000002710 |
	| 1000002711 |
	| 1000002712 |
	| 1000002713 |
	| 1000002714 |
	| 1000002715 |
	| 1000002716 |
	| 1000002717 |
	| 1000002718 |
	| 1000002719 |
	| 1000002720 |
	| 1000002721 |
	| 1000002722 |
	| 1000002723 |
	| 1000002724 |
	| 1000002725 |
	| 1000002726 |
	| 1000002727 |
	| 1000002728 |
	| 1000002729 |
	| 1000002730 |
	| 1000002731 |
	| 1000002732 |
	| 1000002733 |
	| 1000002734 |
	| 1000002735 |
	| 1000002736 |
	| 1000002737 |
	| 1000002738 |
	| 1000002739 |
	| 1000002740 |
	| 1000002741 |
	| 1000002742 |
	| 1000002743 |
	| 1000002744 |
	| 1000002745 |
	| 1000002746 |
	| 1000002747 |
	| 1000002748 |
	| 1000002749 |
	| 1000002750 |
	| 1000002751 |
	| 1000002752 |
	| 1000002753 |
	| 1000002754 |
	| 1000002755 |
	| 1000002756 |
	| 1000002757 |
	| 1000002758 |
	| 1000002759 |
	| 1000002760 |
	| 1000002761 |
	| 1000002762 |
	| 1000002763 |
	| 1000002764 |
	| 1000002765 |
	| 1000002766 |
	| 1000002767 |
	| 1000002768 |
	| 1000002769 |
	| 1000002770 |
	| 1000002771 |
	| 1000002772 |
	| 1000002773 |
	| 1000002774 |
	| 1000002775 |
	| 1000002776 |
	| 1000002777 |
	| 1000002778 |
	| 1000002779 |
	| 1000002780 |
	| 1000002781 |
	| 1000002782 |
	| 1000002783 |
	| 1000002784 |
	| 1000002785 |
	| 1000002786 |
	| 1000002787 |
	| 1000002788 |
	| 1000002789 |
	| 1000002790 |
	| 1000002791 |
	| 1000002792 |
	| 1000002793 |
	| 1000002794 |
	| 1000002795 |
	| 1000002796 |
	| 1000002797 |
	| 1000002798 |
	| 1000002799 |
	| 1000002800 |
	| 1000002801 |
	| 1000002802 |
	| 1000002803 |
	| 1000002804 |
	| 1000002805 |
	| 1000002806 |
	| 1000002807 |
	| 1000002808 |
	| 1000002809 |
	| 1000002810 |
	| 1000002811 |
	| 1000002812 |
	| 1000002813 |
	| 1000002814 |
	| 1000002815 |
	| 1000002816 |
	| 1000002817 |
	| 1000002818 |
	| 1000002819 |
	| 1000002820 |
	| 1000002821 |
	| 1000002822 |
	| 1000002823 |
	| 1000002824 |
	| 1000002825 |
	| 1000002826 |
	| 1000002827 |
	| 1000002828 |
	| 1000002829 |
	| 1000002830 |
	| 1000002831 |
	| 1000002832 |
	| 1000002833 |
	| 1000002834 |
	| 1000002835 |
	| 1000002836 |
	| 1000002837 |
	| 1000002838 |
	| 1000002839 |
	| 1000002840 |
	| 1000002841 |
	| 1000002842 |
	| 1000002843 |
	| 1000002844 |
	| 1000002845 |
	| 1000002846 |
	| 1000002847 |
	| 1000002848 |
	| 1000002849 |
	| 1000002850 |
	| 1000002851 |
	| 1000002852 |
	| 1000002853 |
	| 1000002854 |
	| 1000002855 |
	| 1000002856 |
	| 1000002857 |
	| 1000002858 |
	| 1000002859 |
	| 1000002860 |
	| 1000002861 |
	| 1000002862 |
	| 1000002863 |
	| 1000002864 |
	| 1000002865 |
	| 1000002866 |
	| 1000002867 |
	| 1000002868 |
	| 1000002869 |
	| 1000002870 |
	| 1000002871 |
	| 1000002872 |
	| 1000002873 |
	| 1000002874 |
	| 1000002875 |
	| 1000002876 |
	| 1000002877 |
	| 1000002878 |
	| 1000002879 |
	| 1000002880 |
	| 1000002881 |
	| 1000002882 |
	| 1000002883 |
	| 1000002884 |
	| 1000002885 |
	| 1000002886 |
	| 1000002887 |
	| 1000002888 |
	| 1000002889 |
	| 1000002890 |
	| 1000002891 |
	| 1000002892 |
	| 1000002893 |
	| 1000002894 |
	| 1000002895 |
	| 1000002896 |
	| 1000002897 |
	| 1000002898 |
	| 1000002899 |
	| 1000002900 |
	| 1000002901 |
	| 1000002902 |
	| 1000002903 |
	| 1000002904 |
	| 1000002905 |
	| 1000002906 |
	| 1000002907 |
	| 1000002908 |
	| 1000002909 |
	| 1000002910 |
	| 1000002911 |
	| 1000002912 |
	| 1000002913 |
	| 1000002914 |
	| 1000002915 |
	| 1000002916 |
	| 1000002917 |
	| 1000002918 |
	| 1000002919 |
	| 1000002920 |
	| 1000002921 |
	| 1000002922 |
	| 1000002923 |
	| 1000002924 |
	| 1000002925 |
	| 1000002926 |
	| 1000002927 |
	| 1000002928 |
	| 1000002929 |
	| 1000002930 |
	| 1000002931 |
	| 1000002932 |
	| 1000002933 |
	| 1000002934 |
	| 1000002935 |
	| 1000002936 |
	| 1000002937 |
	| 1000002938 |
	| 1000002939 |
	| 1000002940 |
	| 1000002941 |
	| 1000002942 |
	| 1000002943 |
	| 1000002944 |
	| 1000002945 |
	| 1000002946 |
	| 1000002947 |
	| 1000002948 |
	| 1000002949 |
	| 1000002950 |
	| 1000002951 |
	| 1000002952 |
	| 1000002953 |
	| 1000002954 |
	| 1000002955 |
	| 1000002956 |
	| 1000002957 |
	| 1000002958 |
	| 1000002959 |
	| 1000002960 |
	| 1000002961 |
	| 1000002962 |
	| 1000002963 |
	| 1000002964 |
	| 1000002965 |
	| 1000002966 |
	| 1000002967 |
	| 1000002968 |
	| 1000002969 |
	| 1000002970 |
	| 1000002971 |
	| 1000002972 |
	| 1000002973 |
	| 1000002974 |
	| 1000002975 |
	| 1000002976 |
	| 1000002977 |
	| 1000002978 |
	| 1000002979 |
	| 1000002980 |
	| 1000002981 |
	| 1000002982 |
	| 1000002983 |
	| 1000002984 |
	| 1000002985 |
	| 1000002986 |
	| 1000002987 |
	| 1000002988 |
	| 1000002989 |
	| 1000002990 |
	| 1000002991 |
	| 1000002992 |
	| 1000002993 |
	| 1000002994 |
	| 1000002995 |
	| 1000002996 |
	| 1000002997 |
	| 1000002998 |
	| 1000002999 |
	| 1000003000 |
	| 1000003001 |
	| 1000003002 |
	| 1000003003 |
	| 1000003004 |
	| 1000003005 |
	| 1000003006 |
	| 1000003007 |
	| 1000003008 |
	| 1000003009 |
	| 1000003010 |
	| 1000003011 |
	| 1000003012 |
	| 1000003013 |
	| 1000003014 |
	| 1000003015 |
	| 1000003016 |
	| 1000003017 |
	| 1000003018 |
	| 1000003019 |
	| 1000003020 |
	| 1000003021 |
	| 1000003022 |
	| 1000003023 |
	| 1000003024 |
	| 1000003025 |
	| 1000003026 |
	| 1000003027 |
	| 1000003028 |
	| 1000003029 |
	| 1000003030 |
	| 1000003031 |
	| 1000003032 |
	| 1000003033 |
	| 1000003034 |
	| 1000003035 |
	| 1000003036 |
	| 1000003037 |
	| 1000003038 |
	| 1000003039 |
	| 1000003040 |
	| 1000003041 |
	| 1000003042 |
	| 1000003043 |
	| 1000003044 |
	| 1000003045 |
	| 1000003046 |
	| 1000003047 |
	| 1000003048 |
	| 1000003049 |
	| 1000003050 |
	| 1000003051 |
	| 1000003052 |
	| 1000003053 |
	| 1000003054 |
	| 1000003055 |
	| 1000003056 |
	| 1000003057 |
	| 1000003058 |
	| 1000003059 |
	| 1000003060 |
	| 1000003061 |
	| 1000003062 |
	| 1000003063 |
	| 1000003064 |
	| 1000003065 |
	| 1000003066 |
	| 1000003067 |
	| 1000003068 |
	| 1000003069 |
	| 1000003070 |
	| 1000003071 |
	| 1000003072 |
	| 1000003073 |
	| 1000003074 |
	| 1000003075 |
	| 1000003076 |
	| 1000003077 |
	| 1000003078 |
	| 1000003079 |
	| 1000003080 |
	| 1000003081 |
	| 1000003082 |
	| 1000003083 |
	| 1000003084 |
	| 1000003085 |
	| 1000003086 |
	| 1000003087 |
	| 1000003088 |
	| 1000003089 |
	| 1000003090 |
	| 1000003091 |
	| 1000003092 |
	| 1000003093 |
	| 1000003094 |
	| 1000003095 |
	| 1000003096 |
	| 1000003097 |
	| 1000003098 |
	| 1000003099 |
	| 1000003100 |
	| 1000003101 |
	| 1000003102 |
	| 1000003103 |
	| 1000003104 |
	| 1000003105 |
	| 1000003106 |
	| 1000003107 |
	| 1000003108 |
	| 1000003109 |
	| 1000003110 |
	| 1000003111 |
	| 1000003112 |
	| 1000003113 |
	| 1000003114 |
	| 1000003115 |
	| 1000003116 |
	| 1000003117 |
	| 1000003118 |
	| 1000003119 |
	| 1000003120 |
	| 1000003121 |
	| 1000003122 |
	| 1000003123 |
	| 1000003124 |
	| 1000003125 |
	| 1000003126 |
	| 1000003127 |
	| 1000003128 |
	| 1000003129 |
	| 1000003130 |
	| 1000003131 |
	| 1000003132 |
	| 1000003133 |
	| 1000003134 |
	| 1000003135 |
	| 1000003136 |
	| 1000003137 |
	| 1000003138 |
	| 1000003139 |
	| 1000003140 |
	| 1000003141 |
	| 1000003142 |
	| 1000003143 |
	| 1000003144 |
	| 1000003145 |
	| 1000003146 |
	| 1000003147 |
	| 1000003148 |
	| 1000003149 |
	| 1000003150 |
	| 1000003151 |
	| 1000003152 |
	| 1000003153 |
	| 1000003154 |
	| 1000003155 |
	| 1000003156 |
	| 1000003157 |
	| 1000003158 |
	| 1000003159 |
	| 1000003160 |
	| 1000003161 |
	| 1000003162 |
	| 1000003163 |
	| 1000003164 |
	| 1000003165 |
	| 1000003166 |
	| 1000003167 |
	| 1000003168 |
	| 1000003169 |
	| 1000003170 |
	| 1000003171 |
	| 1000003172 |
	| 1000003173 |
	| 1000003174 |
	| 1000003175 |
	| 1000003176 |
	| 1000003177 |
	| 1000003178 |
	| 1000003179 |
	| 1000003180 |
	| 1000003181 |
	| 1000003182 |
	| 1000003183 |
	| 1000003184 |
	| 1000003185 |
	| 1000003186 |
	| 1000003187 |
	| 1000003188 |
	| 1000003189 |
	| 1000003190 |
	| 1000003191 |
	| 1000003192 |
	| 1000003193 |
	| 1000003194 |
	| 1000003195 |
	| 1000003196 |
	| 1000003197 |
	| 1000003198 |
	| 1000003199 |
	| 1000003200 |
	| 1000003201 |
	| 1000003202 |
	| 1000003203 |
	| 1000003204 |
	| 1000003205 |
	| 1000003206 |
	| 1000003207 |
	| 1000003208 |
	| 1000003209 |
	| 1000003210 |
	| 1000003211 |
	| 1000003212 |
	| 1000003213 |
	| 1000003214 |
	| 1000003215 |
	| 1000003216 |
	| 1000003217 |
	| 1000003218 |
	| 1000003219 |
	| 1000003220 |
	| 1000003221 |
	| 1000003222 |
	| 1000003223 |
	| 1000003224 |
	| 1000003225 |
	| 1000003226 |
	| 1000003227 |
	| 1000003228 |
	| 1000003229 |
	| 1000003230 |
	| 1000003231 |
	| 1000003232 |
	| 1000003233 |
	| 1000003234 |
	| 1000003235 |
	| 1000003236 |
	| 1000003237 |
	| 1000003238 |
	| 1000003239 |
	| 1000003240 |
	| 1000003241 |
	| 1000003242 |
	| 1000003243 |
	| 1000003244 |
	| 1000003245 |
	| 1000003246 |
	| 1000003247 |
	| 1000003248 |
	| 1000003249 |
	| 1000003250 |
	| 1000003251 |
	| 1000003252 |
	| 1000003253 |
	| 1000003254 |
	| 1000003255 |
	| 1000003256 |
	| 1000003257 |
	| 1000003258 |
	| 1000003259 |
	| 1000003260 |
	| 1000003261 |
	| 1000003262 |
	| 1000003263 |
	| 1000003264 |
	| 1000003265 |
	| 1000003266 |
	| 1000003267 |
	| 1000003268 |
	| 1000003269 |
	| 1000003270 |
	| 1000003271 |
	| 1000003272 |
	| 1000003273 |
	| 1000003274 |
	| 1000003275 |
	| 1000003276 |
	| 1000003277 |
	| 1000003278 |
	| 1000003279 |
	| 1000003280 |
	| 1000003281 |
	| 1000003282 |
	| 1000003283 |
	| 1000003284 |
	| 1000003285 |
	| 1000003286 |
	| 1000003287 |
	| 1000003288 |
	| 1000003289 |
	| 1000003290 |
	| 1000003291 |
	| 1000003292 |
	| 1000003293 |
	| 1000003294 |
	| 1000003295 |
	| 1000003296 |
	| 1000003297 |
	| 1000003298 |
	| 1000003299 |
	| 1000003300 |
	| 1000003301 |
	| 1000003302 |
	| 1000003303 |
	| 1000003304 |
	| 1000003305 |
	| 1000003306 |
	| 1000003307 |
	| 1000003308 |
	| 1000003309 |
	| 1000003310 |
	| 1000003311 |
	| 1000003312 |
	| 1000003313 |
	| 1000003314 |
	| 1000003315 |
	| 1000003316 |
	| 1000003317 |
	| 1000003318 |
	| 1000003319 |
	| 1000003320 |
	| 1000003321 |
	| 1000003322 |
	| 1000003323 |
	| 1000003324 |
	| 1000003325 |
	| 1000003326 |
	| 1000003327 |
	| 1000003328 |
	| 1000003329 |
	| 1000003330 |
	| 1000003331 |
	| 1000003332 |
	| 1000003333 |
	| 1000003334 |
	| 1000003335 |
	| 1000003336 |
	| 1000003337 |
	| 1000003338 |
	| 1000003339 |
	| 1000003340 |
	| 1000003341 |
	| 1000003342 |
	| 1000003343 |
	| 1000003344 |
	| 1000003345 |
	| 1000003346 |
	| 1000003347 |
	| 1000003348 |
	| 1000003349 |
	| 1000003350 |
	| 1000003351 |
	| 1000003352 |
	| 1000003353 |
	| 1000003354 |
	| 1000003355 |
	| 1000003356 |
	| 1000003357 |
	| 1000003358 |
	| 1000003359 |
	| 1000003360 |
	| 1000003361 |
	| 1000003362 |
	| 1000003363 |
	| 1000003364 |
	| 1000003365 |
	| 1000003366 |
	| 1000003367 |
	| 1000003368 |
	| 1000003369 |
	| 1000003370 |
	| 1000003371 |
	| 1000003372 |
	| 1000003373 |
	| 1000003374 |
	| 1000003375 |
	| 1000003376 |
	| 1000003377 |
	| 1000003378 |
	| 1000003379 |
	| 1000003380 |
	| 1000003381 |
	| 1000003382 |
	| 1000003383 |
	| 1000003384 |
	| 1000003385 |
	| 1000003386 |
	| 1000003387 |
	| 1000003388 |
	| 1000003389 |
	| 1000003390 |
	| 1000003391 |
	| 1000003392 |
	| 1000003393 |
	| 1000003394 |
	| 1000003395 |
	| 1000003396 |
	| 1000003397 |
	| 1000003398 |
	| 1000003399 |
	| 1000003400 |
	| 1000003401 |
	| 1000003402 |
	| 1000003403 |
	| 1000003404 |
	| 1000003405 |
	| 1000003406 |
	| 1000003407 |
	| 1000003408 |
	| 1000003409 |
	| 1000003410 |
	| 1000003411 |
	| 1000003412 |
	| 1000003413 |
	| 1000003414 |
	| 1000003415 |
	| 1000003416 |
	| 1000003417 |
	| 1000003418 |
	| 1000003419 |
	| 1000003420 |
	| 1000003421 |
	| 1000003422 |
	| 1000003423 |
	| 1000003424 |
	| 1000003425 |
	| 1000003426 |
	| 1000003427 |
	| 1000003428 |
	| 1000003429 |
	| 1000003430 |
	| 1000003431 |
	| 1000003432 |
	| 1000003433 |
	| 1000003434 |
	| 1000003435 |
	| 1000003436 |
	| 1000003437 |
	| 1000003438 |
	| 1000003439 |
	| 1000003440 |
	| 1000003441 |
	| 1000003442 |
	| 1000003443 |
	| 1000003444 |
	| 1000003445 |
	| 1000003446 |
	| 1000003447 |
	| 1000003448 |
	| 1000003449 |
	| 1000003450 |
	| 1000003451 |
	| 1000003452 |
	| 1000003453 |
	| 1000003454 |
	| 1000003455 |
	| 1000003456 |
	| 1000003457 |
	| 1000003458 |
	| 1000003459 |
	| 1000003460 |
	| 1000003461 |
	| 1000003462 |
	| 1000003463 |
	| 1000003464 |
	| 1000003465 |
	| 1000003466 |
	| 1000003467 |
	| 1000003468 |
	| 1000003469 |
	| 1000003470 |
	| 1000003471 |
	| 1000003472 |
	| 1000003473 |
	| 1000003474 |
	| 1000003475 |
	| 1000003476 |
	| 1000003477 |
	| 1000003478 |
	| 1000003479 |
	| 1000003480 |
	| 1000003481 |
	| 1000003482 |
	| 1000003483 |
	| 1000003484 |
	| 1000003485 |
	| 1000003486 |
	| 1000003487 |
	| 1000003488 |
	| 1000003489 |
	| 1000003490 |
	| 1000003491 |
	| 1000003492 |
	| 1000003493 |
	| 1000003494 |
	| 1000003495 |
	| 1000003496 |
	| 1000003497 |
	| 1000003498 |
	| 1000003499 |
	| 1000003500 |
	| 1000003501 |
	| 1000003502 |
	| 1000003503 |
	| 1000003504 |
	| 1000003505 |
	| 1000003506 |
	| 1000003507 |
	| 1000003508 |
	| 1000003509 |
	| 1000003510 |
	| 1000003511 |
	| 1000003512 |
	| 1000003513 |
	| 1000003514 |
	| 1000003515 |
	| 1000003516 |
	| 1000003517 |
	| 1000003518 |
	| 1000003519 |
	| 1000003520 |
	| 1000003521 |
	| 1000003522 |
	| 1000003523 |
	| 1000003524 |
	| 1000003525 |
	| 1000003526 |
	| 1000003527 |
	| 1000003528 |
	| 1000003529 |
	| 1000003530 |
	| 1000003531 |
	| 1000003532 |
	| 1000003533 |
	| 1000003534 |
	| 1000003535 |
	| 1000003536 |
	| 1000003537 |
	| 1000003538 |
	| 1000003539 |
	| 1000003540 |
	| 1000003541 |
	| 1000003542 |
	| 1000003543 |
	| 1000003544 |
	| 1000003545 |
	| 1000003546 |
	| 1000003547 |
	| 1000003548 |
	| 1000003549 |
	| 1000003550 |
	| 1000003551 |
	| 1000003552 |
	| 1000003553 |
	| 1000003554 |
	| 1000003555 |
	| 1000003556 |
	| 1000003557 |
	| 1000003558 |
	| 1000003559 |
	| 1000003560 |
	| 1000003561 |
	| 1000003562 |
	| 1000003563 |
	| 1000003564 |
	| 1000003565 |
	| 1000003566 |
	| 1000003567 |
	| 1000003568 |
	| 1000003569 |
	| 1000003570 |
	| 1000003571 |
	| 1000003572 |
	| 1000003573 |
	| 1000003574 |
	| 1000003575 |
	| 1000003576 |
	| 1000003577 |
	| 1000003578 |
	| 1000003579 |
	| 1000003580 |
	| 1000003581 |
	| 1000003582 |
	| 1000003583 |
	| 1000003584 |
	| 1000003585 |
	| 1000003586 |
	| 1000003587 |
	| 1000003588 |
	| 1000003589 |
	| 1000003590 |
	| 1000003591 |
	| 1000003592 |
	| 1000003593 |
	| 1000003594 |
	| 1000003595 |
	| 1000003596 |
	| 1000003597 |
	| 1000003598 |
	| 1000003599 |
	| 1000003600 |
	| 1000003601 |
	| 1000003602 |
	| 1000003603 |
	| 1000003604 |
	| 1000003605 |
	| 1000003606 |
	| 1000003607 |
	| 1000003608 |
	| 1000003609 |
	| 1000003610 |
	| 1000003611 |
	| 1000003612 |
	| 1000003613 |
	| 1000003614 |
	| 1000003615 |
	| 1000003616 |
	| 1000003617 |
	| 1000003618 |
	| 1000003619 |
	| 1000003620 |
	| 1000003621 |
	| 1000003622 |
	| 1000003623 |
	| 1000003624 |
	| 1000003625 |
	| 1000003626 |
	| 1000003627 |
	| 1000003628 |
	| 1000003629 |
	| 1000003630 |
	| 1000003631 |
	| 1000003632 |
	| 1000003633 |
	| 1000003634 |
	| 1000003635 |
	| 1000003636 |
	| 1000003637 |
	| 1000003638 |
	| 1000003639 |
	| 1000003640 |
	| 1000003641 |
	| 1000003642 |
	| 1000003643 |
	| 1000003644 |
	| 1000003645 |
	| 1000003646 |
	| 1000003647 |
	| 1000003648 |
	| 1000003649 |
	| 1000003650 |
	| 1000003651 |
	| 1000003652 |
	| 1000003653 |
	| 1000003654 |
	| 1000003655 |
	| 1000003656 |
	| 1000003657 |
	| 1000003658 |
	| 1000003659 |
	| 1000003660 |
	| 1000003661 |
	| 1000003662 |
	| 1000003663 |
	| 1000003664 |
	| 1000003665 |
	| 1000003666 |
	| 1000003667 |
	| 1000003668 |
	| 1000003669 |
	| 1000003670 |
	| 1000003671 |
	| 1000003672 |
	| 1000003673 |
	| 1000003674 |
	| 1000003675 |
	| 1000003676 |
	| 1000003677 |
	| 1000003678 |
	| 1000003679 |
	| 1000003680 |
	| 1000003681 |
	| 1000003682 |
	| 1000003683 |
	| 1000003684 |
	| 1000003685 |
	| 1000003686 |
	| 1000003687 |
	| 1000003688 |
	| 1000003689 |
	| 1000003690 |
	| 1000003691 |
	| 1000003692 |
	| 1000003693 |
	| 1000003694 |
	| 1000003695 |
	| 1000003696 |
	| 1000003697 |
	| 1000003698 |
	| 1000003699 |
	| 1000003700 |
	| 1000003701 |
	| 1000003702 |
	| 1000003703 |
	| 1000003704 |
	| 1000003705 |
	| 1000003706 |
	| 1000003707 |
	| 1000003708 |
	| 1000003709 |
	| 1000003710 |
	| 1000003711 |
	| 1000003712 |
	| 1000003713 |
	| 1000003714 |
	| 1000003715 |
	| 1000003716 |
	| 1000003717 |
	| 1000003718 |
	| 1000003719 |
	| 1000003720 |
	| 1000003721 |
	| 1000003722 |
	| 1000003723 |
	| 1000003724 |
	| 1000003725 |
	| 1000003726 |
	| 1000003727 |
	| 1000003728 |
	| 1000003729 |
	| 1000003730 |
	| 1000003731 |
	| 1000003732 |
	| 1000003733 |
	| 1000003734 |
	| 1000003735 |
	| 1000003736 |
	| 1000003737 |
	| 1000003738 |
	| 1000003739 |
	| 1000003740 |
	| 1000003741 |
	| 1000003742 |
	| 1000003743 |
	| 1000003744 |
	| 1000003745 |
	| 1000003746 |
	| 1000003747 |
	| 1000003748 |
	| 1000003749 |
	| 1000003750 |
	| 1000003751 |
	| 1000003752 |
	| 1000003753 |
	| 1000003754 |
	| 1000003755 |
	| 1000003756 |
	| 1000003757 |
	| 1000003758 |
	| 1000003759 |
	| 1000003760 |
	| 1000003761 |
	| 1000003762 |
	| 1000003763 |
	| 1000003764 |
	| 1000003765 |
	| 1000003766 |
	| 1000003767 |
	| 1000003768 |
	| 1000003769 |
	| 1000003770 |
	| 1000003771 |
	| 1000003772 |
	| 1000003773 |
	| 1000003774 |
	| 1000003775 |
	| 1000003776 |
	| 1000003777 |
	| 1000003778 |
	| 1000003779 |
	| 1000003780 |
	| 1000003781 |
	| 1000003782 |
	| 1000003783 |
	| 1000003784 |
	| 1000003785 |
	| 1000003786 |
	| 1000003787 |
	| 1000003788 |
	| 1000003789 |
	| 1000003790 |
	| 1000003791 |
	| 1000003792 |
	| 1000003793 |
	| 1000003794 |
	| 1000003795 |
	| 1000003796 |
	| 1000003797 |
	| 1000003798 |
	| 1000003799 |
	| 1000003800 |
	| 1000003801 |
	| 1000003802 |
	| 1000003803 |
	| 1000003804 |
	| 1000003805 |
	| 1000003806 |
	| 1000003807 |
	| 1000003808 |
	| 1000003809 |
	| 1000003810 |
	| 1000003811 |
	| 1000003812 |
	| 1000003813 |
	| 1000003814 |
	| 1000003815 |
	| 1000003816 |
	| 1000003817 |
	| 1000003818 |
	| 1000003819 |
	| 1000003820 |
	| 1000003821 |
	| 1000003822 |
	| 1000003823 |
	| 1000003824 |
	| 1000003825 |
	| 1000003826 |
	| 1000003827 |
	| 1000003828 |
	| 1000003829 |
	| 1000003830 |
	| 1000003831 |
	| 1000003832 |
	| 1000003833 |
	| 1000003834 |
	| 1000003835 |
	| 1000003836 |
	| 1000003837 |
	| 1000003838 |
	| 1000003839 |
	| 1000003840 |
	| 1000003841 |
	| 1000003842 |
	| 1000003843 |
	| 1000003844 |
	| 1000003845 |
	| 1000003846 |
	| 1000003847 |
	| 1000003848 |
	| 1000003849 |
	| 1000003850 |
	| 1000003851 |
	| 1000003852 |
	| 1000003853 |
	| 1000003854 |
	| 1000003855 |
	| 1000003856 |
	| 1000003857 |
	| 1000003858 |
	| 1000003859 |
	| 1000003860 |
	| 1000003861 |
	| 1000003862 |
	| 1000003863 |
	| 1000003864 |
	| 1000003865 |
	| 1000003866 |
	| 1000003867 |
	| 1000003868 |
	| 1000003869 |
	| 1000003870 |
	| 1000003871 |
	| 1000003872 |
	| 1000003873 |
	| 1000003874 |
	| 1000003875 |
	| 1000003876 |
	| 1000003877 |
	| 1000003878 |
	| 1000003879 |
	| 1000003880 |
	| 1000003881 |
	| 1000003882 |
	| 1000003883 |
	| 1000003884 |
	| 1000003885 |
	| 1000003886 |
	| 1000003887 |
	| 1000003888 |
	| 1000003889 |
	| 1000003890 |
	| 1000003891 |
	| 1000003892 |
	| 1000003893 |
	| 1000003894 |
	| 1000003895 |
	| 1000003896 |
	| 1000003897 |
	| 1000003898 |
	| 1000003899 |
	| 1000003900 |
	| 1000003901 |
	| 1000003902 |
	| 1000003903 |
	| 1000003904 |
	| 1000003905 |
	| 1000003906 |
	| 1000003907 |
	| 1000003908 |
	| 1000003909 |
	| 1000003910 |
	| 1000003911 |
	| 1000003912 |
	| 1000003913 |
	| 1000003914 |
	| 1000003915 |
	| 1000003916 |
	| 1000003917 |
	| 1000003918 |
	| 1000003919 |
	| 1000003920 |
	| 1000003921 |
	| 1000003922 |
	| 1000003923 |
	| 1000003924 |
	| 1000003925 |
	| 1000003926 |
	| 1000003927 |
	| 1000003928 |
	| 1000003929 |
	| 1000003930 |
	| 1000003931 |
	| 1000003932 |
	| 1000003933 |
	| 1000003934 |
	| 1000003935 |
	| 1000003936 |
	| 1000003937 |
	| 1000003938 |
	| 1000003939 |
	| 1000003940 |
	| 1000003941 |
	| 1000003942 |
	| 1000003943 |
	| 1000003944 |
	| 1000003945 |
	| 1000003946 |
	| 1000003947 |
	| 1000003948 |
	| 1000003949 |
	| 1000003950 |
	| 1000003951 |
	| 1000003952 |
	| 1000003953 |
	| 1000003954 |
	| 1000003955 |
	| 1000003956 |
	| 1000003957 |
	| 1000003958 |
	| 1000003959 |
	| 1000003960 |
	| 1000003961 |
	| 1000003962 |
	| 1000003963 |
	| 1000003964 |
	| 1000003965 |
	| 1000003966 |
	| 1000003967 |
	| 1000003968 |
	| 1000003969 |
	| 1000003970 |
	| 1000003971 |
	| 1000003972 |
	| 1000003973 |
	| 1000003974 |
	| 1000003975 |
	| 1000003976 |
	| 1000003977 |
	| 1000003978 |
	| 1000003979 |
	| 1000003980 |
	| 1000003981 |
	| 1000003982 |
	| 1000003983 |
	| 1000003984 |
	| 1000003985 |
	| 1000003986 |
	| 1000003987 |
	| 1000003988 |
	| 1000003989 |
	| 1000003990 |
	| 1000003991 |
	| 1000003992 |
	| 1000003993 |
	| 1000003994 |
	| 1000003995 |
	| 1000003996 |
	| 1000003997 |
	| 1000003998 |
	| 1000003999 |
	| 1000004000 |
	| 1000004001 |
	| 1000004002 |
	| 1000004003 |
	| 1000004004 |
	| 1000004005 |
	| 1000004006 |
	| 1000004007 |
	| 1000004008 |
	| 1000004009 |
	| 1000004010 |
	| 1000004011 |
	| 1000004012 |
	| 1000004013 |
	| 1000004014 |
	| 1000004015 |
	| 1000004016 |
	| 1000004017 |
	| 1000004018 |
	| 1000004019 |
	| 1000004020 |
	| 1000004021 |
	| 1000004022 |
	| 1000004023 |
	| 1000004024 |
	| 1000004025 |
	| 1000004026 |
	| 1000004027 |
	| 1000004028 |
	| 1000004029 |
	| 1000004030 |
	| 1000004031 |
	| 1000004032 |
	| 1000004033 |
	| 1000004034 |
	| 1000004035 |
	| 1000004036 |
	| 1000004037 |
	| 1000004038 |
	| 1000004039 |
	| 1000004040 |
	| 1000004041 |
	| 1000004042 |
	| 1000004043 |
	| 1000004044 |
	| 1000004045 |
	| 1000004046 |
	| 1000004047 |
	| 1000004048 |
	| 1000004049 |
	| 1000004050 |
	| 1000004051 |
	| 1000004052 |
	| 1000004053 |
	| 1000004054 |
	| 1000004055 |
	| 1000004056 |
	| 1000004057 |
	| 1000004058 |
	| 1000004059 |
	| 1000004060 |
	| 1000004061 |
	| 1000004062 |
	| 1000004063 |
	| 1000004064 |
	| 1000004065 |
	| 1000004066 |
	| 1000004067 |
	| 1000004068 |
	| 1000004069 |
	| 1000004070 |
	| 1000004071 |
	| 1000004072 |
	| 1000004073 |
	| 1000004074 |
	| 1000004075 |
	| 1000004076 |
	| 1000004077 |
	| 1000004078 |
	| 1000004079 |
	| 1000004080 |
	| 1000004081 |
	| 1000004082 |
	| 1000004083 |
	| 1000004084 |
	| 1000004085 |
	| 1000004086 |
	| 1000004087 |
	| 1000004088 |
	| 1000004089 |
	| 1000004090 |
	| 1000004091 |
	| 1000004092 |
	| 1000004093 |
	| 1000004094 |
	| 1000004095 |
	| 1000004096 |
	| 1000004097 |
	| 1000004098 |
	| 1000004099 |
	| 1000004100 |
	| 1000004101 |
	| 1000004102 |
	| 1000004103 |
	| 1000004104 |
	| 1000004105 |
	| 1000004106 |
	| 1000004107 |
	| 1000004108 |
	| 1000004109 |
	| 1000004110 |
	| 1000004111 |
	| 1000004112 |
	| 1000004113 |
	| 1000004114 |
	| 1000004115 |
	| 1000004116 |
	| 1000004117 |
	| 1000004118 |
	| 1000004119 |
	| 1000004120 |
	| 1000004121 |
	| 1000004122 |
	| 1000004123 |
	| 1000004124 |
	| 1000004125 |
	| 1000004126 |
	| 1000004127 |
	| 1000004128 |
	| 1000004129 |
	| 1000004130 |
	| 1000004131 |
	| 1000004132 |
	| 1000004133 |
	| 1000004134 |
	| 1000004135 |
	| 1000004136 |
	| 1000004137 |
	| 1000004138 |
	| 1000004139 |
	| 1000004140 |
	| 1000004141 |
	| 1000004142 |
	| 1000004143 |
	| 1000004144 |
	| 1000004145 |
	| 1000004146 |
	| 1000004147 |
	| 1000004148 |
	| 1000004149 |
	| 1000004150 |
	| 1000004151 |
	| 1000004152 |
	| 1000004153 |
	| 1000004154 |
	| 1000004155 |
	| 1000004156 |
	| 1000004157 |
	| 1000004158 |
	| 1000004159 |
	| 1000004160 |
	| 1000004161 |
	| 1000004162 |
	| 1000004163 |
	| 1000004164 |
	| 1000004165 |
	| 1000004166 |
	| 1000004167 |
	| 1000004168 |
	| 1000004169 |
	| 1000004170 |
	| 1000004171 |
	| 1000004172 |
	| 1000004173 |
	| 1000004174 |
	| 1000004175 |
	| 1000004176 |
	| 1000004177 |
	| 1000004178 |
	| 1000004179 |
	| 1000004180 |
	| 1000004181 |
	| 1000004182 |
	| 1000004183 |
	| 1000004184 |
	| 1000004185 |
	| 1000004186 |
	| 1000004187 |
	| 1000004188 |
	| 1000004189 |
	| 1000004190 |
	| 1000004191 |
	| 1000004192 |
	| 1000004193 |
	| 1000004194 |
	| 1000004195 |
	| 1000004196 |
	| 1000004197 |
	| 1000004198 |
	| 1000004199 |
	| 1000004200 |
	| 1000004201 |
	| 1000004202 |
	| 1000004203 |
	| 1000004204 |
	| 1000004205 |
	| 1000004206 |
	| 1000004207 |
	| 1000004208 |
	| 1000004209 |
	| 1000004210 |
	| 1000004211 |
	| 1000004212 |
	| 1000004213 |
	| 1000004214 |
	| 1000004215 |
	| 1000004216 |
	| 1000004217 |
	| 1000004218 |
	| 1000004219 |
	| 1000004220 |
	| 1000004221 |
	| 1000004222 |
	| 1000004223 |
	| 1000004224 |
	| 1000004225 |
	| 1000004226 |
	| 1000004227 |
	| 1000004228 |
	| 1000004229 |
	| 1000004230 |
	| 1000004231 |
	| 1000004232 |
	| 1000004233 |
	| 1000004234 |
	| 1000004235 |
	| 1000004236 |
	| 1000004237 |
	| 1000004238 |
	| 1000004239 |
	| 1000004240 |
	| 1000004241 |
	| 1000004242 |
	| 1000004243 |
	| 1000004244 |
	| 1000004245 |
	| 1000004246 |
	| 1000004247 |
	| 1000004248 |
	| 1000004249 |
	| 1000004250 |
	| 1000004251 |
	| 1000004252 |
	| 1000004253 |
	| 1000004254 |
	| 1000004255 |
	| 1000004256 |
	| 1000004257 |
	| 1000004258 |
	| 1000004259 |
	| 1000004260 |
	| 1000004261 |
	| 1000004262 |
	| 1000004263 |
	| 1000004264 |
	| 1000004265 |
	| 1000004266 |
	| 1000004267 |
	| 1000004268 |
	| 1000004269 |
	| 1000004270 |
	| 1000004271 |
	| 1000004272 |
	| 1000004273 |
	| 1000004274 |
	| 1000004275 |
	| 1000004276 |
	| 1000004277 |
	| 1000004278 |
	| 1000004279 |
	| 1000004280 |
	| 1000004281 |
	| 1000004282 |
	| 1000004283 |
	| 1000004284 |
	| 1000004285 |
	| 1000004286 |
	| 1000004287 |
	| 1000004288 |
	| 1000004289 |
	| 1000004290 |
	| 1000004291 |
	| 1000004292 |
	| 1000004293 |
	| 1000004294 |
	| 1000004295 |
	| 1000004296 |
	| 1000004297 |
	| 1000004298 |
	| 1000004299 |
	| 1000004300 |
	| 1000004301 |
	| 1000004302 |
	| 1000004303 |
	| 1000004304 |
	| 1000004305 |
	| 1000004306 |
	| 1000004307 |
	| 1000004308 |
	| 1000004309 |
	| 1000004310 |
	| 1000004311 |
	| 1000004312 |
	| 1000004313 |
	| 1000004314 |
	| 1000004315 |
	| 1000004316 |
	| 1000004317 |
	| 1000004318 |
	| 1000004319 |
	| 1000004320 |
	| 1000004321 |
	| 1000004322 |
	| 1000004323 |
	| 1000004324 |
	| 1000004325 |
	| 1000004326 |
	| 1000004327 |
	| 1000004328 |
	| 1000004329 |
	| 1000004330 |
	| 1000004331 |
	| 1000004332 |
	| 1000004333 |
	| 1000004334 |
	| 1000004335 |
	| 1000004336 |
	| 1000004337 |
	| 1000004338 |
	| 1000004339 |
	| 1000004340 |
	| 1000004341 |
	| 1000004342 |
	| 1000004343 |
	| 1000004344 |
	| 1000004345 |
	| 1000004346 |
	| 1000004347 |
	| 1000004348 |
	| 1000004349 |
	| 1000004350 |
	| 1000004351 |
	| 1000004352 |
	| 1000004353 |
	| 1000004354 |
	| 1000004355 |
	| 1000004356 |
	| 1000004357 |
	| 1000004358 |
	| 1000004359 |
	| 1000004360 |
	| 1000004361 |
	| 1000004362 |
	| 1000004363 |
	| 1000004364 |
	| 1000004365 |
	| 1000004366 |
	| 1000004367 |
	| 1000004368 |
	| 1000004369 |
	| 1000004370 |
	| 1000004371 |
	| 1000004372 |
	| 1000004373 |
	| 1000004374 |
	| 1000004375 |
	| 1000004376 |
	| 1000004377 |
	| 1000004378 |
	| 1000004379 |
	| 1000004380 |
	| 1000004381 |
	| 1000004382 |
	| 1000004383 |
	| 1000004384 |
	| 1000004385 |
	| 1000004386 |
	| 1000004387 |
	| 1000004388 |
	| 1000004389 |
	| 1000004390 |
	| 1000004391 |
	| 1000004392 |
	| 1000004393 |
	| 1000004394 |
	| 1000004395 |
	| 1000004396 |
	| 1000004397 |
	| 1000004398 |
	| 1000004399 |
	| 1000004400 |
	| 1000004401 |
	| 1000004402 |
	| 1000004403 |
	| 1000004404 |
	| 1000004405 |
	| 1000004406 |
	| 1000004407 |
	| 1000004408 |
	| 1000004409 |
	| 1000004410 |
	| 1000004411 |
	| 1000004412 |
	| 1000004413 |
	| 1000004414 |
	| 1000004415 |
	| 1000004416 |
	| 1000004417 |
	| 1000004418 |
	| 1000004419 |
	| 1000004420 |
	| 1000004421 |
	| 1000004422 |
	| 1000004423 |
	| 1000004424 |
	| 1000004425 |
	| 1000004426 |
	| 1000004427 |
	| 1000004428 |
	| 1000004429 |
	| 1000004430 |
	| 1000004431 |
	| 1000004432 |
	| 1000004433 |
	| 1000004434 |
	| 1000004435 |
	| 1000004436 |
	| 1000004437 |
	| 1000004438 |
	| 1000004439 |
	| 1000004440 |
	| 1000004441 |
	| 1000004442 |
	| 1000004443 |
	| 1000004444 |
	| 1000004445 |
	| 1000004446 |
	| 1000004447 |
	| 1000004448 |
	| 1000004449 |
	| 1000004450 |
	| 1000004451 |
	| 1000004452 |
	| 1000004453 |
	| 1000004454 |
	| 1000004455 |
	| 1000004456 |
	| 1000004457 |
	| 1000004458 |
	| 1000004459 |
	| 1000004460 |
	| 1000004461 |
	| 1000004462 |
	| 1000004463 |
	| 1000004464 |
	| 1000004465 |
	| 1000004466 |
	| 1000004467 |
	| 1000004468 |
	| 1000004469 |
	| 1000004470 |
	| 1000004471 |
	| 1000004472 |
	| 1000004473 |
	| 1000004474 |
	| 1000004475 |
	| 1000004476 |
	| 1000004477 |
	| 1000004478 |
	| 1000004479 |
	| 1000004480 |
	| 1000004481 |
	| 1000004482 |
	| 1000004483 |
	| 1000004484 |
	| 1000004485 |
	| 1000004486 |
	| 1000004487 |
	| 1000004488 |
	| 1000004489 |
	| 1000004490 |
	| 1000004491 |
	| 1000004492 |
	| 1000004493 |
	| 1000004494 |
	| 1000004495 |
	| 1000004496 |
	| 1000004497 |
	| 1000004498 |
	| 1000004499 |
	| 1000004500 |
	| 1000004501 |
	| 1000004502 |
	| 1000004503 |
	| 1000004504 |
	| 1000004505 |
	| 1000004506 |
	| 1000004507 |
	| 1000004508 |
	| 1000004509 |
	| 1000004510 |
	| 1000004511 |
	| 1000004512 |
	| 1000004513 |
	| 1000004514 |
	| 1000004515 |
	| 1000004516 |
	| 1000004517 |
	| 1000004518 |
	| 1000004519 |
	| 1000004520 |
	| 1000004521 |
	| 1000004522 |
	| 1000004523 |
	| 1000004524 |
	| 1000004525 |
	| 1000004526 |
	| 1000004527 |
	| 1000004528 |
	| 1000004529 |
	| 1000004530 |
	| 1000004531 |
	| 1000004532 |
	| 1000004533 |
	| 1000004534 |
	| 1000004535 |
	| 1000004536 |
	| 1000004537 |
	| 1000004538 |
	| 1000004539 |
	| 1000004540 |
	| 1000004541 |
	| 1000004542 |
	| 1000004543 |
	| 1000004544 |
	| 1000004545 |
	| 1000004546 |
	| 1000004547 |
	| 1000004548 |
	| 1000004549 |
	| 1000004550 |
	| 1000004551 |
	| 1000004552 |
	| 1000004553 |
	| 1000004554 |
	| 1000004555 |
	| 1000004556 |
	| 1000004557 |
	| 1000004558 |
	| 1000004559 |
	| 1000004560 |
	| 1000004561 |
	| 1000004562 |
	| 1000004563 |
	| 1000004564 |
	| 1000004565 |
	| 1000004566 |
	| 1000004567 |
	| 1000004568 |
	| 1000004569 |
	| 1000004570 |
	| 1000004571 |
	| 1000004572 |
	| 1000004573 |
	| 1000004574 |
	| 1000004575 |
	| 1000004576 |
	| 1000004577 |
	| 1000004578 |
	| 1000004579 |
	| 1000004580 |
	| 1000004581 |
	| 1000004582 |
	| 1000004583 |
	| 1000004584 |
	| 1000004585 |
	| 1000004586 |
	| 1000004587 |
	| 1000004588 |
	| 1000004589 |
	| 1000004590 |
	| 1000004591 |
	| 1000004592 |
	| 1000004593 |
	| 1000004594 |
	| 1000004595 |
	| 1000004596 |
	| 1000004597 |
	| 1000004598 |
	| 1000004599 |
	| 1000004600 |
	| 1000004601 |
	| 1000004602 |
	| 1000004603 |
	| 1000004604 |
	| 1000004605 |
	| 1000004606 |
	| 1000004607 |
	| 1000004608 |
	| 1000004609 |
	| 1000004610 |
	| 1000004611 |
	| 1000004612 |
	| 1000004613 |
	| 1000004614 |
	| 1000004615 |
	| 1000004616 |
	| 1000004617 |
	| 1000004618 |
	| 1000004619 |
	| 1000004620 |
	| 1000004621 |
	| 1000004622 |
	| 1000004623 |
	| 1000004624 |
	| 1000004625 |
	| 1000004626 |
	| 1000004627 |
	| 1000004628 |
	| 1000004629 |
	| 1000004630 |
	| 1000004631 |
	| 1000004632 |
	| 1000004633 |
	| 1000004634 |
	| 1000004635 |
	| 1000004636 |
	| 1000004637 |
	| 1000004638 |
	| 1000004639 |
	| 1000004640 |
	| 1000004641 |
	| 1000004642 |
	| 1000004643 |
	| 1000004644 |
	| 1000004645 |
	| 1000004646 |
	| 1000004647 |
	| 1000004648 |
	| 1000004649 |
	| 1000004650 |
	| 1000004651 |
	| 1000004652 |
	| 1000004653 |
	| 1000004654 |
	| 1000004655 |
	| 1000004656 |
	| 1000004657 |
	| 1000004658 |
	| 1000004659 |
	| 1000004660 |
	| 1000004661 |
	| 1000004662 |
	| 1000004663 |
	| 1000004664 |
	| 1000004665 |
	| 1000004666 |
	| 1000004667 |
	| 1000004668 |
	| 1000004669 |
	| 1000004670 |
	| 1000004671 |
	| 1000004672 |
	| 1000004673 |
	| 1000004674 |
	| 1000004675 |
	| 1000004676 |
	| 1000004677 |
	| 1000004678 |
	| 1000004679 |
	| 1000004680 |
	| 1000004681 |
	| 1000004682 |
	| 1000004683 |
	| 1000004684 |
	| 1000004685 |
	| 1000004686 |
	| 1000004687 |
	| 1000004688 |
	| 1000004689 |
	| 1000004690 |
	| 1000004691 |
	| 1000004692 |
	| 1000004693 |
	| 1000004694 |
	| 1000004695 |
	| 1000004696 |
	| 1000004697 |
	| 1000004698 |
	| 1000004699 |
	| 1000004700 |
	| 1000004701 |
	| 1000004702 |
	| 1000004703 |
	| 1000004704 |
	| 1000004705 |
	| 1000004706 |
	| 1000004707 |
	| 1000004708 |
	| 1000004709 |
	| 1000004710 |
	| 1000004711 |
	| 1000004712 |
	| 1000004713 |
	| 1000004714 |
	| 1000004715 |
	| 1000004716 |
	| 1000004717 |
	| 1000004718 |
	| 1000004719 |
	| 1000004720 |
	| 1000004721 |
	| 1000004722 |
	| 1000004723 |
	| 1000004724 |
	| 1000004725 |
	| 1000004726 |
	| 1000004727 |
	| 1000004728 |
	| 1000004729 |
	| 1000004730 |
	| 1000004731 |
	| 1000004732 |
	| 1000004733 |
	| 1000004734 |
	| 1000004735 |
	| 1000004736 |
	| 1000004737 |
	| 1000004738 |
	| 1000004739 |
	| 1000004740 |
	| 1000004741 |
	| 1000004742 |
	| 1000004743 |
	| 1000004744 |
	| 1000004745 |
	| 1000004746 |
	| 1000004747 |
	| 1000004748 |
	| 1000004749 |
	| 1000004750 |
	| 1000004751 |
	| 1000004752 |
	| 1000004753 |
	| 1000004754 |
	| 1000004755 |
	| 1000004756 |
	| 1000004757 |
	| 1000004758 |
	| 1000004759 |
	| 1000004760 |
	| 1000004761 |
	| 1000004762 |
	| 1000004763 |
	| 1000004764 |
	| 1000004765 |
	| 1000004766 |
	| 1000004767 |
	| 1000004768 |
	| 1000004769 |
	| 1000004770 |
	| 1000004771 |
	| 1000004772 |
	| 1000004773 |
	| 1000004774 |
	| 1000004775 |
	| 1000004776 |
	| 1000004777 |
	| 1000004778 |
	| 1000004779 |
	| 1000004780 |
	| 1000004781 |
	| 1000004782 |
	| 1000004783 |
	| 1000004784 |
	| 1000004785 |
	| 1000004786 |
	| 1000004787 |
	| 1000004788 |
	| 1000004789 |
	| 1000004790 |
	| 1000004791 |
	| 1000004792 |
	| 1000004793 |
	| 1000004794 |
	| 1000004795 |
	| 1000004796 |
	| 1000004797 |
	| 1000004798 |
	| 1000004799 |
	| 1000004800 |
	| 1000004801 |
	| 1000004802 |
	| 1000004803 |
	| 1000004804 |
	| 1000004805 |
	| 1000004806 |
	| 1000004807 |
	| 1000004808 |
	| 1000004809 |
	| 1000004810 |
	| 1000004811 |
	| 1000004812 |
	| 1000004813 |
	| 1000004814 |
	| 1000004815 |
	| 1000004816 |
	| 1000004817 |
	| 1000004818 |
	| 1000004819 |
	| 1000004820 |
	| 1000004821 |
	| 1000004822 |
	| 1000004823 |
	| 1000004824 |
	| 1000004825 |
	| 1000004826 |
	| 1000004827 |
	| 1000004828 |
	| 1000004829 |
	| 1000004830 |
	| 1000004831 |
	| 1000004832 |
	| 1000004833 |
	| 1000004834 |
	| 1000004835 |
	| 1000004836 |
	| 1000004837 |
	| 1000004838 |
	| 1000004839 |
	| 1000004840 |
	| 1000004841 |
	| 1000004842 |
	| 1000004843 |
	| 1000004844 |
	| 1000004845 |
	| 1000004846 |
	| 1000004847 |
	| 1000004848 |
	| 1000004849 |
	| 1000004850 |
	| 1000004851 |
	| 1000004852 |
	| 1000004853 |
	| 1000004854 |
	| 1000004855 |
	| 1000004856 |
	| 1000004857 |
	| 1000004858 |
	| 1000004859 |
	| 1000004860 |
	| 1000004861 |
	| 1000004862 |
	| 1000004863 |
	| 1000004864 |
	| 1000004865 |
	| 1000004866 |
	| 1000004867 |
	| 1000004868 |
	| 1000004869 |
	| 1000004870 |
	| 1000004871 |
	| 1000004872 |
	| 1000004873 |
	| 1000004874 |
	| 1000004875 |
	| 1000004876 |
	| 1000004877 |
	| 1000004878 |
	| 1000004879 |
	| 1000004880 |
	| 1000004881 |
	| 1000004882 |
	| 1000004883 |
	| 1000004884 |
	| 1000004885 |
	| 1000004886 |
	| 1000004887 |
	| 1000004888 |
	| 1000004889 |
	| 1000004890 |
	| 1000004891 |
	| 1000004892 |
	| 1000004893 |
	| 1000004894 |
	| 1000004895 |
	| 1000004896 |
	| 1000004897 |
	| 1000004898 |
	| 1000004899 |
	| 1000004900 |
	| 1000004901 |
	| 1000004902 |
	| 1000004903 |
	| 1000004904 |
	| 1000004905 |
	| 1000004906 |
	| 1000004907 |
	| 1000004908 |
	| 1000004909 |
	| 1000004910 |
	| 1000004911 |
	| 1000004912 |
	| 1000004913 |
	| 1000004914 |
	| 1000004915 |
	| 1000004916 |
	| 1000004917 |
	| 1000004918 |
	| 1000004919 |
	| 1000004920 |
	| 1000004921 |
	| 1000004922 |
	| 1000004923 |
	| 1000004924 |
	| 1000004925 |
	| 1000004926 |
	| 1000004927 |
	| 1000004928 |
	| 1000004929 |
	| 1000004930 |
	| 1000004931 |
	| 1000004932 |
	| 1000004933 |
	| 1000004934 |
	| 1000004935 |
	| 1000004936 |
	| 1000004937 |
	| 1000004938 |
	| 1000004939 |
	| 1000004940 |
	| 1000004941 |
	| 1000004942 |
	| 1000004943 |
	| 1000004944 |
	| 1000004945 |
	| 1000004946 |
	| 1000004947 |
	| 1000004948 |
	| 1000004949 |
	| 1000004950 |
	| 1000004951 |
	| 1000004952 |
	| 1000004953 |
	| 1000004954 |
	| 1000004955 |
	| 1000004956 |
	| 1000004957 |
	| 1000004958 |
	| 1000004959 |
	| 1000004960 |
	| 1000004961 |
	| 1000004962 |
	| 1000004963 |
	| 1000004964 |
	| 1000004965 |
	| 1000004966 |
	| 1000004967 |
	| 1000004968 |
	| 1000004969 |
	| 1000004970 |
	| 1000004971 |
	| 1000004972 |
	| 1000004973 |
	| 1000004974 |
	| 1000004975 |
	| 1000004976 |
	| 1000004977 |
	| 1000004978 |
	| 1000004979 |
	| 1000004980 |
	| 1000004981 |
	| 1000004982 |
	| 1000004983 |
	| 1000004984 |
	| 1000004985 |
	| 1000004986 |
	| 1000004987 |
	| 1000004988 |
	| 1000004989 |
	| 1000004990 |
	| 1000004991 |
	| 1000004992 |
	| 1000004993 |
	| 1000004994 |
	| 1000004995 |
	| 1000004996 |
	| 1000004997 |
	| 1000004998 |
	| 1000004999 |
	| 1000005000 |
	| 1000005001 |
	| 1000005002 |
	| 1000005003 |
	| 1000005004 |
	| 1000005005 |
	| 1000005006 |
	| 1000005007 |
	| 1000005008 |
	| 1000005009 |
	| 1000005010 |
	| 1000005011 |
	| 1000005012 |
	| 1000005013 |
	| 1000005014 |
	| 1000005015 |
	| 1000005016 |
	| 1000005017 |
	| 1000005018 |
	| 1000005019 |
	| 1000005020 |
	| 1000005021 |
	| 1000005022 |
	| 1000005023 |
	| 1000005024 |
	| 1000005025 |
	| 1000005026 |
	| 1000005027 |
	| 1000005028 |
	| 1000005029 |
	| 1000005030 |
	| 1000005031 |
	| 1000005032 |
	| 1000005033 |
	| 1000005034 |
	| 1000005035 |
	| 1000005036 |
	| 1000005037 |
	| 1000005038 |
	| 1000005039 |
	| 1000005040 |
	| 1000005041 |
	| 1000005042 |
	| 1000005043 |
	| 1000005044 |
	| 1000005045 |
	| 1000005046 |
	| 1000005047 |
	| 1000005048 |
	| 1000005049 |
	| 1000005050 |
	| 1000005051 |
	| 1000005052 |
	| 1000005053 |
	| 1000005054 |
	| 1000005055 |
	| 1000005056 |
	| 1000005057 |
	| 1000005058 |
	| 1000005059 |
	| 1000005060 |
	| 1000005061 |
	| 1000005062 |
	| 1000005063 |
	| 1000005064 |
	| 1000005065 |
	| 1000005066 |
	| 1000005067 |
	| 1000005068 |
	| 1000005069 |
	| 1000005070 |
	| 1000005071 |
	| 1000005072 |
	| 1000005073 |
	| 1000005074 |
	| 1000005075 |
	| 1000005076 |
	| 1000005077 |
	| 1000005078 |
	| 1000005079 |
	| 1000005080 |
	| 1000005081 |
	| 1000005082 |
	| 1000005083 |
	| 1000005084 |
	| 1000005085 |
	| 1000005086 |
	| 1000005087 |
	| 1000005088 |
	| 1000005089 |
	| 1000005090 |
	| 1000005091 |
	| 1000005092 |
	| 1000005093 |
	| 1000005094 |
	| 1000005095 |
	| 1000005096 |
	| 1000005097 |
	| 1000005098 |
	| 1000005099 |
	| 1000005100 |
	| 1000005101 |
	| 1000005102 |
	| 1000005103 |
	| 1000005104 |
	| 1000005105 |
	| 1000005106 |
	| 1000005107 |
	| 1000005108 |
	| 1000005109 |
	| 1000005110 |
	| 1000005111 |
	| 1000005112 |
	| 1000005113 |
	| 1000005114 |
	| 1000005115 |
	| 1000005116 |
	| 1000005117 |
	| 1000005118 |
	| 1000005119 |
	| 1000005120 |
	| 1000005121 |
	| 1000005122 |
	| 1000005123 |
	| 1000005124 |
	| 1000005125 |
	| 1000005126 |
	| 1000005127 |
	| 1000005128 |
	| 1000005129 |
	| 1000005130 |
	| 1000005131 |
	| 1000005132 |
	| 1000005133 |
	| 1000005134 |
	| 1000005135 |
	| 1000005136 |
	| 1000005137 |
	| 1000005138 |
	| 1000005139 |
	| 1000005140 |
	| 1000005141 |
	| 1000005142 |
	| 1000005143 |
	| 1000005144 |
	| 1000005145 |
	| 1000005146 |
	| 1000005147 |
	| 1000005148 |
	| 1000005149 |
	| 1000005150 |
	| 1000005151 |
	| 1000005152 |
	| 1000005153 |
	| 1000005154 |
	| 1000005155 |
	| 1000005156 |
	| 1000005157 |
	| 1000005158 |
	| 1000005159 |
	| 1000005160 |
	| 1000005161 |
	| 1000005162 |
	| 1000005163 |
	| 1000005164 |
	| 1000005165 |
	| 1000005166 |
	| 1000005167 |
	| 1000005168 |
	| 1000005169 |
	| 1000005170 |
	| 1000005171 |
	| 1000005172 |
	| 1000005173 |
	| 1000005174 |
	| 1000005175 |
	| 1000005176 |
	| 1000005177 |
	| 1000005178 |
	| 1000005179 |
	| 1000005180 |
	| 1000005181 |
	| 1000005182 |
	| 1000005183 |
	| 1000005184 |
	| 1000005185 |
	| 1000005186 |
	| 1000005187 |
	| 1000005188 |
	| 1000005189 |
	| 1000005190 |
	| 1000005191 |
	| 1000005192 |
	| 1000005193 |
	| 1000005194 |
	| 1000005195 |
	| 1000005196 |
	| 1000005197 |
	| 1000005198 |
	| 1000005199 |
	| 1000005200 |
	| 1000005201 |
	| 1000005202 |
	| 1000005203 |
	| 1000005204 |
	| 1000005205 |
	| 1000005206 |
	| 1000005207 |
	| 1000005208 |
	| 1000005209 |
	| 1000005210 |
	| 1000005211 |
	| 1000005212 |
	| 1000005213 |
	| 1000005214 |
	| 1000005215 |
	| 1000005216 |
	| 1000005217 |
	| 1000005218 |
	| 1000005219 |
	| 1000005220 |
	| 1000005221 |
	| 1000005222 |
	| 1000005223 |
	| 1000005224 |
	| 1000005225 |
	| 1000005226 |
	| 1000005227 |
	| 1000005228 |
	| 1000005229 |
	| 1000005230 |
	| 1000005231 |
	| 1000005232 |
	| 1000005233 |
	| 1000005234 |
	| 1000005235 |
	| 1000005236 |
	| 1000005237 |
	| 1000005238 |
	| 1000005239 |
	| 1000005240 |
	| 1000005241 |
	| 1000005242 |
	| 1000005243 |
	| 1000005244 |
	| 1000005245 |
	| 1000005246 |
	| 1000005247 |
	| 1000005248 |
	| 1000005249 |
	| 1000005250 |
	| 1000005251 |
	| 1000005252 |
	| 1000005253 |
	| 1000005254 |
	| 1000005255 |
	| 1000005256 |
	| 1000005257 |
	| 1000005258 |
	| 1000005259 |
	| 1000005260 |
	| 1000005261 |
	| 1000005262 |
	| 1000005263 |
	| 1000005264 |
	| 1000005265 |
	| 1000005266 |
	| 1000005267 |
	| 1000005268 |
	| 1000005269 |
	| 1000005270 |
	| 1000005271 |
	| 1000005272 |
	| 1000005273 |
	| 1000005274 |
	| 1000005275 |
	| 1000005276 |
	| 1000005277 |
	| 1000005278 |
	| 1000005279 |
	| 1000005280 |
	| 1000005281 |
	| 1000005282 |
	| 1000005283 |
	| 1000005284 |
	| 1000005285 |
	| 1000005286 |
	| 1000005287 |
	| 1000005288 |
	| 1000005289 |
	| 1000005290 |
	| 1000005291 |
	| 1000005292 |
	| 1000005293 |
	| 1000005294 |
	| 1000005295 |
	| 1000005296 |
	| 1000005297 |
	| 1000005298 |
	| 1000005299 |
	| 1000005300 |
	| 1000005301 |
	| 1000005302 |
	| 1000005303 |
	| 1000005304 |
	| 1000005305 |
	| 1000005306 |
	| 1000005307 |
	| 1000005308 |
	| 1000005309 |
	| 1000005310 |
	| 1000005311 |
	| 1000005312 |
	| 1000005313 |
	| 1000005314 |
	| 1000005315 |
	| 1000005316 |
	| 1000005317 |
	| 1000005318 |
	| 1000005319 |
	| 1000005320 |
	| 1000005321 |
	| 1000005322 |
	| 1000005323 |
	| 1000005324 |
	| 1000005325 |
	| 1000005326 |
	| 1000005327 |
	| 1000005328 |
	| 1000005329 |
	| 1000005330 |
	| 1000005331 |
	| 1000005332 |
	| 1000005333 |
	| 1000005334 |
	| 1000005335 |
	| 1000005336 |
	| 1000005337 |
	| 1000005338 |
	| 1000005339 |
	| 1000005340 |
	| 1000005341 |
	| 1000005342 |
	| 1000005343 |
	| 1000005344 |
	| 1000005345 |
	| 1000005346 |
	| 1000005347 |
	| 1000005348 |
	| 1000005349 |
	| 1000005350 |
	| 1000005351 |
	| 1000005352 |
	| 1000005353 |
	| 1000005354 |
	| 1000005355 |
	| 1000005356 |
	| 1000005357 |
	| 1000005358 |
	| 1000005359 |
	| 1000005360 |
	| 1000005361 |
	| 1000005362 |
	| 1000005363 |
	| 1000005364 |
	| 1000005365 |
	| 1000005366 |
	| 1000005367 |
	| 1000005368 |
	| 1000005369 |
	| 1000005370 |
	| 1000005371 |
	| 1000005372 |
	| 1000005373 |
	| 1000005374 |
	| 1000005375 |
	| 1000005376 |
	| 1000005377 |
	| 1000005378 |
	| 1000005379 |
	| 1000005380 |
	| 1000005381 |
	| 1000005382 |
	| 1000005383 |
	| 1000005384 |
	| 1000005385 |
	| 1000005386 |
	| 1000005387 |
	| 1000005388 |
	| 1000005389 |
	| 1000005390 |
	| 1000005391 |
	| 1000005392 |
	| 1000005393 |
	| 1000005394 |
	| 1000005395 |
	| 1000005396 |
	| 1000005397 |
	| 1000005398 |
	| 1000005399 |
	| 1000005400 |
	| 1000005401 |
	| 1000005402 |
	| 1000005403 |
	| 1000005404 |
	| 1000005405 |
	| 1000005406 |
	| 1000005407 |
	| 1000005408 |
	| 1000005409 |
	| 1000005410 |
	| 1000005411 |
	| 1000005412 |
	| 1000005413 |
	| 1000005414 |
	| 1000005415 |
	| 1000005416 |
	| 1000005417 |
	| 1000005418 |
	| 1000005419 |
	| 1000005420 |
	| 1000005421 |
	| 1000005422 |
	| 1000005423 |
	| 1000005424 |
	| 1000005425 |
	| 1000005426 |
	| 1000005427 |
	| 1000005428 |
	| 1000005429 |
	| 1000005430 |
	| 1000005431 |
	| 1000005432 |
	| 1000005433 |
	| 1000005434 |
	| 1000005435 |
	| 1000005436 |
	| 1000005437 |
	| 1000005438 |
	| 1000005439 |
	| 1000005440 |
	| 1000005441 |
	| 1000005442 |
	| 1000005443 |
	| 1000005444 |
	| 1000005445 |
	| 1000005446 |
	| 1000005447 |
	| 1000005448 |
	| 1000005449 |
	| 1000005450 |
	| 1000005451 |
	| 1000005452 |
	| 1000005453 |
	| 1000005454 |
	| 1000005455 |
	| 1000005456 |
	| 1000005457 |
	| 1000005458 |
	| 1000005459 |
	| 1000005460 |
	| 1000005461 |
	| 1000005462 |
	| 1000005463 |
	| 1000005464 |
	| 1000005465 |
	| 1000005466 |
	| 1000005467 |
	| 1000005468 |
	| 1000005469 |
	| 1000005470 |
	| 1000005471 |
	| 1000005472 |
	| 1000005473 |
	| 1000005474 |
	| 1000005475 |
	| 1000005476 |
	| 1000005477 |
	| 1000005478 |
	| 1000005479 |
	| 1000005480 |
	| 1000005481 |
	| 1000005482 |
	| 1000005483 |
	| 1000005484 |
	| 1000005485 |
	| 1000005486 |
	| 1000005487 |
	| 1000005488 |
	| 1000005489 |
	| 1000005490 |
	| 1000005491 |
	| 1000005492 |
	| 1000005493 |
	| 1000005494 |
	| 1000005495 |
	| 1000005496 |
	| 1000005497 |
	| 1000005498 |
	| 1000005499 |
	| 1000005500 |
	| 1000005501 |
	| 1000005502 |
	| 1000005503 |
	| 1000005504 |
	| 1000005505 |
	| 1000005506 |
	| 1000005507 |
	| 1000005508 |
	| 1000005509 |
	| 1000005510 |
	| 1000005511 |
	| 1000005512 |
	| 1000005513 |
	| 1000005514 |
	| 1000005515 |
	| 1000005516 |
	| 1000005517 |
	| 1000005518 |
	| 1000005519 |
	| 1000005520 |
	| 1000005521 |
	| 1000005522 |
	| 1000005523 |
	| 1000005524 |
	| 1000005525 |
	| 1000005526 |
	| 1000005527 |
	| 1000005528 |
	| 1000005529 |
	| 1000005530 |
	| 1000005531 |
	| 1000005532 |
	| 1000005533 |
	| 1000005534 |
	| 1000005535 |
	| 1000005536 |
	| 1000005537 |
	| 1000005538 |
	| 1000005539 |
	| 1000005540 |
	| 1000005541 |
	| 1000005542 |
	| 1000005543 |
	| 1000005544 |
	| 1000005545 |
	| 1000005546 |
	| 1000005547 |
	| 1000005548 |
	| 1000005549 |
	| 1000005550 |
	| 1000005551 |
	| 1000005552 |
	| 1000005553 |
	| 1000005554 |
	| 1000005555 |
	| 1000005556 |
	| 1000005557 |
	| 1000005558 |
	| 1000005559 |
	| 1000005560 |
	| 1000005561 |
	| 1000005562 |
	| 1000005563 |
	| 1000005564 |
	| 1000005565 |
	| 1000005566 |
	| 1000005567 |
	| 1000005568 |
	| 1000005569 |
	| 1000005570 |
	| 1000005571 |
	| 1000005572 |
	| 1000005573 |
	| 1000005574 |
	| 1000005575 |
	| 1000005576 |
	| 1000005577 |
	| 1000005578 |
	| 1000005579 |
	| 1000005580 |
	| 1000005581 |
	| 1000005582 |
	| 1000005583 |
	| 1000005584 |
	| 1000005585 |
	| 1000005586 |
	| 1000005587 |
	| 1000005588 |
	| 1000005589 |
	| 1000005590 |
	| 1000005591 |
	| 1000005592 |
	| 1000005593 |
	| 1000005594 |
	| 1000005595 |
	| 1000005596 |
	| 1000005597 |
	| 1000005598 |
	| 1000005599 |
	| 1000005600 |
	| 1000005601 |
	| 1000005602 |
	| 1000005603 |
	| 1000005604 |
	| 1000005605 |
	| 1000005606 |
	| 1000005607 |
	| 1000005608 |
	| 1000005609 |
	| 1000005610 |
	| 1000005611 |
	| 1000005612 |
	| 1000005613 |
	| 1000005614 |
	| 1000005615 |
	| 1000005616 |
	| 1000005617 |
	| 1000005618 |
	| 1000005619 |
	| 1000005620 |
	| 1000005621 |
	| 1000005622 |
	| 1000005623 |
	| 1000005624 |
	| 1000005625 |
	| 1000005626 |
	| 1000005627 |
	| 1000005628 |
	| 1000005629 |
	| 1000005630 |
	| 1000005631 |
	| 1000005632 |
	| 1000005633 |
	| 1000005634 |
	| 1000005635 |
	| 1000005636 |
	| 1000005637 |
	| 1000005638 |
	| 1000005639 |
	| 1000005640 |
	| 1000005641 |
	| 1000005642 |
	| 1000005643 |
	| 1000005644 |
	| 1000005645 |
	| 1000005646 |
	| 1000005647 |
	| 1000005648 |
	| 1000005649 |
	| 1000005650 |
	| 1000005651 |
	| 1000005652 |
	| 1000005653 |
	| 1000005654 |
	| 1000005655 |
	| 1000005656 |
	| 1000005657 |
	| 1000005658 |
	| 1000005659 |
	| 1000005660 |
	| 1000005661 |
	| 1000005662 |
	| 1000005663 |
	| 1000005664 |
	| 1000005665 |
	| 1000005666 |
	| 1000005667 |
	| 1000005668 |
	| 1000005669 |
	| 1000005670 |
	| 1000005671 |
	| 1000005672 |
	| 1000005673 |
	| 1000005674 |
	| 1000005675 |
	| 1000005676 |
	| 1000005677 |
	| 1000005678 |
	| 1000005679 |
	| 1000005680 |
	| 1000005681 |
	| 1000005682 |
	| 1000005683 |
	| 1000005684 |
	| 1000005685 |
	| 1000005686 |
	| 1000005687 |
	| 1000005688 |
	| 1000005689 |
	| 1000005690 |
	| 1000005691 |
	| 1000005692 |
	| 1000005693 |
	| 1000005694 |
	| 1000005695 |
	| 1000005696 |
	| 1000005697 |
	| 1000005698 |
	| 1000005699 |
	| 1000005700 |
	| 1000005701 |
	| 1000005702 |
	| 1000005703 |
	| 1000005704 |
	| 1000005705 |
	| 1000005706 |
	| 1000005707 |
	| 1000005708 |
	| 1000005709 |
	| 1000005710 |
	| 1000005711 |
	| 1000005712 |
	| 1000005713 |
	| 1000005714 |
	| 1000005715 |
	| 1000005716 |
	| 1000005717 |
	| 1000005718 |
	| 1000005719 |
	| 1000005720 |
	| 1000005721 |
	| 1000005722 |
	| 1000005723 |
	| 1000005724 |
	| 1000005725 |
	| 1000005726 |
	| 1000005727 |
	| 1000005728 |
	| 1000005729 |
	| 1000005730 |
	| 1000005731 |
	| 1000005732 |
	| 1000005733 |
	| 1000005734 |
	| 1000005735 |
	| 1000005736 |
	| 1000005737 |
	| 1000005738 |
	| 1000005739 |
	| 1000005740 |
	| 1000005741 |
	| 1000005742 |
	| 1000005743 |
	| 1000005744 |
	| 1000005745 |
	| 1000005746 |
	| 1000005747 |
	| 1000005748 |
	| 1000005749 |
	| 1000005750 |
	| 1000005751 |
	| 1000005752 |
	| 1000005753 |
	| 1000005754 |
	| 1000005755 |
	| 1000005756 |
	| 1000005757 |
	| 1000005758 |
	| 1000005759 |
	| 1000005760 |
	| 1000005761 |
	| 1000005762 |
	| 1000005763 |
	| 1000005764 |
	| 1000005765 |
	| 1000005766 |
	| 1000005767 |
	| 1000005768 |
	| 1000005769 |
	| 1000005770 |
	| 1000005771 |
	| 1000005772 |
	| 1000005773 |
	| 1000005774 |
	| 1000005775 |
	| 1000005776 |
	| 1000005777 |
	| 1000005778 |
	| 1000005779 |
	| 1000005780 |
	| 1000005781 |
	| 1000005782 |
	| 1000005783 |
	| 1000005784 |
	| 1000005785 |
	| 1000005786 |
	| 1000005787 |
	| 1000005788 |
	| 1000005789 |
	| 1000005790 |
	| 1000005791 |
	| 1000005792 |
	| 1000005793 |
	| 1000005794 |
	| 1000005795 |
	| 1000005796 |
	| 1000005797 |
	| 1000005798 |
	| 1000005799 |
	| 1000005800 |
	| 1000005801 |
	| 1000005802 |
	| 1000005803 |
	| 1000005804 |
	| 1000005805 |
	| 1000005806 |
	| 1000005807 |
	| 1000005808 |
	| 1000005809 |
	| 1000005810 |
	| 1000005811 |
	| 1000005812 |
	| 1000005813 |
	| 1000005814 |
	| 1000005815 |
	| 1000005816 |
	| 1000005817 |
	| 1000005818 |
	| 1000005819 |
	| 1000005820 |
	| 1000005821 |
	| 1000005822 |
	| 1000005823 |
	| 1000005824 |
	| 1000005825 |
	| 1000005826 |
	| 1000005827 |
	| 1000005828 |
	| 1000005829 |
	| 1000005830 |
	| 1000005831 |
	| 1000005832 |
	| 1000005833 |
	| 1000005834 |
	| 1000005835 |
	| 1000005836 |
	| 1000005837 |
	| 1000005838 |
	| 1000005839 |
	| 1000005840 |
	| 1000005841 |
	| 1000005842 |
	| 1000005843 |
	| 1000005844 |
	| 1000005845 |
	| 1000005846 |
	| 1000005847 |
	| 1000005848 |
	| 1000005849 |
	| 1000005850 |
	| 1000005851 |
	| 1000005852 |
	| 1000005853 |
	| 1000005854 |
	| 1000005855 |
	| 1000005856 |
	| 1000005857 |
	| 1000005858 |
	| 1000005859 |
	| 1000005860 |
	| 1000005861 |
	| 1000005862 |
	| 1000005863 |
	| 1000005864 |
	| 1000005865 |
	| 1000005866 |
	| 1000005867 |
	| 1000005868 |
	| 1000005869 |
	| 1000005870 |
	| 1000005871 |
	| 1000005872 |
	| 1000005873 |
	| 1000005874 |
	| 1000005875 |
	| 1000005876 |
	| 1000005877 |
	| 1000005878 |
	| 1000005879 |
	| 1000005880 |
	| 1000005881 |
	| 1000005882 |
	| 1000005883 |
	| 1000005884 |
	| 1000005885 |
	| 1000005886 |
	| 1000005887 |
	| 1000005888 |
	| 1000005889 |
	| 1000005890 |
	| 1000005891 |
	| 1000005892 |
	| 1000005893 |
	| 1000005894 |
	| 1000005895 |
	| 1000005896 |
	| 1000005897 |
	| 1000005898 |
	| 1000005899 |
	| 1000005900 |
	| 1000005901 |
	| 1000005902 |
	| 1000005903 |
	| 1000005904 |
	| 1000005905 |
	| 1000005906 |
	| 1000005907 |
	| 1000005908 |
	| 1000005909 |
	| 1000005910 |
	| 1000005911 |
	| 1000005912 |
	| 1000005913 |
	| 1000005914 |
	| 1000005915 |
	| 1000005916 |
	| 1000005917 |
	| 1000005918 |
	| 1000005919 |
	| 1000005920 |
	| 1000005921 |
	| 1000005922 |
	| 1000005923 |
	| 1000005924 |
	| 1000005925 |
	| 1000005926 |
	| 1000005927 |
	| 1000005928 |
	| 1000005929 |
	| 1000005930 |
	| 1000005931 |
	| 1000005932 |
	| 1000005933 |
	| 1000005934 |
	| 1000005935 |
	| 1000005936 |
	| 1000005937 |
	| 1000005938 |
	| 1000005939 |
	| 1000005940 |
	| 1000005941 |
	| 1000005942 |
	| 1000005943 |
	| 1000005944 |
	| 1000005945 |
	| 1000005946 |
	| 1000005947 |
	| 1000005948 |
	| 1000005949 |
	| 1000005950 |
	| 1000005951 |
	| 1000005952 |
	| 1000005953 |
	| 1000005954 |
	| 1000005955 |
	| 1000005956 |
	| 1000005957 |
	| 1000005958 |
	| 1000005959 |
	| 1000005960 |
	| 1000005961 |
	| 1000005962 |
	| 1000005963 |
	| 1000005964 |
	| 1000005965 |
	| 1000005966 |
	| 1000005967 |
	| 1000005968 |
	| 1000005969 |
	| 1000005970 |
	| 1000005971 |
	| 1000005972 |
	| 1000005973 |
	| 1000005974 |
	| 1000005975 |
	| 1000005976 |
	| 1000005977 |
	| 1000005978 |
	| 1000005979 |
	| 1000005980 |
	| 1000005981 |
	| 1000005982 |
	| 1000005983 |
	| 1000005984 |
	| 1000005985 |
	| 1000005986 |
	| 1000005987 |
	| 1000005988 |
	| 1000005989 |
	| 1000005990 |
	| 1000005991 |
	| 1000005992 |
	| 1000005993 |
	| 1000005994 |
	| 1000005995 |
	| 1000005996 |
	| 1000005997 |
	| 1000005998 |
	| 1000005999 |
	| 1000006000 |
	| 1000006001 |
	| 1000006002 |
	| 1000006003 |
	| 1000006004 |
	| 1000006005 |
	| 1000006006 |
	| 1000006007 |
	| 1000006008 |
	| 1000006009 |
	| 1000006010 |
	| 1000006011 |
	| 1000006012 |
	| 1000006013 |
	| 1000006014 |
	| 1000006015 |
	| 1000006016 |
	| 1000006017 |
	| 1000006018 |
	| 1000006019 |
	| 1000006020 |
	| 1000006021 |
	| 1000006022 |
	| 1000006023 |
	| 1000006024 |
	| 1000006025 |
	| 1000006026 |
	| 1000006027 |
	| 1000006028 |
	| 1000006029 |
	| 1000006030 |
	| 1000006031 |
	| 1000006032 |
	| 1000006033 |
	| 1000006034 |
	| 1000006035 |
	| 1000006036 |
	| 1000006037 |
	| 1000006038 |
	| 1000006039 |
	| 1000006040 |
	| 1000006041 |
	| 1000006042 |
	| 1000006043 |
	| 1000006044 |
	| 1000006045 |
	| 1000006046 |
	| 1000006047 |
	| 1000006048 |
	| 1000006049 |
	| 1000006050 |
	| 1000006051 |
	| 1000006052 |
	| 1000006053 |
	| 1000006054 |
	| 1000006055 |
	| 1000006056 |
	| 1000006057 |
	| 1000006058 |
	| 1000006059 |
	| 1000006060 |
	| 1000006061 |
	| 1000006062 |
	| 1000006063 |
	| 1000006064 |
	| 1000006065 |
	| 1000006066 |
	| 1000006067 |
	| 1000006068 |
	| 1000006069 |
	| 1000006070 |
	| 1000006071 |
	| 1000006072 |
	| 1000006073 |
	| 1000006074 |
	| 1000006075 |
	| 1000006076 |
	| 1000006077 |
	| 1000006078 |
	| 1000006079 |
	| 1000006080 |
	| 1000006081 |
	| 1000006082 |
	| 1000006083 |
	| 1000006084 |
	| 1000006085 |
	| 1000006086 |
	| 1000006087 |
	| 1000006088 |
	| 1000006089 |
	| 1000006090 |
	| 1000006091 |
	| 1000006092 |
	| 1000006093 |
	| 1000006094 |
	| 1000006095 |
	| 1000006096 |
	| 1000006097 |
	| 1000006098 |
	| 1000006099 |
	| 1000006100 |
	| 1000006101 |
	| 1000006102 |
	| 1000006103 |
	| 1000006104 |
	| 1000006105 |
	| 1000006106 |
	| 1000006107 |
	| 1000006108 |
	| 1000006109 |
	| 1000006110 |
	| 1000006111 |
	| 1000006112 |
	| 1000006113 |
	| 1000006114 |
	| 1000006115 |
	| 1000006116 |
	| 1000006117 |
	| 1000006118 |
	| 1000006119 |
	| 1000006120 |
	| 1000006121 |
	| 1000006122 |
	| 1000006123 |
	| 1000006124 |
	| 1000006125 |
	| 1000006126 |
	| 1000006127 |
	| 1000006128 |
	| 1000006129 |
	| 1000006130 |
	| 1000006131 |
	| 1000006132 |
	| 1000006133 |
	| 1000006134 |
	| 1000006135 |
	| 1000006136 |
	| 1000006137 |
	| 1000006138 |
	| 1000006139 |
	| 1000006140 |
	| 1000006141 |
	| 1000006142 |
	| 1000006143 |
	| 1000006144 |
	| 1000006145 |
	| 1000006146 |
	| 1000006147 |
	| 1000006148 |
	| 1000006149 |
	| 1000006150 |
	| 1000006151 |
	| 1000006152 |
	| 1000006153 |
	| 1000006154 |
	| 1000006155 |
	| 1000006156 |
	| 1000006157 |
	| 1000006158 |
	| 1000006159 |
	| 1000006160 |
	| 1000006161 |
	| 1000006162 |
	| 1000006163 |
	| 1000006164 |
	| 1000006165 |
	| 1000006166 |
	| 1000006167 |
	| 1000006168 |
	| 1000006169 |
	| 1000006170 |
	| 1000006171 |
	| 1000006172 |
	| 1000006173 |
	| 1000006174 |
	| 1000006175 |
	| 1000006176 |
	| 1000006177 |
	| 1000006178 |
	| 1000006179 |
	| 1000006180 |
	| 1000006181 |
	| 1000006182 |
	| 1000006183 |
	| 1000006184 |
	| 1000006185 |
	| 1000006186 |
	| 1000006187 |
	| 1000006188 |
	| 1000006189 |
	| 1000006190 |
	| 1000006191 |
	| 1000006192 |
	| 1000006193 |
	| 1000006194 |
	| 1000006195 |
	| 1000006196 |
	| 1000006197 |
	| 1000006198 |
	| 1000006199 |
	| 1000006200 |
	| 1000006201 |
	| 1000006202 |
	| 1000006203 |
	| 1000006204 |
	| 1000006205 |
	| 1000006206 |
	| 1000006207 |
	| 1000006208 |
	| 1000006209 |
	| 1000006210 |
	| 1000006211 |
	| 1000006212 |
	| 1000006213 |
	| 1000006214 |
	| 1000006215 |
	| 1000006216 |
	| 1000006217 |
	| 1000006218 |
	| 1000006219 |
	| 1000006220 |
	| 1000006221 |
	| 1000006222 |
	| 1000006223 |
	| 1000006224 |
	| 1000006225 |
	| 1000006226 |
	| 1000006227 |
	| 1000006228 |
	| 1000006229 |
	| 1000006230 |
	| 1000006231 |
	| 1000006232 |
	| 1000006233 |
	| 1000006234 |
	| 1000006235 |
	| 1000006236 |
	| 1000006237 |
	| 1000006238 |
	| 1000006239 |
	| 1000006240 |
	| 1000006241 |
	| 1000006242 |
	| 1000006243 |
	| 1000006244 |
	| 1000006245 |
	| 1000006246 |
	| 1000006247 |
	| 1000006248 |
	| 1000006249 |
	| 1000006250 |
	| 1000006251 |
	| 1000006252 |
	| 1000006253 |
	| 1000006254 |
	| 1000006255 |
	| 1000006256 |
	| 1000006257 |
	| 1000006258 |
	| 1000006259 |
	| 1000006260 |
	| 1000006261 |
	| 1000006262 |
	| 1000006263 |
	| 1000006264 |
	| 1000006265 |
	| 1000006266 |
	| 1000006267 |
	| 1000006268 |
	| 1000006269 |
	| 1000006270 |
	| 1000006271 |
	| 1000006272 |
	| 1000006273 |
	| 1000006274 |
	| 1000006275 |
	| 1000006276 |
	| 1000006277 |
	| 1000006278 |
	| 1000006279 |
	| 1000006280 |
	| 1000006281 |
	| 1000006282 |
	| 1000006283 |
	| 1000006284 |
	| 1000006285 |
	| 1000006286 |
	| 1000006287 |
	| 1000006288 |
	| 1000006289 |
	| 1000006290 |
	| 1000006291 |
	| 1000006292 |
	| 1000006293 |
	| 1000006294 |
	| 1000006295 |
	| 1000006296 |
	| 1000006297 |
	| 1000006298 |
	| 1000006299 |
	| 1000006300 |
	| 1000006301 |
	| 1000006302 |
	| 1000006303 |
	| 1000006304 |
	| 1000006305 |
	| 1000006306 |
	| 1000006307 |
	| 1000006308 |
	| 1000006309 |
	| 1000006310 |
	| 1000006311 |
	| 1000006312 |
	| 1000006313 |
	| 1000006314 |
	| 1000006315 |
	| 1000006316 |
	| 1000006317 |
	| 1000006318 |
	| 1000006319 |
	| 1000006320 |
	| 1000006321 |
	| 1000006322 |
	| 1000006323 |
	| 1000006324 |
	| 1000006325 |
	| 1000006326 |
	| 1000006327 |
	| 1000006328 |
	| 1000006329 |
	| 1000006330 |
	| 1000006331 |
	| 1000006332 |
	| 1000006333 |
	| 1000006334 |
	| 1000006335 |
	| 1000006336 |
	| 1000006337 |
	| 1000006338 |
	| 1000006339 |
	| 1000006340 |
	| 1000006341 |
	| 1000006342 |
	| 1000006343 |
	| 1000006344 |
	| 1000006345 |
	| 1000006346 |
	| 1000006347 |
	| 1000006348 |
	| 1000006349 |
	| 1000006350 |
	| 1000006351 |
	| 1000006352 |
	| 1000006353 |
	| 1000006354 |
	| 1000006355 |
	| 1000006356 |
	| 1000006357 |
	| 1000006358 |
	| 1000006359 |
	| 1000006360 |
	| 1000006361 |
	| 1000006362 |
	| 1000006363 |
	| 1000006364 |
	| 1000006365 |
	| 1000006366 |
	| 1000006367 |
	| 1000006368 |
	| 1000006369 |
	| 1000006370 |
	| 1000006371 |
	| 1000006372 |
	| 1000006373 |
	| 1000006374 |
	| 1000006375 |
	| 1000006376 |
	| 1000006377 |
	| 1000006378 |
	| 1000006379 |
	| 1000006380 |
	| 1000006381 |
	| 1000006382 |
	| 1000006383 |
	| 1000006384 |
	| 1000006385 |
	| 1000006386 |
	| 1000006387 |
	| 1000006388 |
	| 1000006389 |
	| 1000006390 |
	| 1000006391 |
	| 1000006392 |
	| 1000006393 |
	| 1000006394 |
	| 1000006395 |
	| 1000006396 |
	| 1000006397 |
	| 1000006398 |
	| 1000006399 |
	| 1000006400 |
	| 1000006401 |
	| 1000006402 |
	| 1000006403 |
	| 1000006404 |
	| 1000006405 |
	| 1000006406 |
	| 1000006407 |
	| 1000006408 |
	| 1000006409 |
	| 1000006410 |
	| 1000006411 |
	| 1000006412 |
	| 1000006413 |
	| 1000006414 |
	| 1000006415 |
	| 1000006416 |
	| 1000006417 |
	| 1000006418 |
	| 1000006419 |
	| 1000006420 |
	| 1000006421 |
	| 1000006422 |
	| 1000006423 |
	| 1000006424 |
	| 1000006425 |
	| 1000006426 |
	| 1000006427 |
	| 1000006428 |
	| 1000006429 |
	| 1000006430 |
	| 1000006431 |
	| 1000006432 |
	| 1000006433 |
	| 1000006434 |
	| 1000006435 |
	| 1000006436 |
	| 1000006437 |
	| 1000006438 |
	| 1000006439 |
	| 1000006440 |
	| 1000006441 |
	| 1000006442 |
	| 1000006443 |
	| 1000006444 |
	| 1000006445 |
	| 1000006446 |
	| 1000006447 |
	| 1000006448 |
	| 1000006449 |
	| 1000006450 |
	| 1000006451 |
	| 1000006452 |
	| 1000006453 |
	| 1000006454 |
	| 1000006455 |
	| 1000006456 |
	| 1000006457 |
	| 1000006458 |
	| 1000006459 |
	| 1000006460 |
	| 1000006461 |
	| 1000006462 |
	| 1000006463 |
	| 1000006464 |
	| 1000006465 |
	| 1000006466 |
	| 1000006467 |
	| 1000006468 |
	| 1000006469 |
	| 1000006470 |
	| 1000006471 |
	| 1000006472 |
	| 1000006473 |
	| 1000006474 |
	| 1000006475 |
	| 1000006476 |
	| 1000006477 |
	| 1000006478 |
	| 1000006479 |
	| 1000006480 |
	| 1000006481 |
	| 1000006482 |
	| 1000006483 |
	| 1000006484 |
	| 1000006485 |
	| 1000006486 |
	| 1000006487 |
	| 1000006488 |
	| 1000006489 |
	| 1000006490 |
	| 1000006491 |
	| 1000006492 |
	| 1000006493 |
	| 1000006494 |
	| 1000006495 |
	| 1000006496 |
	| 1000006497 |
	| 1000006498 |
	| 1000006499 |
	| 1000006500 |
	| 1000006501 |
	| 1000006502 |
	| 1000006503 |
	| 1000006504 |
	| 1000006505 |
	| 1000006506 |
	| 1000006507 |
	| 1000006508 |
	| 1000006509 |
	| 1000006510 |
	| 1000006511 |
	| 1000006512 |
	| 1000006513 |
	| 1000006514 |
	| 1000006515 |
	| 1000006516 |
	| 1000006517 |
	| 1000006518 |
	| 1000006519 |
	| 1000006520 |
	| 1000006521 |
	| 1000006522 |
	| 1000006523 |
	| 1000006524 |
	| 1000006525 |
	| 1000006526 |
	| 1000006527 |
	| 1000006528 |
	| 1000006529 |
	| 1000006530 |
	| 1000006531 |
	| 1000006532 |
	| 1000006533 |
	| 1000006534 |
	| 1000006535 |
	| 1000006536 |
	| 1000006537 |
	| 1000006538 |
	| 1000006539 |
	| 1000006540 |
	| 1000006541 |
	| 1000006542 |
	| 1000006543 |
	| 1000006544 |
	| 1000006545 |
	| 1000006546 |
	| 1000006547 |
	| 1000006548 |
	| 1000006549 |
	| 1000006550 |
	| 1000006551 |
	| 1000006552 |
	| 1000006553 |
	| 1000006554 |
	| 1000006555 |
	| 1000006556 |
	| 1000006557 |
	| 1000006558 |
	| 1000006559 |
	| 1000006560 |
	| 1000006561 |
	| 1000006562 |
	| 1000006563 |
	| 1000006564 |
	| 1000006565 |
	| 1000006566 |
	| 1000006567 |
	| 1000006568 |
	| 1000006569 |
	| 1000006570 |
	| 1000006571 |
	| 1000006572 |
	| 1000006573 |
	| 1000006574 |
	| 1000006575 |
	| 1000006576 |
	| 1000006577 |
	| 1000006578 |
	| 1000006579 |
	| 1000006580 |
	| 1000006581 |
	| 1000006582 |
	| 1000006583 |
	| 1000006584 |
	| 1000006585 |
	| 1000006586 |
	| 1000006587 |
	| 1000006588 |
	| 1000006589 |
	| 1000006590 |
	| 1000006591 |
	| 1000006592 |
	| 1000006593 |
	| 1000006594 |
	| 1000006595 |
	| 1000006596 |
	| 1000006597 |
	| 1000006598 |
	| 1000006599 |
	| 1000006600 |
	| 1000006601 |
	| 1000006602 |
	| 1000006603 |
	| 1000006604 |
	| 1000006605 |
	| 1000006606 |
	| 1000006607 |
	| 1000006608 |
	| 1000006609 |
	| 1000006610 |
	| 1000006611 |
	| 1000006612 |
	| 1000006613 |
	| 1000006614 |
	| 1000006615 |
	| 1000006616 |
	| 1000006617 |
	| 1000006618 |
	| 1000006619 |
	| 1000006620 |
	| 1000006621 |
	| 1000006622 |
	| 1000006623 |
	| 1000006624 |
	| 1000006625 |
	| 1000006626 |
	| 1000006627 |
	| 1000006628 |
	| 1000006629 |
	| 1000006630 |
	| 1000006631 |
	| 1000006632 |
	| 1000006633 |
	| 1000006634 |
	| 1000006635 |
	| 1000006636 |
	| 1000006637 |
	| 1000006638 |
	| 1000006639 |
	| 1000006640 |
	| 1000006641 |
	| 1000006642 |
	| 1000006643 |
	| 1000006644 |
	| 1000006645 |
	| 1000006646 |
	| 1000006647 |
	| 1000006648 |
	| 1000006649 |
	| 1000006650 |
	| 1000006651 |
	| 1000006652 |
	| 1000006653 |
	| 1000006654 |
	| 1000006655 |
	| 1000006656 |
	| 1000006657 |
	| 1000006658 |
	| 1000006659 |
	| 1000006660 |
	| 1000006661 |
	| 1000006662 |
	| 1000006663 |
	| 1000006664 |
	| 1000006665 |
	| 1000006666 |
	| 1000006667 |
	| 1000006668 |
	| 1000006669 |
	| 1000006670 |
	| 1000006671 |
	| 1000006672 |
	| 1000006673 |
	| 1000006674 |
	| 1000006675 |
	| 1000006676 |
	| 1000006677 |
	| 1000006678 |
	| 1000006679 |
	| 1000006680 |
	| 1000006681 |
	| 1000006682 |
	| 1000006683 |
	| 1000006684 |
	| 1000006685 |
	| 1000006686 |
	| 1000006687 |
	| 1000006688 |
	| 1000006689 |
	| 1000006690 |
	| 1000006691 |
	| 1000006692 |
	| 1000006693 |
	| 1000006694 |
	| 1000006695 |
	| 1000006696 |
	| 1000006697 |
	| 1000006698 |
	| 1000006699 |
	| 1000006700 |
	| 1000006701 |
	| 1000006702 |
	| 1000006703 |
	| 1000006704 |
	| 1000006705 |
	| 1000006706 |
	| 1000006707 |
	| 1000006708 |
	| 1000006709 |
	| 1000006710 |
	| 1000006711 |
	| 1000006712 |
	| 1000006713 |
	| 1000006714 |
	| 1000006715 |
	| 1000006716 |
	| 1000006717 |
	| 1000006718 |
	| 1000006719 |
	| 1000006720 |
	| 1000006721 |
	| 1000006722 |
	| 1000006723 |
	| 1000006724 |
	| 1000006725 |
	| 1000006726 |
	| 1000006727 |
	| 1000006728 |
	| 1000006729 |
	| 1000006730 |
	| 1000006731 |
	| 1000006732 |
	| 1000006733 |
	| 1000006734 |
	| 1000006735 |
	| 1000006736 |
	| 1000006737 |
	| 1000006738 |
	| 1000006739 |
	| 1000006740 |
	| 1000006741 |
	| 1000006742 |
	| 1000006743 |
	| 1000006744 |
	| 1000006745 |
	| 1000006746 |
	| 1000006747 |
	| 1000006748 |
	| 1000006749 |
	| 1000006750 |
	| 1000006751 |
	| 1000006752 |
	| 1000006753 |
	| 1000006754 |
	| 1000006755 |
	| 1000006756 |
	| 1000006757 |
	| 1000006758 |
	| 1000006759 |
	| 1000006760 |
	| 1000006761 |
	| 1000006762 |
	| 1000006763 |
	| 1000006764 |
	| 1000006765 |
	| 1000006766 |
	| 1000006767 |
	| 1000006768 |
	| 1000006769 |
	| 1000006770 |
	| 1000006771 |
	| 1000006772 |
	| 1000006773 |
	| 1000006774 |
	| 1000006775 |
	| 1000006776 |
	| 1000006777 |
	| 1000006778 |
	| 1000006779 |
	| 1000006780 |
	| 1000006781 |
	| 1000006782 |
	| 1000006783 |
	| 1000006784 |
	| 1000006785 |
	| 1000006786 |
	| 1000006787 |
	| 1000006788 |
	| 1000006789 |
	| 1000006790 |
	| 1000006791 |
	| 1000006792 |
	| 1000006793 |
	| 1000006794 |
	| 1000006795 |
	| 1000006796 |
	| 1000006797 |
	| 1000006798 |
	| 1000006799 |
	| 1000006800 |
	| 1000006801 |
	| 1000006802 |
	| 1000006803 |
	| 1000006804 |
	| 1000006805 |
	| 1000006806 |
	| 1000006807 |
	| 1000006808 |
	| 1000006809 |
	| 1000006810 |
	| 1000006811 |
	| 1000006812 |
	| 1000006813 |
	| 1000006814 |
	| 1000006815 |
	| 1000006816 |
	| 1000006817 |
	| 1000006818 |
	| 1000006819 |
	| 1000006820 |
	| 1000006821 |
	| 1000006822 |
	| 1000006823 |
	| 1000006824 |
	| 1000006825 |
	| 1000006826 |
	| 1000006827 |
	| 1000006828 |
	| 1000006829 |
	| 1000006830 |
	| 1000006831 |
	| 1000006832 |
	| 1000006833 |
	| 1000006834 |
	| 1000006835 |
	| 1000006836 |
	| 1000006837 |
	| 1000006838 |
	| 1000006839 |
	| 1000006840 |
	| 1000006841 |
	| 1000006842 |
	| 1000006843 |
	| 1000006844 |
	| 1000006845 |
	| 1000006846 |
	| 1000006847 |
	| 1000006848 |
	| 1000006849 |
	| 1000006850 |
	| 1000006851 |
	| 1000006852 |
	| 1000006853 |
	| 1000006854 |
	| 1000006855 |
	| 1000006856 |
	| 1000006857 |
	| 1000006858 |
	| 1000006859 |
	| 1000006860 |
	| 1000006861 |
	| 1000006862 |
	| 1000006863 |
	| 1000006864 |
	| 1000006865 |
	| 1000006866 |
	| 1000006867 |
	| 1000006868 |
	| 1000006869 |
	| 1000006870 |
	| 1000006871 |
	| 1000006872 |
	| 1000006873 |
	| 1000006874 |
	| 1000006875 |
	| 1000006876 |
	| 1000006877 |
	| 1000006878 |
	| 1000006879 |
	| 1000006880 |
	| 1000006881 |
	| 1000006882 |
	| 1000006883 |
	| 1000006884 |
	| 1000006885 |
	| 1000006886 |
	| 1000006887 |
	| 1000006888 |
	| 1000006889 |
	| 1000006890 |
	| 1000006891 |
	| 1000006892 |
	| 1000006893 |
	| 1000006894 |
	| 1000006895 |
	| 1000006896 |
	| 1000006897 |
	| 1000006898 |
	| 1000006899 |
	| 1000006900 |
	| 1000006901 |
	| 1000006902 |
	| 1000006903 |
	| 1000006904 |
	| 1000006905 |
	| 1000006906 |
	| 1000006907 |
	| 1000006908 |
	| 1000006909 |
	| 1000006910 |
	| 1000006911 |
	| 1000006912 |
	| 1000006913 |
	| 1000006914 |
	| 1000006915 |
	| 1000006916 |
	| 1000006917 |
	| 1000006918 |
	| 1000006919 |
	| 1000006920 |
	| 1000006921 |
	| 1000006922 |
	| 1000006923 |
	| 1000006924 |
	| 1000006925 |
	| 1000006926 |
	| 1000006927 |
	| 1000006928 |
	| 1000006929 |
	| 1000006930 |
	| 1000006931 |
	| 1000006932 |
	| 1000006933 |
	| 1000006934 |
	| 1000006935 |
	| 1000006936 |
	| 1000006937 |
	| 1000006938 |
	| 1000006939 |
	| 1000006940 |
	| 1000006941 |
	| 1000006942 |
	| 1000006943 |
	| 1000006944 |
	| 1000006945 |
	| 1000006946 |
	| 1000006947 |
	| 1000006948 |
	| 1000006949 |
	| 1000006950 |
	| 1000006951 |
	| 1000006952 |
	| 1000006953 |
	| 1000006954 |
	| 1000006955 |
	| 1000006956 |
	| 1000006957 |
	| 1000006958 |
	| 1000006959 |
	| 1000006960 |
	| 1000006961 |
	| 1000006962 |
	| 1000006963 |
	| 1000006964 |
	| 1000006965 |
	| 1000006966 |
	| 1000006967 |
	| 1000006968 |
	| 1000006969 |
	| 1000006970 |
	| 1000006971 |
	| 1000006972 |
	| 1000006973 |
	| 1000006974 |
	| 1000006975 |
	| 1000006976 |
	| 1000006977 |
	| 1000006978 |
	| 1000006979 |
	| 1000006980 |
	| 1000006981 |
	| 1000006982 |
	| 1000006983 |
	| 1000006984 |
	| 1000006985 |
	| 1000006986 |
	| 1000006987 |
	| 1000006988 |
	| 1000006989 |
	| 1000006990 |
	| 1000006991 |
	| 1000006992 |
	| 1000006993 |
	| 1000006994 |
	| 1000006995 |
	| 1000006996 |
	| 1000006997 |
	| 1000006998 |
	| 1000006999 |
	| 1000007000 |
	| 1000007001 |
	| 1000007002 |
	| 1000007003 |
	| 1000007004 |
	| 1000007005 |
	| 1000007006 |
	| 1000007007 |
	| 1000007008 |
	| 1000007009 |
	| 1000007010 |
	| 1000007011 |
	| 1000007012 |
	| 1000007013 |
	| 1000007014 |
	| 1000007015 |
	| 1000007016 |
	| 1000007017 |
	| 1000007018 |
	| 1000007019 |
	| 1000007020 |
	| 1000007021 |
	| 1000007022 |
	| 1000007023 |
	| 1000007024 |
	| 1000007025 |
	| 1000007026 |
	| 1000007027 |
	| 1000007028 |
	| 1000007029 |
	| 1000007030 |
	| 1000007031 |
	| 1000007032 |
	| 1000007033 |
	| 1000007034 |
	| 1000007035 |
	| 1000007036 |
	| 1000007037 |
	| 1000007038 |
	| 1000007039 |
	| 1000007040 |
	| 1000007041 |
	| 1000007042 |
	| 1000007043 |
	| 1000007044 |
	| 1000007045 |
	| 1000007046 |
	| 1000007047 |
	| 1000007048 |
	| 1000007049 |
	| 1000007050 |
	| 1000007051 |
	| 1000007052 |
	| 1000007053 |
	| 1000007054 |
	| 1000007055 |
	| 1000007056 |
	| 1000007057 |
	| 1000007058 |
	| 1000007059 |
	| 1000007060 |
	| 1000007061 |
	| 1000007062 |
	| 1000007063 |
	| 1000007064 |
	| 1000007065 |
	| 1000007066 |
	| 1000007067 |
	| 1000007068 |
	| 1000007069 |
	| 1000007070 |
	| 1000007071 |
	| 1000007072 |
	| 1000007073 |
	| 1000007074 |
	| 1000007075 |
	| 1000007076 |
	| 1000007077 |
	| 1000007078 |
	| 1000007079 |
	| 1000007080 |
	| 1000007081 |
	| 1000007082 |
	| 1000007083 |
	| 1000007084 |
	| 1000007085 |
	| 1000007086 |
	| 1000007087 |
	| 1000007088 |
	| 1000007089 |
	| 1000007090 |
	| 1000007091 |
	| 1000007092 |
	| 1000007093 |
	| 1000007094 |
	| 1000007095 |
	| 1000007096 |
	| 1000007097 |
	| 1000007098 |
	| 1000007099 |
	| 1000007100 |
	| 1000007101 |
	| 1000007102 |
	| 1000007103 |
	| 1000007104 |
	| 1000007105 |
	| 1000007106 |
	| 1000007107 |
	| 1000007108 |
	| 1000007109 |
	| 1000007110 |
	| 1000007111 |
	| 1000007112 |
	| 1000007113 |
	| 1000007114 |
	| 1000007115 |
	| 1000007116 |
	| 1000007117 |
	| 1000007118 |
	| 1000007119 |
	| 1000007120 |
	| 1000007121 |
	| 1000007122 |
	| 1000007123 |
	| 1000007124 |
	| 1000007125 |
	| 1000007126 |
	| 1000007127 |
	| 1000007128 |
	| 1000007129 |
	| 1000007130 |
	| 1000007131 |
	| 1000007132 |
	| 1000007133 |
	| 1000007134 |
	| 1000007135 |
	| 1000007136 |
	| 1000007137 |
	| 1000007138 |
	| 1000007139 |
	| 1000007140 |
	| 1000007141 |
	| 1000007142 |
	| 1000007143 |
	| 1000007144 |
	| 1000007145 |
	| 1000007146 |
	| 1000007147 |
	| 1000007148 |
	| 1000007149 |
	| 1000007150 |
	| 1000007151 |
	| 1000007152 |
	| 1000007153 |
	| 1000007154 |
	| 1000007155 |
	| 1000007156 |
	| 1000007157 |
	| 1000007158 |
	| 1000007159 |
	| 1000007160 |
	| 1000007161 |
	| 1000007162 |
	| 1000007163 |
	| 1000007164 |
	| 1000007165 |
	| 1000007166 |
	| 1000007167 |
	| 1000007168 |
	| 1000007169 |
	| 1000007170 |
	| 1000007171 |
	| 1000007172 |
	| 1000007173 |
	| 1000007174 |
	| 1000007175 |
	| 1000007176 |
	| 1000007177 |
	| 1000007178 |
	| 1000007179 |
	| 1000007180 |
	| 1000007181 |
	| 1000007182 |
	| 1000007183 |
	| 1000007184 |
	| 1000007185 |
	| 1000007186 |
	| 1000007187 |
	| 1000007188 |
	| 1000007189 |
	| 1000007190 |
	| 1000007191 |
	| 1000007192 |
	| 1000007193 |
	| 1000007194 |
	| 1000007195 |
	| 1000007196 |
	| 1000007197 |
	| 1000007198 |
	| 1000007199 |
	| 1000007200 |
	| 1000007201 |
	| 1000007202 |
	| 1000007203 |
	| 1000007204 |
	| 1000007205 |
	| 1000007206 |
	| 1000007207 |
	| 1000007208 |
	| 1000007209 |
	| 1000007210 |
	| 1000007211 |
	| 1000007212 |
	| 1000007213 |
	| 1000007214 |
	| 1000007215 |
	| 1000007216 |
	| 1000007217 |
	| 1000007218 |
	| 1000007219 |
	| 1000007220 |
	| 1000007221 |
	| 1000007222 |
	| 1000007223 |
	| 1000007224 |
	| 1000007225 |
	| 1000007226 |
	| 1000007227 |
	| 1000007228 |
	| 1000007229 |
	| 1000007230 |
	| 1000007231 |
	| 1000007232 |
	| 1000007233 |
	| 1000007234 |
	| 1000007235 |
	| 1000007236 |
	| 1000007237 |
	| 1000007238 |
	| 1000007239 |
	| 1000007240 |
	| 1000007241 |
	| 1000007242 |
	| 1000007243 |
	| 1000007244 |
	| 1000007245 |
	| 1000007246 |
	| 1000007247 |
	| 1000007248 |
	| 1000007249 |
	| 1000007250 |
	| 1000007251 |
	| 1000007252 |
	| 1000007253 |
	| 1000007254 |
	| 1000007255 |
	| 1000007256 |
	| 1000007257 |
	| 1000007258 |
	| 1000007259 |
	| 1000007260 |
	| 1000007261 |
	| 1000007262 |
	| 1000007263 |
	| 1000007264 |
	| 1000007265 |
	| 1000007266 |
	| 1000007267 |
	| 1000007268 |
	| 1000007269 |
	| 1000007270 |
	| 1000007271 |
	| 1000007272 |
	| 1000007273 |
	| 1000007274 |
	| 1000007275 |
	| 1000007276 |
	| 1000007277 |
	| 1000007278 |
	| 1000007279 |
	| 1000007280 |
	| 1000007281 |
	| 1000007282 |
	| 1000007283 |
	| 1000007284 |
	| 1000007285 |
	| 1000007286 |
	| 1000007287 |
	| 1000007288 |
	| 1000007289 |
	| 1000007290 |
	| 1000007291 |
	| 1000007292 |
	| 1000007293 |
	| 1000007294 |
	| 1000007295 |
	| 1000007296 |
	| 1000007297 |
	| 1000007298 |
	| 1000007299 |
	| 1000007300 |
	| 1000007301 |
	| 1000007302 |
	| 1000007303 |
	| 1000007304 |
	| 1000007305 |
	| 1000007306 |
	| 1000007307 |
	| 1000007308 |
	| 1000007309 |
	| 1000007310 |
	| 1000007311 |
	| 1000007312 |
	| 1000007313 |
	| 1000007314 |
	| 1000007315 |
	| 1000007316 |
	| 1000007317 |
	| 1000007318 |
	| 1000007319 |
	| 1000007320 |
	| 1000007321 |
	| 1000007322 |
	| 1000007323 |
	| 1000007324 |
	| 1000007325 |
	| 1000007326 |
	| 1000007327 |
	| 1000007328 |
	| 1000007329 |
	| 1000007330 |
	| 1000007331 |
	| 1000007332 |
	| 1000007333 |
	| 1000007334 |
	| 1000007335 |
	| 1000007336 |
	| 1000007337 |
	| 1000007338 |
	| 1000007339 |
	| 1000007340 |
	| 1000007341 |
	| 1000007342 |
	| 1000007343 |
	| 1000007344 |
	| 1000007345 |
	| 1000007346 |
	| 1000007347 |
	| 1000007348 |
	| 1000007349 |
	| 1000007350 |
	| 1000007351 |
	| 1000007352 |
	| 1000007353 |
	| 1000007354 |
	| 1000007355 |
	| 1000007356 |
	| 1000007357 |
	| 1000007358 |
	| 1000007359 |
	| 1000007360 |
	| 1000007361 |
	| 1000007362 |
	| 1000007363 |
	| 1000007364 |
	| 1000007365 |
	| 1000007366 |
	| 1000007367 |
	| 1000007368 |
	| 1000007369 |
	| 1000007370 |
	| 1000007371 |
	| 1000007372 |
	| 1000007373 |
	| 1000007374 |
	| 1000007375 |
	| 1000007376 |
	| 1000007377 |
	| 1000007378 |
	| 1000007379 |
	| 1000007380 |
	| 1000007381 |
	| 1000007382 |
	| 1000007383 |
	| 1000007384 |
	| 1000007385 |
	| 1000007386 |
	| 1000007387 |
	| 1000007388 |
	| 1000007389 |
	| 1000007390 |
	| 1000007391 |
	| 1000007392 |
	| 1000007393 |
	| 1000007394 |
	| 1000007395 |
	| 1000007396 |
	| 1000007397 |
	| 1000007398 |
	| 1000007399 |
	| 1000007400 |
	| 1000007401 |
	| 1000007402 |
	| 1000007403 |
	| 1000007404 |
	| 1000007405 |
	| 1000007406 |
	| 1000007407 |
	| 1000007408 |
	| 1000007409 |
	| 1000007410 |
	| 1000007411 |
	| 1000007412 |
	| 1000007413 |
	| 1000007414 |
	| 1000007415 |
	| 1000007416 |
	| 1000007417 |
	| 1000007418 |
	| 1000007419 |
	| 1000007420 |
	| 1000007421 |
	| 1000007422 |
	| 1000007423 |
	| 1000007424 |
	| 1000007425 |
	| 1000007426 |
	| 1000007427 |
	| 1000007428 |
	| 1000007429 |
	| 1000007430 |
	| 1000007431 |
	| 1000007432 |
	| 1000007433 |
	| 1000007434 |
	| 1000007435 |
	| 1000007436 |
	| 1000007437 |
	| 1000007438 |
	| 1000007439 |
	| 1000007440 |
	| 1000007441 |
	| 1000007442 |
	| 1000007443 |
	| 1000007444 |
	| 1000007445 |
	| 1000007446 |
	| 1000007447 |
	| 1000007448 |
	| 1000007449 |
	| 1000007450 |
	| 1000007451 |
	| 1000007452 |
	| 1000007453 |
	| 1000007454 |
	| 1000007455 |
	| 1000007456 |
	| 1000007457 |
	| 1000007458 |
	| 1000007459 |
	| 1000007460 |
	| 1000007461 |
	| 1000007462 |
	| 1000007463 |
	| 1000007464 |
	| 1000007465 |
	| 1000007466 |
	| 1000007467 |
	| 1000007468 |
	| 1000007469 |
	| 1000007470 |
	| 1000007471 |
	| 1000007472 |
	| 1000007473 |
	| 1000007474 |
	| 1000007475 |
	| 1000007476 |
	| 1000007477 |
	| 1000007478 |
	| 1000007479 |
	| 1000007480 |
	| 1000007481 |
	| 1000007482 |
	| 1000007483 |
	| 1000007484 |
	| 1000007485 |
	| 1000007486 |
	| 1000007487 |
	| 1000007488 |
	| 1000007489 |
	| 1000007490 |
	| 1000007491 |
	| 1000007492 |
	| 1000007493 |
	| 1000007494 |
	| 1000007495 |
	| 1000007496 |
	| 1000007497 |
	| 1000007498 |
	| 1000007499 |
	| 1000007500 |
	| 1000007501 |
	| 1000007502 |
	| 1000007503 |
	| 1000007504 |
	| 1000007505 |
	| 1000007506 |
	| 1000007507 |
	| 1000007508 |
	| 1000007509 |
	| 1000007510 |
	| 1000007511 |
	| 1000007512 |
	| 1000007513 |
	| 1000007514 |
	| 1000007515 |
	| 1000007516 |
	| 1000007517 |
	| 1000007518 |
	| 1000007519 |
	| 1000007520 |
	| 1000007521 |
	| 1000007522 |
	| 1000007523 |
	| 1000007524 |
	| 1000007525 |
	| 1000007526 |
	| 1000007527 |
	| 1000007528 |
	| 1000007529 |
	| 1000007530 |
	| 1000007531 |
	| 1000007532 |
	| 1000007533 |
	| 1000007534 |
	| 1000007535 |
	| 1000007536 |
	| 1000007537 |
	| 1000007538 |
	| 1000007539 |
	| 1000007540 |
	| 1000007541 |
	| 1000007542 |
	| 1000007543 |
	| 1000007544 |
	| 1000007545 |
	| 1000007546 |
	| 1000007547 |
	| 1000007548 |
	| 1000007549 |
	| 1000007550 |
	| 1000007551 |
	| 1000007552 |
	| 1000007553 |
	| 1000007554 |
	| 1000007555 |
	| 1000007556 |
	| 1000007557 |
	| 1000007558 |
	| 1000007559 |
	| 1000007560 |
	| 1000007561 |
	| 1000007562 |
	| 1000007563 |
	| 1000007564 |
	| 1000007565 |
	| 1000007566 |
	| 1000007567 |
	| 1000007568 |
	| 1000007569 |
	| 1000007570 |
	| 1000007571 |
	| 1000007572 |
	| 1000007573 |
	| 1000007574 |
	| 1000007575 |
	| 1000007576 |
	| 1000007577 |
	| 1000007578 |
	| 1000007579 |
	| 1000007580 |
	| 1000007581 |
	| 1000007582 |
	| 1000007583 |
	| 1000007584 |
	| 1000007585 |
	| 1000007586 |
	| 1000007587 |
	| 1000007588 |
	| 1000007589 |
	| 1000007590 |
	| 1000007591 |
	| 1000007592 |
	| 1000007593 |
	| 1000007594 |
	| 1000007595 |
	| 1000007596 |
	| 1000007597 |
	| 1000007598 |
	| 1000007599 |
	| 1000007600 |
	| 1000007601 |
	| 1000007602 |
	| 1000007603 |
	| 1000007604 |
	| 1000007605 |
	| 1000007606 |
	| 1000007607 |
	| 1000007608 |
	| 1000007609 |
	| 1000007610 |
	| 1000007611 |
	| 1000007612 |
	| 1000007613 |
	| 1000007614 |
	| 1000007615 |
	| 1000007616 |
	| 1000007617 |
	| 1000007618 |
	| 1000007619 |
	| 1000007620 |
	| 1000007621 |
	| 1000007622 |
	| 1000007623 |
	| 1000007624 |
	| 1000007625 |
	| 1000007626 |
	| 1000007627 |
	| 1000007628 |
	| 1000007629 |
	| 1000007630 |
	| 1000007631 |
	| 1000007632 |
	| 1000007633 |
	| 1000007634 |
	| 1000007635 |
	| 1000007636 |
	| 1000007637 |
	| 1000007638 |
	| 1000007639 |
	| 1000007640 |
	| 1000007641 |
	| 1000007642 |
	| 1000007643 |
	| 1000007644 |
	| 1000007645 |
	| 1000007646 |
	| 1000007647 |
	| 1000007648 |
	| 1000007649 |
	| 1000007650 |
	| 1000007651 |
	| 1000007652 |
	| 1000007653 |
	| 1000007654 |
	| 1000007655 |
	| 1000007656 |
	| 1000007657 |
	| 1000007658 |
	| 1000007659 |
	| 1000007660 |
	| 1000007661 |
	| 1000007662 |
	| 1000007663 |
	| 1000007664 |
	| 1000007665 |
	| 1000007666 |
	| 1000007667 |
	| 1000007668 |
	| 1000007669 |
	| 1000007670 |
	| 1000007671 |
	| 1000007672 |
	| 1000007673 |
	| 1000007674 |
	| 1000007675 |
	| 1000007676 |
	| 1000007677 |
	| 1000007678 |
	| 1000007679 |
	| 1000007680 |
	| 1000007681 |
	| 1000007682 |
	| 1000007683 |
	| 1000007684 |
	| 1000007685 |
	| 1000007686 |
	| 1000007687 |
	| 1000007688 |
	| 1000007689 |
	| 1000007690 |
	| 1000007691 |
	| 1000007692 |
	| 1000007693 |
	| 1000007694 |
	| 1000007695 |
	| 1000007696 |
	| 1000007697 |
	| 1000007698 |
	| 1000007699 |
	| 1000007700 |
	| 1000007701 |
	| 1000007702 |
	| 1000007703 |
	| 1000007704 |
	| 1000007705 |
	| 1000007706 |
	| 1000007707 |
	| 1000007708 |
	| 1000007709 |
	| 1000007710 |
	| 1000007711 |
	| 1000007712 |
	| 1000007713 |
	| 1000007714 |
	| 1000007715 |
	| 1000007716 |
	| 1000007717 |
	| 1000007718 |
	| 1000007719 |
	| 1000007720 |
	| 1000007721 |
	| 1000007722 |
	| 1000007723 |
	| 1000007724 |
	| 1000007725 |
	| 1000007726 |
	| 1000007727 |
	| 1000007728 |
	| 1000007729 |
	| 1000007730 |
	| 1000007731 |
	| 1000007732 |
	| 1000007733 |
	| 1000007734 |
	| 1000007735 |
	| 1000007736 |
	| 1000007737 |
	| 1000007738 |
	| 1000007739 |
	| 1000007740 |
	| 1000007741 |
	| 1000007742 |
	| 1000007743 |
	| 1000007744 |
	| 1000007745 |
	| 1000007746 |
	| 1000007747 |
	| 1000007748 |
	| 1000007749 |
	| 1000007750 |
	| 1000007751 |
	| 1000007752 |
	| 1000007753 |
	| 1000007754 |
	| 1000007755 |
	| 1000007756 |
	| 1000007757 |
	| 1000007758 |
	| 1000007759 |
	| 1000007760 |
	| 1000007761 |
	| 1000007762 |
	| 1000007763 |
	| 1000007764 |
	| 1000007765 |
	| 1000007766 |
	| 1000007767 |
	| 1000007768 |
	| 1000007769 |
	| 1000007770 |
	| 1000007771 |
	| 1000007772 |
	| 1000007773 |
	| 1000007774 |
	| 1000007775 |
	| 1000007776 |
	| 1000007777 |
	| 1000007778 |
	| 1000007779 |
	| 1000007780 |
	| 1000007781 |
	| 1000007782 |
	| 1000007783 |
	| 1000007784 |
	| 1000007785 |
	| 1000007786 |
	| 1000007787 |
	| 1000007788 |
	| 1000007789 |
	| 1000007790 |
	| 1000007791 |
	| 1000007792 |
	| 1000007793 |
	| 1000007794 |
	| 1000007795 |
	| 1000007796 |
	| 1000007797 |
	| 1000007798 |
	| 1000007799 |
	| 1000007800 |
	| 1000007801 |
	| 1000007802 |
	| 1000007803 |
	| 1000007804 |
	| 1000007805 |
	| 1000007806 |
	| 1000007807 |
	| 1000007808 |
	| 1000007809 |
	| 1000007810 |
	| 1000007811 |
	| 1000007812 |
	| 1000007813 |
	| 1000007814 |
	| 1000007815 |
	| 1000007816 |
	| 1000007817 |
	| 1000007818 |
	| 1000007819 |
	| 1000007820 |
	| 1000007821 |
	| 1000007822 |
	| 1000007823 |
	| 1000007824 |
	| 1000007825 |
	| 1000007826 |
	| 1000007827 |
	| 1000007828 |
	| 1000007829 |
	| 1000007830 |
	| 1000007831 |
	| 1000007832 |
	| 1000007833 |
	| 1000007834 |
	| 1000007835 |
	| 1000007836 |
	| 1000007837 |
	| 1000007838 |
	| 1000007839 |
	| 1000007840 |
	| 1000007841 |
	| 1000007842 |
	| 1000007843 |
	| 1000007844 |
	| 1000007845 |
	| 1000007846 |
	| 1000007847 |
	| 1000007848 |
	| 1000007849 |
	| 1000007850 |
	| 1000007851 |
	| 1000007852 |
	| 1000007853 |
	| 1000007854 |
	| 1000007855 |
	| 1000007856 |
	| 1000007857 |
	| 1000007858 |
	| 1000007859 |
	| 1000007860 |
	| 1000007861 |
	| 1000007862 |
	| 1000007863 |
	| 1000007864 |
	| 1000007865 |
	| 1000007866 |
	| 1000007867 |
	| 1000007868 |
	| 1000007869 |
	| 1000007870 |
	| 1000007871 |
	| 1000007872 |
	| 1000007873 |
	| 1000007874 |
	| 1000007875 |
	| 1000007876 |
	| 1000007877 |
	| 1000007878 |
	| 1000007879 |
	| 1000007880 |
	| 1000007881 |
	| 1000007882 |
	| 1000007883 |
	| 1000007884 |
	| 1000007885 |
	| 1000007886 |
	| 1000007887 |
	| 1000007888 |
	| 1000007889 |
	| 1000007890 |
	| 1000007891 |
	| 1000007892 |
	| 1000007893 |
	| 1000007894 |
	| 1000007895 |
	| 1000007896 |
	| 1000007897 |
	| 1000007898 |
	| 1000007899 |
	| 1000007900 |
	| 1000007901 |
	| 1000007902 |
	| 1000007903 |
	| 1000007904 |
	| 1000007905 |
	| 1000007906 |
	| 1000007907 |
	| 1000007908 |
	| 1000007909 |
	| 1000007910 |
	| 1000007911 |
	| 1000007912 |
	| 1000007913 |
	| 1000007914 |
	| 1000007915 |
	| 1000007916 |
	| 1000007917 |
	| 1000007918 |
	| 1000007919 |
	| 1000007920 |
	| 1000007921 |
	| 1000007922 |
	| 1000007923 |
	| 1000007924 |
	| 1000007925 |
	| 1000007926 |
	| 1000007927 |
	| 1000007928 |
	| 1000007929 |
	| 1000007930 |
	| 1000007931 |
	| 1000007932 |
	| 1000007933 |
	| 1000007934 |
	| 1000007935 |
	| 1000007936 |
	| 1000007937 |
	| 1000007938 |
	| 1000007939 |
	| 1000007940 |
	| 1000007941 |
	| 1000007942 |
	| 1000007943 |
	| 1000007944 |
	| 1000007945 |
	| 1000007946 |
	| 1000007947 |
	| 1000007948 |
	| 1000007949 |
	| 1000007950 |
	| 1000007951 |
	| 1000007952 |
	| 1000007953 |
	| 1000007954 |
	| 1000007955 |
	| 1000007956 |
	| 1000007957 |
	| 1000007958 |
	| 1000007959 |
	| 1000007960 |
	| 1000007961 |
	| 1000007962 |
	| 1000007963 |
	| 1000007964 |
	| 1000007965 |
	| 1000007966 |
	| 1000007967 |
	| 1000007968 |
	| 1000007969 |
	| 1000007970 |
	| 1000007971 |
	| 1000007972 |
	| 1000007973 |
	| 1000007974 |
	| 1000007975 |
	| 1000007976 |
	| 1000007977 |
	| 1000007978 |
	| 1000007979 |
	| 1000007980 |
	| 1000007981 |
	| 1000007982 |
	| 1000007983 |
	| 1000007984 |
	| 1000007985 |
	| 1000007986 |
	| 1000007987 |
	| 1000007988 |
	| 1000007989 |
	| 1000007990 |
	| 1000007991 |
	| 1000007992 |
	| 1000007993 |
	| 1000007994 |
	| 1000007995 |
	| 1000007996 |
	| 1000007997 |
	| 1000007998 |
	| 1000007999 |
	| 1000008000 |
	| 1000008001 |
	| 1000008002 |
	| 1000008003 |
	| 1000008004 |
	| 1000008005 |
	| 1000008006 |
	| 1000008007 |
	| 1000008008 |
	| 1000008009 |
	| 1000008010 |
	| 1000008011 |
	| 1000008012 |
	| 1000008013 |
	| 1000008014 |
	| 1000008015 |
	| 1000008016 |
	| 1000008017 |
	| 1000008018 |
	| 1000008019 |
	| 1000008020 |
	| 1000008021 |
	| 1000008022 |
	| 1000008023 |
	| 1000008024 |
	| 1000008025 |
	| 1000008026 |
	| 1000008027 |
	| 1000008028 |
	| 1000008029 |
	| 1000008030 |
	| 1000008031 |
	| 1000008032 |
	| 1000008033 |
	| 1000008034 |
	| 1000008035 |
	| 1000008036 |
	| 1000008037 |
	| 1000008038 |
	| 1000008039 |
	| 1000008040 |
	| 1000008041 |
	| 1000008042 |
	| 1000008043 |
	| 1000008044 |
	| 1000008045 |
	| 1000008046 |
	| 1000008047 |
	| 1000008048 |
	| 1000008049 |
	| 1000008050 |
	| 1000008051 |
	| 1000008052 |
	| 1000008053 |
	| 1000008054 |
	| 1000008055 |
	| 1000008056 |
	| 1000008057 |
	| 1000008058 |
	| 1000008059 |
	| 1000008060 |
	| 1000008061 |
	| 1000008062 |
	| 1000008063 |
	| 1000008064 |
	| 1000008065 |
	| 1000008066 |
	| 1000008067 |
	| 1000008068 |
	| 1000008069 |
	| 1000008070 |
	| 1000008071 |
	| 1000008072 |
	| 1000008073 |
	| 1000008074 |
	| 1000008075 |
	| 1000008076 |
	| 1000008077 |
	| 1000008078 |
	| 1000008079 |
	| 1000008080 |
	| 1000008081 |
	| 1000008082 |
	| 1000008083 |
	| 1000008084 |
	| 1000008085 |
	| 1000008086 |
	| 1000008087 |
	| 1000008088 |
	| 1000008089 |
	| 1000008090 |
	| 1000008091 |
	| 1000008092 |
	| 1000008093 |
	| 1000008094 |
	| 1000008095 |
	| 1000008096 |
	| 1000008097 |
	| 1000008098 |
	| 1000008099 |
	| 1000008100 |
	| 1000008101 |
	| 1000008102 |
	| 1000008103 |
	| 1000008104 |
	| 1000008105 |
	| 1000008106 |
	| 1000008107 |
	| 1000008108 |
	| 1000008109 |
	| 1000008110 |
	| 1000008111 |
	| 1000008112 |
	| 1000008113 |
	| 1000008114 |
	| 1000008115 |
	| 1000008116 |
	| 1000008117 |
	| 1000008118 |
	| 1000008119 |
	| 1000008120 |
	| 1000008121 |
	| 1000008122 |
	| 1000008123 |
	| 1000008124 |
	| 1000008125 |
	| 1000008126 |
	| 1000008127 |
	| 1000008128 |
	| 1000008129 |
	| 1000008130 |
	| 1000008131 |
	| 1000008132 |
	| 1000008133 |
	| 1000008134 |
	| 1000008135 |
	| 1000008136 |
	| 1000008137 |
	| 1000008138 |
	| 1000008139 |
	| 1000008140 |
	| 1000008141 |
	| 1000008142 |
	| 1000008143 |
	| 1000008144 |
	| 1000008145 |
	| 1000008146 |
	| 1000008147 |
	| 1000008148 |
	| 1000008149 |
	| 1000008150 |
	| 1000008151 |
	| 1000008152 |
	| 1000008153 |
	| 1000008154 |
	| 1000008155 |
	| 1000008156 |
	| 1000008157 |
	| 1000008158 |
	| 1000008159 |
	| 1000008160 |
	| 1000008161 |
	| 1000008162 |
	| 1000008163 |
	| 1000008164 |
	| 1000008165 |
	| 1000008166 |
	| 1000008167 |
	| 1000008168 |
	| 1000008169 |
	| 1000008170 |
	| 1000008171 |
	| 1000008172 |
	| 1000008173 |
	| 1000008174 |
	| 1000008175 |
	| 1000008176 |
	| 1000008177 |
	| 1000008178 |
	| 1000008179 |
	| 1000008180 |
	| 1000008181 |
	| 1000008182 |
	| 1000008183 |
	| 1000008184 |
	| 1000008185 |
	| 1000008186 |
	| 1000008187 |
	| 1000008188 |
	| 1000008189 |
	| 1000008190 |
	| 1000008191 |
	| 1000008192 |
	| 1000008193 |
	| 1000008194 |
	| 1000008195 |
	| 1000008196 |
	| 1000008197 |
	| 1000008198 |
	| 1000008199 |
	| 1000008200 |
	| 1000008201 |
	| 1000008202 |
	| 1000008203 |
	| 1000008204 |
	| 1000008205 |
	| 1000008206 |
	| 1000008207 |
	| 1000008208 |
	| 1000008209 |
	| 1000008210 |
	| 1000008211 |
	| 1000008212 |
	| 1000008213 |
	| 1000008214 |
	| 1000008215 |
	| 1000008216 |
	| 1000008217 |
	| 1000008218 |
	| 1000008219 |
	| 1000008220 |
	| 1000008221 |
	| 1000008222 |
	| 1000008223 |
	| 1000008224 |
	| 1000008225 |
	| 1000008226 |
	| 1000008227 |
	| 1000008228 |
	| 1000008229 |
	| 1000008230 |
	| 1000008231 |
	| 1000008232 |
	| 1000008233 |
	| 1000008234 |
	| 1000008235 |
	| 1000008236 |
	| 1000008237 |
	| 1000008238 |
	| 1000008239 |
	| 1000008240 |
	| 1000008241 |
	| 1000008242 |
	| 1000008243 |
	| 1000008244 |
	| 1000008245 |
	| 1000008246 |
	| 1000008247 |
	| 1000008248 |
	| 1000008249 |
	| 1000008250 |
	| 1000008251 |
	| 1000008252 |
	| 1000008253 |
	| 1000008254 |
	| 1000008255 |
	| 1000008256 |
	| 1000008257 |
	| 1000008258 |
	| 1000008259 |
	| 1000008260 |
	| 1000008261 |
	| 1000008262 |
	| 1000008263 |
	| 1000008264 |
	| 1000008265 |
	| 1000008266 |
	| 1000008267 |
	| 1000008268 |
	| 1000008269 |
	| 1000008270 |
	| 1000008271 |
	| 1000008272 |
	| 1000008273 |
	| 1000008274 |
	| 1000008275 |
	| 1000008276 |
	| 1000008277 |
	| 1000008278 |
	| 1000008279 |
	| 1000008280 |
	| 1000008281 |
	| 1000008282 |
	| 1000008283 |
	| 1000008284 |
	| 1000008285 |
	| 1000008286 |
	| 1000008287 |
	| 1000008288 |
	| 1000008289 |
	| 1000008290 |
	| 1000008291 |
	| 1000008292 |
	| 1000008293 |
	| 1000008294 |
	| 1000008295 |
	| 1000008296 |
	| 1000008297 |
	| 1000008298 |
	| 1000008299 |
	| 1000008300 |
	| 1000008301 |
	| 1000008302 |
	| 1000008303 |
	| 1000008304 |
	| 1000008305 |
	| 1000008306 |
	| 1000008307 |
	| 1000008308 |
	| 1000008309 |
	| 1000008310 |
	| 1000008311 |
	| 1000008312 |
	| 1000008313 |
	| 1000008314 |
	| 1000008315 |
	| 1000008316 |
	| 1000008317 |
	| 1000008318 |
	| 1000008319 |
	| 1000008320 |
	| 1000008321 |
	| 1000008322 |
	| 1000008323 |
	| 1000008324 |
	| 1000008325 |
	| 1000008326 |
	| 1000008327 |
	| 1000008328 |
	| 1000008329 |
	| 1000008330 |
	| 1000008331 |
	| 1000008332 |
	| 1000008333 |
	| 1000008334 |
	| 1000008335 |
	| 1000008336 |
	| 1000008337 |
	| 1000008338 |
	| 1000008339 |
	| 1000008340 |
	| 1000008341 |
	| 1000008342 |
	| 1000008343 |
	| 1000008344 |
	| 1000008345 |
	| 1000008346 |
	| 1000008347 |
	| 1000008348 |
	| 1000008349 |
	| 1000008350 |
	| 1000008351 |
	| 1000008352 |
	| 1000008353 |
	| 1000008354 |
	| 1000008355 |
	| 1000008356 |
	| 1000008357 |
	| 1000008358 |
	| 1000008359 |
	| 1000008360 |
	| 1000008361 |
	| 1000008362 |
	| 1000008363 |
	| 1000008364 |
	| 1000008365 |
	| 1000008366 |
	| 1000008367 |
	| 1000008368 |
	| 1000008369 |
	| 1000008370 |
	| 1000008371 |
	| 1000008372 |
	| 1000008373 |
	| 1000008374 |
	| 1000008375 |
	| 1000008376 |
	| 1000008377 |
	| 1000008378 |
	| 1000008379 |
	| 1000008380 |
	| 1000008381 |
	| 1000008382 |
	| 1000008383 |
	| 1000008384 |
	| 1000008385 |
	| 1000008386 |
	| 1000008387 |
	| 1000008388 |
	| 1000008389 |
	| 1000008390 |
	| 1000008391 |
	| 1000008392 |
	| 1000008393 |
	| 1000008394 |
	| 1000008395 |
	| 1000008396 |
	| 1000008397 |
	| 1000008398 |
	| 1000008399 |
	| 1000008400 |
	| 1000008401 |
	| 1000008402 |
	| 1000008403 |
	| 1000008404 |
	| 1000008405 |
	| 1000008406 |
	| 1000008407 |
	| 1000008408 |
	| 1000008409 |
	| 1000008410 |
	| 1000008411 |
	| 1000008412 |
	| 1000008413 |
	| 1000008414 |
	| 1000008415 |
	| 1000008416 |
	| 1000008417 |
	| 1000008418 |
	| 1000008419 |
	| 1000008420 |
	| 1000008421 |
	| 1000008422 |
	| 1000008423 |
	| 1000008424 |
	| 1000008425 |
	| 1000008426 |
	| 1000008427 |
	| 1000008428 |
	| 1000008429 |
	| 1000008430 |
	| 1000008431 |
	| 1000008432 |
	| 1000008433 |
	| 1000008434 |
	| 1000008435 |
	| 1000008436 |
	| 1000008437 |
	| 1000008438 |
	| 1000008439 |
	| 1000008440 |
	| 1000008441 |
	| 1000008442 |
	| 1000008443 |
	| 1000008444 |
	| 1000008445 |
	| 1000008446 |
	| 1000008447 |
	| 1000008448 |
	| 1000008449 |
	| 1000008450 |
	| 1000008451 |
	| 1000008452 |
	| 1000008453 |
	| 1000008454 |
	| 1000008455 |
	| 1000008456 |
	| 1000008457 |
	| 1000008458 |
	| 1000008459 |
	| 1000008460 |
	| 1000008461 |
	| 1000008462 |
	| 1000008463 |
	| 1000008464 |
	| 1000008465 |
	| 1000008466 |
	| 1000008467 |
	| 1000008468 |
	| 1000008469 |
	| 1000008470 |
	| 1000008471 |
	| 1000008472 |
	| 1000008473 |
	| 1000008474 |
	| 1000008475 |
	| 1000008476 |
	| 1000008477 |
	| 1000008478 |
	| 1000008479 |
	| 1000008480 |
	| 1000008481 |
	| 1000008482 |
	| 1000008483 |
	| 1000008484 |
	| 1000008485 |
	| 1000008486 |
	| 1000008487 |
	| 1000008488 |
	| 1000008489 |
	| 1000008490 |
	| 1000008491 |
	| 1000008492 |
	| 1000008493 |
	| 1000008494 |
	| 1000008495 |
	| 1000008496 |
	| 1000008497 |
	| 1000008498 |
	| 1000008499 |
	| 1000008500 |
	| 1000008501 |
	| 1000008502 |
	| 1000008503 |
	| 1000008504 |
	| 1000008505 |
	| 1000008506 |
	| 1000008507 |
	| 1000008508 |
	| 1000008509 |
	| 1000008510 |
	| 1000008511 |
	| 1000008512 |
	| 1000008513 |
	| 1000008514 |
	| 1000008515 |
	| 1000008516 |
	| 1000008517 |
	| 1000008518 |
	| 1000008519 |
	| 1000008520 |
	| 1000008521 |
	| 1000008522 |
	| 1000008523 |
	| 1000008524 |
	| 1000008525 |
	| 1000008526 |
	| 1000008527 |
	| 1000008528 |
	| 1000008529 |
	| 1000008530 |
	| 1000008531 |
	| 1000008532 |
	| 1000008533 |
	| 1000008534 |
	| 1000008535 |
	| 1000008536 |
	| 1000008537 |
	| 1000008538 |
	| 1000008539 |
	| 1000008540 |
	| 1000008541 |
	| 1000008542 |
	| 1000008543 |
	| 1000008544 |
	| 1000008545 |
	| 1000008546 |
	| 1000008547 |
	| 1000008548 |
	| 1000008549 |
	| 1000008550 |
	| 1000008551 |
	| 1000008552 |
	| 1000008553 |
	| 1000008554 |
	| 1000008555 |
	| 1000008556 |
	| 1000008557 |
	| 1000008558 |
	| 1000008559 |
	| 1000008560 |
	| 1000008561 |
	| 1000008562 |
	| 1000008563 |
	| 1000008564 |
	| 1000008565 |
	| 1000008566 |
	| 1000008567 |
	| 1000008568 |
	| 1000008569 |
	| 1000008570 |
	| 1000008571 |
	| 1000008572 |
	| 1000008573 |
	| 1000008574 |
	| 1000008575 |
	| 1000008576 |
	| 1000008577 |
	| 1000008578 |
	| 1000008579 |
	| 1000008580 |
	| 1000008581 |
	| 1000008582 |
	| 1000008583 |
	| 1000008584 |
	| 1000008585 |
	| 1000008586 |
	| 1000008587 |
	| 1000008588 |
	| 1000008589 |
	| 1000008590 |
	| 1000008591 |
	| 1000008592 |
	| 1000008593 |
	| 1000008594 |
	| 1000008595 |
	| 1000008596 |
	| 1000008597 |
	| 1000008598 |
	| 1000008599 |
	| 1000008600 |
	| 1000008601 |
	| 1000008602 |
	| 1000008603 |
	| 1000008604 |
	| 1000008605 |
	| 1000008606 |
	| 1000008607 |
	| 1000008608 |
	| 1000008609 |
	| 1000008610 |
	| 1000008611 |
	| 1000008612 |
	| 1000008613 |
	| 1000008614 |
	| 1000008615 |
	| 1000008616 |
	| 1000008617 |
	| 1000008618 |
	| 1000008619 |
	| 1000008620 |
	| 1000008621 |
	| 1000008622 |
	| 1000008623 |
	| 1000008624 |
	| 1000008625 |
	| 1000008626 |
	| 1000008627 |
	| 1000008628 |
	| 1000008629 |
	| 1000008630 |
	| 1000008631 |
	| 1000008632 |
	| 1000008633 |
	| 1000008634 |
	| 1000008635 |
	| 1000008636 |
	| 1000008637 |
	| 1000008638 |
	| 1000008639 |
	| 1000008640 |
	| 1000008641 |
	| 1000008642 |
	| 1000008643 |
	| 1000008644 |
	| 1000008645 |
	| 1000008646 |
	| 1000008647 |
	| 1000008648 |
	| 1000008649 |
	| 1000008650 |
	| 1000008651 |
	| 1000008652 |
	| 1000008653 |
	| 1000008654 |
	| 1000008655 |
	| 1000008656 |
	| 1000008657 |
	| 1000008658 |
	| 1000008659 |
	| 1000008660 |
	| 1000008661 |
	| 1000008662 |
	| 1000008663 |
	| 1000008664 |
	| 1000008665 |
	| 1000008666 |
	| 1000008667 |
	| 1000008668 |
	| 1000008669 |
	| 1000008670 |
	| 1000008671 |
	| 1000008672 |
	| 1000008673 |
	| 1000008674 |
	| 1000008675 |
	| 1000008676 |
	| 1000008677 |
	| 1000008678 |
	| 1000008679 |
	| 1000008680 |
	| 1000008681 |
	| 1000008682 |
	| 1000008683 |
	| 1000008684 |
	| 1000008685 |
	| 1000008686 |
	| 1000008687 |
	| 1000008688 |
	| 1000008689 |
	| 1000008690 |
	| 1000008691 |
	| 1000008692 |
	| 1000008693 |
	| 1000008694 |
	| 1000008695 |
	| 1000008696 |
	| 1000008697 |
	| 1000008698 |
	| 1000008699 |
	| 1000008700 |
	| 1000008701 |
	| 1000008702 |
	| 1000008703 |
	| 1000008704 |
	| 1000008705 |
	| 1000008706 |
	| 1000008707 |
	| 1000008708 |
	| 1000008709 |
	| 1000008710 |
	| 1000008711 |
	| 1000008712 |
	| 1000008713 |
	| 1000008714 |
	| 1000008715 |
	| 1000008716 |
	| 1000008717 |
	| 1000008718 |
	| 1000008719 |
	| 1000008720 |
	| 1000008721 |
	| 1000008722 |
	| 1000008723 |
	| 1000008724 |
	| 1000008725 |
	| 1000008726 |
	| 1000008727 |
	| 1000008728 |
	| 1000008729 |
	| 1000008730 |
	| 1000008731 |
	| 1000008732 |
	| 1000008733 |
	| 1000008734 |
	| 1000008735 |
	| 1000008736 |
	| 1000008737 |
	| 1000008738 |
	| 1000008739 |
	| 1000008740 |
	| 1000008741 |
	| 1000008742 |
	| 1000008743 |
	| 1000008744 |
	| 1000008745 |
	| 1000008746 |
	| 1000008747 |
	| 1000008748 |
	| 1000008749 |
	| 1000008750 |
	| 1000008751 |
	| 1000008752 |
	| 1000008753 |
	| 1000008754 |
	| 1000008755 |
	| 1000008756 |
	| 1000008757 |
	| 1000008758 |
	| 1000008759 |
	| 1000008760 |
	| 1000008761 |
	| 1000008762 |
	| 1000008763 |
	| 1000008764 |
	| 1000008765 |
	| 1000008766 |
	| 1000008767 |
	| 1000008768 |
	| 1000008769 |
	| 1000008770 |
	| 1000008771 |
	| 1000008772 |
	| 1000008773 |
	| 1000008774 |
	| 1000008775 |
	| 1000008776 |
	| 1000008777 |
	| 1000008778 |
	| 1000008779 |
	| 1000008780 |
	| 1000008781 |
	| 1000008782 |
	| 1000008783 |
	| 1000008784 |
	| 1000008785 |
	| 1000008786 |
	| 1000008787 |
	| 1000008788 |
	| 1000008789 |
	| 1000008790 |
	| 1000008791 |
	| 1000008792 |
	| 1000008793 |
	| 1000008794 |
	| 1000008795 |
	| 1000008796 |
	| 1000008797 |
	| 1000008798 |
	| 1000008799 |
	| 1000008800 |
	| 1000008801 |
	| 1000008802 |
	| 1000008803 |
	| 1000008804 |
	| 1000008805 |
	| 1000008806 |
	| 1000008807 |
	| 1000008808 |
	| 1000008809 |
	| 1000008810 |
	| 1000008811 |
	| 1000008812 |
	| 1000008813 |
	| 1000008814 |
	| 1000008815 |
	| 1000008816 |
	| 1000008817 |
	| 1000008818 |
	| 1000008819 |
	| 1000008820 |
	| 1000008821 |
	| 1000008822 |
	| 1000008823 |
	| 1000008824 |
	| 1000008825 |
	| 1000008826 |
	| 1000008827 |
	| 1000008828 |
	| 1000008829 |
	| 1000008830 |
	| 1000008831 |
	| 1000008832 |
	| 1000008833 |
	| 1000008834 |
	| 1000008835 |
	| 1000008836 |
	| 1000008837 |
	| 1000008838 |
	| 1000008839 |
	| 1000008840 |
	| 1000008841 |
	| 1000008842 |
	| 1000008843 |
	| 1000008844 |
	| 1000008845 |
	| 1000008846 |
	| 1000008847 |
	| 1000008848 |
	| 1000008849 |
	| 1000008850 |
	| 1000008851 |
	| 1000008852 |
	| 1000008853 |
	| 1000008854 |
	| 1000008855 |
	| 1000008856 |
	| 1000008857 |
	| 1000008858 |
	| 1000008859 |
	| 1000008860 |
	| 1000008861 |
	| 1000008862 |
	| 1000008863 |
	| 1000008864 |
	| 1000008865 |
	| 1000008866 |
	| 1000008867 |
	| 1000008868 |
	| 1000008869 |
	| 1000008870 |
	| 1000008871 |
	| 1000008872 |
	| 1000008873 |
	| 1000008874 |
	| 1000008875 |
	| 1000008876 |
	| 1000008877 |
	| 1000008878 |
	| 1000008879 |
	| 1000008880 |
	| 1000008881 |
	| 1000008882 |
	| 1000008883 |
	| 1000008884 |
	| 1000008885 |
	| 1000008886 |
	| 1000008887 |
	| 1000008888 |
	| 1000008889 |
	| 1000008890 |
	| 1000008891 |
	| 1000008892 |
	| 1000008893 |
	| 1000008894 |
	| 1000008895 |
	| 1000008896 |
	| 1000008897 |
	| 1000008898 |
	| 1000008899 |
	| 1000008900 |
	| 1000008901 |
	| 1000008902 |
	| 1000008903 |
	| 1000008904 |
	| 1000008905 |
	| 1000008906 |
	| 1000008907 |
	| 1000008908 |
	| 1000008909 |
	| 1000008910 |
	| 1000008911 |
	| 1000008912 |
	| 1000008913 |
	| 1000008914 |
	| 1000008915 |
	| 1000008916 |
	| 1000008917 |
	| 1000008918 |
	| 1000008919 |
	| 1000008920 |
	| 1000008921 |
	| 1000008922 |
	| 1000008923 |
	| 1000008924 |
	| 1000008925 |
	| 1000008926 |
	| 1000008927 |
	| 1000008928 |
	| 1000008929 |
	| 1000008930 |
	| 1000008931 |
	| 1000008932 |
	| 1000008933 |
	| 1000008934 |
	| 1000008935 |
	| 1000008936 |
	| 1000008937 |
	| 1000008938 |
	| 1000008939 |
	| 1000008940 |
	| 1000008941 |
	| 1000008942 |
	| 1000008943 |
	| 1000008944 |
	| 1000008945 |
	| 1000008946 |
	| 1000008947 |
	| 1000008948 |
	| 1000008949 |
	| 1000008950 |
	| 1000008951 |
	| 1000008952 |
	| 1000008953 |
	| 1000008954 |
	| 1000008955 |
	| 1000008956 |
	| 1000008957 |
	| 1000008958 |
	| 1000008959 |
	| 1000008960 |
	| 1000008961 |
	| 1000008962 |
	| 1000008963 |
	| 1000008964 |
	| 1000008965 |
	| 1000008966 |
	| 1000008967 |
	| 1000008968 |
	| 1000008969 |
	| 1000008970 |
	| 1000008971 |
	| 1000008972 |
	| 1000008973 |
	| 1000008974 |
	| 1000008975 |
	| 1000008976 |
	| 1000008977 |
	| 1000008978 |
	| 1000008979 |
	| 1000008980 |
	| 1000008981 |
	| 1000008982 |
	| 1000008983 |
	| 1000008984 |
	| 1000008985 |
	| 1000008986 |
	| 1000008987 |
	| 1000008988 |
	| 1000008989 |
	| 1000008990 |
	| 1000008991 |
	| 1000008992 |
	| 1000008993 |
	| 1000008994 |
	| 1000008995 |
	| 1000008996 |
	| 1000008997 |
	| 1000008998 |
	| 1000008999 |
	| 1000009000 |
	| 1000009001 |
	| 1000009002 |
	| 1000009003 |
	| 1000009004 |
	| 1000009005 |
	| 1000009006 |
	| 1000009007 |
	| 1000009008 |
	| 1000009009 |
	| 1000009010 |
	| 1000009011 |
	| 1000009012 |
	| 1000009013 |
	| 1000009014 |
	| 1000009015 |
	| 1000009016 |
	| 1000009017 |
	| 1000009018 |
	| 1000009019 |
	| 1000009020 |
	| 1000009021 |
	| 1000009022 |
	| 1000009023 |
	| 1000009024 |
	| 1000009025 |
	| 1000009026 |
	| 1000009027 |
	| 1000009028 |
	| 1000009029 |
	| 1000009030 |
	| 1000009031 |
	| 1000009032 |
	| 1000009033 |
	| 1000009034 |
	| 1000009035 |
	| 1000009036 |
	| 1000009037 |
	| 1000009038 |
	| 1000009039 |
	| 1000009040 |
	| 1000009041 |
	| 1000009042 |
	| 1000009043 |
	| 1000009044 |
	| 1000009045 |
	| 1000009046 |
	| 1000009047 |
	| 1000009048 |
	| 1000009049 |
	| 1000009050 |
	| 1000009051 |
	| 1000009052 |
	| 1000009053 |
	| 1000009054 |
	| 1000009055 |
	| 1000009056 |
	| 1000009057 |
	| 1000009058 |
	| 1000009059 |
	| 1000009060 |
	| 1000009061 |
	| 1000009062 |
	| 1000009063 |
	| 1000009064 |
	| 1000009065 |
	| 1000009066 |
	| 1000009067 |
	| 1000009068 |
	| 1000009069 |
	| 1000009070 |
	| 1000009071 |
	| 1000009072 |
	| 1000009073 |
	| 1000009074 |
	| 1000009075 |
	| 1000009076 |
	| 1000009077 |
	| 1000009078 |
	| 1000009079 |
	| 1000009080 |
	| 1000009081 |
	| 1000009082 |
	| 1000009083 |
	| 1000009084 |
	| 1000009085 |
	| 1000009086 |
	| 1000009087 |
	| 1000009088 |
	| 1000009089 |
	| 1000009090 |
	| 1000009091 |
	| 1000009092 |
	| 1000009093 |
	| 1000009094 |
	| 1000009095 |
	| 1000009096 |
	| 1000009097 |
	| 1000009098 |
	| 1000009099 |
	| 1000009100 |
	| 1000009101 |
	| 1000009102 |
	| 1000009103 |
	| 1000009104 |
	| 1000009105 |
	| 1000009106 |
	| 1000009107 |
	| 1000009108 |
	| 1000009109 |
	| 1000009110 |
	| 1000009111 |
	| 1000009112 |
	| 1000009113 |
	| 1000009114 |
	| 1000009115 |
	| 1000009116 |
	| 1000009117 |
	| 1000009118 |
	| 1000009119 |
	| 1000009120 |
	| 1000009121 |
	| 1000009122 |
	| 1000009123 |
	| 1000009124 |
	| 1000009125 |
	| 1000009126 |
	| 1000009127 |
	| 1000009128 |
	| 1000009129 |
	| 1000009130 |
	| 1000009131 |
	| 1000009132 |
	| 1000009133 |
	| 1000009134 |
	| 1000009135 |
	| 1000009136 |
	| 1000009137 |
	| 1000009138 |
	| 1000009139 |
	| 1000009140 |
	| 1000009141 |
	| 1000009142 |
	| 1000009143 |
	| 1000009144 |
	| 1000009145 |
	| 1000009146 |
	| 1000009147 |
	| 1000009148 |
	| 1000009149 |
	| 1000009150 |
	| 1000009151 |
	| 1000009152 |
	| 1000009153 |
	| 1000009154 |
	| 1000009155 |
	| 1000009156 |
	| 1000009157 |
	| 1000009158 |
	| 1000009159 |
	| 1000009160 |
	| 1000009161 |
	| 1000009162 |
	| 1000009163 |
	| 1000009164 |
	| 1000009165 |
	| 1000009166 |
	| 1000009167 |
	| 1000009168 |
	| 1000009169 |
	| 1000009170 |
	| 1000009171 |
	| 1000009172 |
	| 1000009173 |
	| 1000009174 |
	| 1000009175 |
	| 1000009176 |
	| 1000009177 |
	| 1000009178 |
	| 1000009179 |
	| 1000009180 |
	| 1000009181 |
	| 1000009182 |
	| 1000009183 |
	| 1000009184 |
	| 1000009185 |
	| 1000009186 |
	| 1000009187 |
	| 1000009188 |
	| 1000009189 |
	| 1000009190 |
	| 1000009191 |
	| 1000009192 |
	| 1000009193 |
	| 1000009194 |
	| 1000009195 |
	| 1000009196 |
	| 1000009197 |
	| 1000009198 |
	| 1000009199 |
	| 1000009200 |
	| 1000009201 |
	| 1000009202 |
	| 1000009203 |
	| 1000009204 |
	| 1000009205 |
	| 1000009206 |
	| 1000009207 |
	| 1000009208 |
	| 1000009209 |
	| 1000009210 |
	| 1000009211 |
	| 1000009212 |
	| 1000009213 |
	| 1000009214 |
	| 1000009215 |
	| 1000009216 |
	| 1000009217 |
	| 1000009218 |
	| 1000009219 |
	| 1000009220 |
	| 1000009221 |
	| 1000009222 |
	| 1000009223 |
	| 1000009224 |
	| 1000009225 |
	| 1000009226 |
	| 1000009227 |
	| 1000009228 |
	| 1000009229 |
	| 1000009230 |
	| 1000009231 |
	| 1000009232 |
	| 1000009233 |
	| 1000009234 |
	| 1000009235 |
	| 1000009236 |
	| 1000009237 |
	| 1000009238 |
	| 1000009239 |
	| 1000009240 |
	| 1000009241 |
	| 1000009242 |
	| 1000009243 |
	| 1000009244 |
	| 1000009245 |
	| 1000009246 |
	| 1000009247 |
	| 1000009248 |
	| 1000009249 |
	| 1000009250 |
	| 1000009251 |
	| 1000009252 |
	| 1000009253 |
	| 1000009254 |
	| 1000009255 |
	| 1000009256 |
	| 1000009257 |
	| 1000009258 |
	| 1000009259 |
	| 1000009260 |
	| 1000009261 |
	| 1000009262 |
	| 1000009263 |
	| 1000009264 |
	| 1000009265 |
	| 1000009266 |
	| 1000009267 |
	| 1000009268 |
	| 1000009269 |
	| 1000009270 |
	| 1000009271 |
	| 1000009272 |
	| 1000009273 |
	| 1000009274 |
	| 1000009275 |
	| 1000009276 |
	| 1000009277 |
	| 1000009278 |
	| 1000009279 |
	| 1000009280 |
	| 1000009281 |
	| 1000009282 |
	| 1000009283 |
	| 1000009284 |
	| 1000009285 |
	| 1000009286 |
	| 1000009287 |
	| 1000009288 |
	| 1000009289 |
	| 1000009290 |
	| 1000009291 |
	| 1000009292 |
	| 1000009293 |
	| 1000009294 |
	| 1000009295 |
	| 1000009296 |
	| 1000009297 |
	| 1000009298 |
	| 1000009299 |
	| 1000009300 |
	| 1000009301 |
	| 1000009302 |
	| 1000009303 |
	| 1000009304 |
	| 1000009305 |
	| 1000009306 |
	| 1000009307 |
	| 1000009308 |
	| 1000009309 |
	| 1000009310 |
	| 1000009311 |
	| 1000009312 |
	| 1000009313 |
	| 1000009314 |
	| 1000009315 |
	| 1000009316 |
	| 1000009317 |
	| 1000009318 |
	| 1000009319 |
	| 1000009320 |
	| 1000009321 |
	| 1000009322 |
	| 1000009323 |
	| 1000009324 |
	| 1000009325 |
	| 1000009326 |
	| 1000009327 |
	| 1000009328 |
	| 1000009329 |
	| 1000009330 |
	| 1000009331 |
	| 1000009332 |
	| 1000009333 |
	| 1000009334 |
	| 1000009335 |
	| 1000009336 |
	| 1000009337 |
	| 1000009338 |
	| 1000009339 |
	| 1000009340 |
	| 1000009341 |
	| 1000009342 |
	| 1000009343 |
	| 1000009344 |
	| 1000009345 |
	| 1000009346 |
	| 1000009347 |
	| 1000009348 |
	| 1000009349 |
	| 1000009350 |
	| 1000009351 |
	| 1000009352 |
	| 1000009353 |
	| 1000009354 |
	| 1000009355 |
	| 1000009356 |
	| 1000009357 |
	| 1000009358 |
	| 1000009359 |
	| 1000009360 |
	| 1000009361 |
	| 1000009362 |
	| 1000009363 |
	| 1000009364 |
	| 1000009365 |
	| 1000009366 |
	| 1000009367 |
	| 1000009368 |
	| 1000009369 |
	| 1000009370 |
	| 1000009371 |
	| 1000009372 |
	| 1000009373 |
	| 1000009374 |
	| 1000009375 |
	| 1000009376 |
	| 1000009377 |
	| 1000009378 |
	| 1000009379 |
	| 1000009380 |
	| 1000009381 |
	| 1000009382 |
	| 1000009383 |
	| 1000009384 |
	| 1000009385 |
	| 1000009386 |
	| 1000009387 |
	| 1000009388 |
	| 1000009389 |
	| 1000009390 |
	| 1000009391 |
	| 1000009392 |
	| 1000009393 |
	| 1000009394 |
	| 1000009395 |
	| 1000009396 |
	| 1000009397 |
	| 1000009398 |
	| 1000009399 |
	| 1000009400 |
	| 1000009401 |
	| 1000009402 |
	| 1000009403 |
	| 1000009404 |
	| 1000009405 |
	| 1000009406 |
	| 1000009407 |
	| 1000009408 |
	| 1000009409 |
	| 1000009410 |
	| 1000009411 |
	| 1000009412 |
	| 1000009413 |
	| 1000009414 |
	| 1000009415 |
	| 1000009416 |
	| 1000009417 |
	| 1000009418 |
	| 1000009419 |
	| 1000009420 |
	| 1000009421 |
	| 1000009422 |
	| 1000009423 |
	| 1000009424 |
	| 1000009425 |
	| 1000009426 |
	| 1000009427 |
	| 1000009428 |
	| 1000009429 |
	| 1000009430 |
	| 1000009431 |
	| 1000009432 |
	| 1000009433 |
	| 1000009434 |
	| 1000009435 |
	| 1000009436 |
	| 1000009437 |
	| 1000009438 |
	| 1000009439 |
	| 1000009440 |
	| 1000009441 |
	| 1000009442 |
	| 1000009443 |
	| 1000009444 |
	| 1000009445 |
	| 1000009446 |
	| 1000009447 |
	| 1000009448 |
	| 1000009449 |
	| 1000009450 |
	| 1000009451 |
	| 1000009452 |
	| 1000009453 |
	| 1000009454 |
	| 1000009455 |
	| 1000009456 |
	| 1000009457 |
	| 1000009458 |
	| 1000009459 |
	| 1000009460 |
	| 1000009461 |
	| 1000009462 |
	| 1000009463 |
	| 1000009464 |
	| 1000009465 |
	| 1000009466 |
	| 1000009467 |
	| 1000009468 |
	| 1000009469 |
	| 1000009470 |
	| 1000009471 |
	| 1000009472 |
	| 1000009473 |
	| 1000009474 |
	| 1000009475 |
	| 1000009476 |
	| 1000009477 |
	| 1000009478 |
	| 1000009479 |
	| 1000009480 |
	| 1000009481 |
	| 1000009482 |
	| 1000009483 |
	| 1000009484 |
	| 1000009485 |
	| 1000009486 |
	| 1000009487 |
	| 1000009488 |
	| 1000009489 |
	| 1000009490 |
	| 1000009491 |
	| 1000009492 |
	| 1000009493 |
	| 1000009494 |
	| 1000009495 |
	| 1000009496 |
	| 1000009497 |
	| 1000009498 |
	| 1000009499 |
	| 1000009500 |
	| 1000009501 |
	| 1000009502 |
	| 1000009503 |
	| 1000009504 |
	| 1000009505 |
	| 1000009506 |
	| 1000009507 |
	| 1000009508 |
	| 1000009509 |
	| 1000009510 |
	| 1000009511 |
	| 1000009512 |
	| 1000009513 |
	| 1000009514 |
	| 1000009515 |
	| 1000009516 |
	| 1000009517 |
	| 1000009518 |
	| 1000009519 |
	| 1000009520 |
	| 1000009521 |
	| 1000009522 |
	| 1000009523 |
	| 1000009524 |
	| 1000009525 |
	| 1000009526 |
	| 1000009527 |
	| 1000009528 |
	| 1000009529 |
	| 1000009530 |
	| 1000009531 |
	| 1000009532 |
	| 1000009533 |
	| 1000009534 |
	| 1000009535 |
	| 1000009536 |
	| 1000009537 |
	| 1000009538 |
	| 1000009539 |
	| 1000009540 |
	| 1000009541 |
	| 1000009542 |
	| 1000009543 |
	| 1000009544 |
	| 1000009545 |
	| 1000009546 |
	| 1000009547 |
	| 1000009548 |
	| 1000009549 |
	| 1000009550 |
	| 1000009551 |
	| 1000009552 |
	| 1000009553 |
	| 1000009554 |
	| 1000009555 |
	| 1000009556 |
	| 1000009557 |
	| 1000009558 |
	| 1000009559 |
	| 1000009560 |
	| 1000009561 |
	| 1000009562 |
	| 1000009563 |
	| 1000009564 |
	| 1000009565 |
	| 1000009566 |
	| 1000009567 |
	| 1000009568 |
	| 1000009569 |
	| 1000009570 |
	| 1000009571 |
	| 1000009572 |
	| 1000009573 |
	| 1000009574 |
	| 1000009575 |
	| 1000009576 |
	| 1000009577 |
	| 1000009578 |
	| 1000009579 |
	| 1000009580 |
	| 1000009581 |
	| 1000009582 |
	| 1000009583 |
	| 1000009584 |
	| 1000009585 |
	| 1000009586 |
	| 1000009587 |
	| 1000009588 |
	| 1000009589 |
	| 1000009590 |
	| 1000009591 |
	| 1000009592 |
	| 1000009593 |
	| 1000009594 |
	| 1000009595 |
	| 1000009596 |
	| 1000009597 |
	| 1000009598 |
	| 1000009599 |
	| 1000009600 |
	| 1000009601 |
	| 1000009602 |
	| 1000009603 |
	| 1000009604 |
	| 1000009605 |
	| 1000009606 |
	| 1000009607 |
	| 1000009608 |
	| 1000009609 |
	| 1000009610 |
	| 1000009611 |
	| 1000009612 |
	| 1000009613 |
	| 1000009614 |
	| 1000009615 |
	| 1000009616 |
	| 1000009617 |
	| 1000009618 |
	| 1000009619 |
	| 1000009620 |
	| 1000009621 |
	| 1000009622 |
	| 1000009623 |
	| 1000009624 |
	| 1000009625 |
	| 1000009626 |
	| 1000009627 |
	| 1000009628 |
	| 1000009629 |
	| 1000009630 |
	| 1000009631 |
	| 1000009632 |
	| 1000009633 |
	| 1000009634 |
	| 1000009635 |
	| 1000009636 |
	| 1000009637 |
	| 1000009638 |
	| 1000009639 |
	| 1000009640 |
	| 1000009641 |
	| 1000009642 |
	| 1000009643 |
	| 1000009644 |
	| 1000009645 |
	| 1000009646 |
	| 1000009647 |
	| 1000009648 |
	| 1000009649 |
	| 1000009650 |
	| 1000009651 |
	| 1000009652 |
	| 1000009653 |
	| 1000009654 |
	| 1000009655 |
	| 1000009656 |
	| 1000009657 |
	| 1000009658 |
	| 1000009659 |
	| 1000009660 |
	| 1000009661 |
	| 1000009662 |
	| 1000009663 |
	| 1000009664 |
	| 1000009665 |
	| 1000009666 |
	| 1000009667 |
	| 1000009668 |
	| 1000009669 |
	| 1000009670 |
	| 1000009671 |
	| 1000009672 |
	| 1000009673 |
	| 1000009674 |
	| 1000009675 |
	| 1000009676 |
	| 1000009677 |
	| 1000009678 |
	| 1000009679 |
	| 1000009680 |
	| 1000009681 |
	| 1000009682 |
	| 1000009683 |
	| 1000009684 |
	| 1000009685 |
	| 1000009686 |
	| 1000009687 |
	| 1000009688 |
	| 1000009689 |
	| 1000009690 |
	| 1000009691 |
	| 1000009692 |
	| 1000009693 |
	| 1000009694 |
	| 1000009695 |
	| 1000009696 |
	| 1000009697 |
	| 1000009698 |
	| 1000009699 |
	| 1000009700 |
	| 1000009701 |
	| 1000009702 |
	| 1000009703 |
	| 1000009704 |
	| 1000009705 |
	| 1000009706 |
	| 1000009707 |
	| 1000009708 |
	| 1000009709 |
	| 1000009710 |
	| 1000009711 |
	| 1000009712 |
	| 1000009713 |
	| 1000009714 |
	| 1000009715 |
	| 1000009716 |
	| 1000009717 |
	| 1000009718 |
	| 1000009719 |
	| 1000009720 |
	| 1000009721 |
	| 1000009722 |
	| 1000009723 |
	| 1000009724 |
	| 1000009725 |
	| 1000009726 |
	| 1000009727 |
	| 1000009728 |
	| 1000009729 |
	| 1000009730 |
	| 1000009731 |
	| 1000009732 |
	| 1000009733 |
	| 1000009734 |
	| 1000009735 |
	| 1000009736 |
	| 1000009737 |
	| 1000009738 |
	| 1000009739 |
	| 1000009740 |
	| 1000009741 |
	| 1000009742 |
	| 1000009743 |
	| 1000009744 |
	| 1000009745 |
	| 1000009746 |
	| 1000009747 |
	| 1000009748 |
	| 1000009749 |
	| 1000009750 |
	| 1000009751 |
	| 1000009752 |
	| 1000009753 |
	| 1000009754 |
	| 1000009755 |
	| 1000009756 |
	| 1000009757 |
	| 1000009758 |
	| 1000009759 |
	| 1000009760 |
	| 1000009761 |
	| 1000009762 |
	| 1000009763 |
	| 1000009764 |
	| 1000009765 |
	| 1000009766 |
	| 1000009767 |
	| 1000009768 |
	| 1000009769 |
	| 1000009770 |
	| 1000009771 |
	| 1000009772 |
	| 1000009773 |
	| 1000009774 |
	| 1000009775 |
	| 1000009776 |
	| 1000009777 |
	| 1000009778 |
	| 1000009779 |
	| 1000009780 |
	| 1000009781 |
	| 1000009782 |
	| 1000009783 |
	| 1000009784 |
	| 1000009785 |
	| 1000009786 |
	| 1000009787 |
	| 1000009788 |
	| 1000009789 |
	| 1000009790 |
	| 1000009791 |
	| 1000009792 |
	| 1000009793 |
	| 1000009794 |
	| 1000009795 |
	| 1000009796 |
	| 1000009797 |
	| 1000009798 |
	| 1000009799 |
	| 1000009800 |
	| 1000009801 |
	| 1000009802 |
	| 1000009803 |
	| 1000009804 |
	| 1000009805 |
	| 1000009806 |
	| 1000009807 |
	| 1000009808 |
	| 1000009809 |
	| 1000009810 |
	| 1000009811 |
	| 1000009812 |
	| 1000009813 |
	| 1000009814 |
	| 1000009815 |
	| 1000009816 |
	| 1000009817 |
	| 1000009818 |
	| 1000009819 |
	| 1000009820 |
	| 1000009821 |
	| 1000009822 |
	| 1000009823 |
	| 1000009824 |
	| 1000009825 |
	| 1000009826 |
	| 1000009827 |
	| 1000009828 |
	| 1000009829 |
	| 1000009830 |
	| 1000009831 |
	| 1000009832 |
	| 1000009833 |
	| 1000009834 |
	| 1000009835 |
	| 1000009836 |
	| 1000009837 |
	| 1000009838 |
	| 1000009839 |
	| 1000009840 |
	| 1000009841 |
	| 1000009842 |
	| 1000009843 |
	| 1000009844 |
	| 1000009845 |
	| 1000009846 |
	| 1000009847 |
	| 1000009848 |
	| 1000009849 |
	| 1000009850 |
	| 1000009851 |
	| 1000009852 |
	| 1000009853 |
	| 1000009854 |
	| 1000009855 |
	| 1000009856 |
	| 1000009857 |
	| 1000009858 |
	| 1000009859 |
	| 1000009860 |
	| 1000009861 |
	| 1000009862 |
	| 1000009863 |
	| 1000009864 |
	| 1000009865 |
	| 1000009866 |
	| 1000009867 |
	| 1000009868 |
	| 1000009869 |
	| 1000009870 |
	| 1000009871 |
	| 1000009872 |
	| 1000009873 |
	| 1000009874 |
	| 1000009875 |
	| 1000009876 |
	| 1000009877 |
	| 1000009878 |
	| 1000009879 |
	| 1000009880 |
	| 1000009881 |
	| 1000009882 |
	| 1000009883 |
	| 1000009884 |
	| 1000009885 |
	| 1000009886 |
	| 1000009887 |
	| 1000009888 |
	| 1000009889 |
	| 1000009890 |
	| 1000009891 |
	| 1000009892 |
	| 1000009893 |
	| 1000009894 |
	| 1000009895 |
	| 1000009896 |
	| 1000009897 |
	| 1000009898 |
	| 1000009899 |
	| 1000009900 |
	| 1000009901 |
	| 1000009902 |
	| 1000009903 |
	| 1000009904 |
	| 1000009905 |
	| 1000009906 |
	| 1000009907 |
	| 1000009908 |
	| 1000009909 |
	| 1000009910 |
	| 1000009911 |
	| 1000009912 |
	| 1000009913 |
	| 1000009914 |
	| 1000009915 |
	| 1000009916 |
	| 1000009917 |
	| 1000009918 |
	| 1000009919 |
	| 1000009920 |
	| 1000009921 |
	| 1000009922 |
	| 1000009923 |
	| 1000009924 |
	| 1000009925 |
	| 1000009926 |
	| 1000009927 |
	| 1000009928 |
	| 1000009929 |
	| 1000009930 |
	| 1000009931 |
	| 1000009932 |
	| 1000009933 |
	| 1000009934 |
	| 1000009935 |
	| 1000009936 |
	| 1000009937 |
	| 1000009938 |
	| 1000009939 |
	| 1000009940 |
	| 1000009941 |
	| 1000009942 |
	| 1000009943 |
	| 1000009944 |
	| 1000009945 |
	| 1000009946 |
	| 1000009947 |
	| 1000009948 |
	| 1000009949 |
	| 1000009950 |
	| 1000009951 |
	| 1000009952 |
	| 1000009953 |
	| 1000009954 |
	| 1000009955 |
	| 1000009956 |
	| 1000009957 |
	| 1000009958 |
	| 1000009959 |
	| 1000009960 |
	| 1000009961 |
	| 1000009962 |
	| 1000009963 |
	| 1000009964 |
	| 1000009965 |
	| 1000009966 |
	| 1000009967 |
	| 1000009968 |
	| 1000009969 |
	| 1000009970 |
	| 1000009971 |
	| 1000009972 |
	| 1000009973 |
	| 1000009974 |
	| 1000009975 |
	| 1000009976 |
	| 1000009977 |
	| 1000009978 |
	| 1000009979 |
	| 1000009980 |
	| 1000009981 |
	| 1000009982 |
	| 1000009983 |
	| 1000009984 |
	| 1000009985 |
	| 1000009986 |
	| 1000009987 |
	| 1000009988 |
	| 1000009989 |
	| 1000009990 |
	| 1000009991 |
	| 1000009992 |
	| 1000009993 |
	| 1000009994 |
	| 1000009995 |
	| 1000009996 |
	| 1000009997 |
	| 1000009998 |
	| 1000009999 |
	| 1000010000 |
	| 1000010001 |
	| 1000010002 |
	| 1000010003 |
	| 1000010004 |
	| 1000010005 |
	| 1000010006 |
	| 1000010007 |
	| 1000010008 |
	| 1000010009 |
	| 1000010010 |
	| 1000010011 |
	| 1000010012 |
	| 1000010013 |
	| 1000010014 |
	| 1000010015 |
	| 1000010016 |
	| 1000010017 |
	| 1000010018 |
	| 1000010019 |
	| 1000010020 |
	| 1000010021 |
	| 1000010022 |
	| 1000010023 |
	| 1000010024 |
	| 1000010025 |
	| 1000010026 |
	| 1000010027 |
	| 1000010028 |
	| 1000010029 |
	| 1000010030 |
	| 1000010031 |
	| 1000010032 |
	| 1000010033 |
	| 1000010034 |
	| 1000010035 |
	| 1000010036 |
	| 1000010037 |
	| 1000010038 |
	| 1000010039 |
	| 1000010040 |
	| 1000010041 |
	| 1000010042 |
	| 1000010043 |
	| 1000010044 |
	| 1000010045 |
	| 1000010046 |
	| 1000010047 |
	| 1000010048 |
	| 1000010049 |
	| 1000010050 |
	| 1000010051 |
	| 1000010052 |
	| 1000010053 |
	| 1000010054 |
	| 1000010055 |
	| 1000010056 |
	| 1000010057 |
	| 1000010058 |
	| 1000010059 |
	| 1000010060 |
	| 1000010061 |
	| 1000010062 |
	| 1000010063 |
	| 1000010064 |
	| 1000010065 |
	| 1000010066 |
	| 1000010067 |
	| 1000010068 |
	| 1000010069 |
	| 1000010070 |
	| 1000010071 |
	| 1000010072 |
	| 1000010073 |
	| 1000010074 |
	| 1000010075 |
	| 1000010076 |
	| 1000010077 |
	| 1000010078 |
	| 1000010079 |
	| 1000010080 |
	| 1000010081 |
	| 1000010082 |
	| 1000010083 |
	| 1000010084 |
	| 1000010085 |
	| 1000010086 |
	| 1000010087 |
	| 1000010088 |
	| 1000010089 |
	| 1000010090 |
	| 1000010091 |
	| 1000010092 |
	| 1000010093 |
	| 1000010094 |
	| 1000010095 |
	| 1000010096 |
	| 1000010097 |
	| 1000010098 |
	| 1000010099 |
	| 1000010100 |
	| 1000010101 |
	| 1000010102 |
	| 1000010103 |
	| 1000010104 |
	| 1000010105 |
	| 1000010106 |
	| 1000010107 |
	| 1000010108 |
	| 1000010109 |
	| 1000010110 |
	| 1000010111 |
	| 1000010112 |
	| 1000010113 |
	| 1000010114 |
	| 1000010115 |
	| 1000010116 |
	| 1000010117 |
	| 1000010118 |
	| 1000010119 |
	| 1000010120 |
	| 1000010121 |
	| 1000010122 |
	| 1000010123 |
	| 1000010124 |
	| 1000010125 |
	| 1000010126 |
	| 1000010127 |
	| 1000010128 |
	| 1000010129 |
	| 1000010130 |
	| 1000010131 |
	| 1000010132 |
	| 1000010133 |
	| 1000010134 |
	| 1000010135 |
	| 1000010136 |
	| 1000010137 |
	| 1000010138 |
	| 1000010139 |
	| 1000010140 |
	| 1000010141 |
	| 1000010142 |
	| 1000010143 |
	| 1000010144 |
	| 1000010145 |
	| 1000010146 |
	| 1000010147 |
	| 1000010148 |
	| 1000010149 |
	| 1000010150 |
	| 1000010151 |
	| 1000010152 |
	| 1000010153 |
	| 1000010154 |
	| 1000010155 |
	| 1000010156 |
	| 1000010157 |
	| 1000010158 |
	| 1000010159 |
	| 1000010160 |
	| 1000010161 |
	| 1000010162 |
	| 1000010163 |
	| 1000010164 |
	| 1000010165 |
	| 1000010166 |
	| 1000010167 |
	| 1000010168 |
	| 1000010169 |
	| 1000010170 |
	| 1000010171 |
	| 1000010172 |
	| 1000010173 |
	| 1000010174 |
	| 1000010175 |
	| 1000010176 |
	| 1000010177 |
	| 1000010178 |
	| 1000010179 |
	| 1000010180 |
	| 1000010181 |
	| 1000010182 |
	| 1000010183 |
	| 1000010184 |
	| 1000010185 |
	| 1000010186 |
	| 1000010187 |
	| 1000010188 |
	| 1000010189 |
	| 1000010190 |
	| 1000010191 |
	| 1000010192 |
	| 1000010193 |
	| 1000010194 |
	| 1000010195 |
	| 1000010196 |
	| 1000010197 |
	| 1000010198 |
	| 1000010199 |
	| 1000010200 |
	| 1000010201 |
	| 1000010202 |
	| 1000010203 |
	| 1000010204 |
	| 1000010205 |
	| 1000010206 |
	| 1000010207 |
	| 1000010208 |
	| 1000010209 |
	| 1000010210 |
	| 1000010211 |
	| 1000010212 |
	| 1000010213 |
	| 1000010214 |
	| 1000010215 |
	| 1000010216 |
	| 1000010217 |
	| 1000010218 |
	| 1000010219 |
	| 1000010220 |
	| 1000010221 |
	| 1000010222 |
	| 1000010223 |
	| 1000010224 |
	| 1000010225 |
	| 1000010226 |
	| 1000010227 |
	| 1000010228 |
	| 1000010229 |
	| 1000010230 |
	| 1000010231 |
	| 1000010232 |
	| 1000010233 |
	| 1000010234 |
	| 1000010235 |
	| 1000010236 |
	| 1000010237 |
	| 1000010238 |
	| 1000010239 |
	| 1000010240 |
