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
		| login      | tradeInstruction                       | quantity |
		| 1000000001 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000002 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000003 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000004 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000005 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000006 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000007 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000008 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000009 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000010 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000011 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000012 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000013 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000014 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000015 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000016 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000017 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000018 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000019 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000020 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000021 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000022 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000023 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000024 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000025 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000026 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000027 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000028 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000029 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000030 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000031 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000032 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000033 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000034 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000035 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000036 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000037 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000038 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000039 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000040 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000041 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000042 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000043 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000044 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000045 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000046 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000047 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000048 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000049 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000050 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000051 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000052 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000053 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000054 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000055 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000056 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000057 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000058 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000059 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000060 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000061 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000062 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000063 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000064 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000065 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000066 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000067 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000068 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000069 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000070 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000071 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000072 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000073 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000074 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000075 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000076 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000077 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000078 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000079 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000080 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000081 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000082 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000083 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000084 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000085 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000086 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000087 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000088 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000089 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000090 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000091 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000092 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000093 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000094 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000095 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000096 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000097 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000098 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000099 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000100 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000101 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000102 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000103 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000104 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000105 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000106 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000107 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000108 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000109 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000110 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000111 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000112 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000113 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000114 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000115 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000116 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000117 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000118 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000119 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000120 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000121 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000122 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000123 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000124 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000125 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000126 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000127 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000128 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000129 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000130 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000131 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000132 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000133 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000134 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000135 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000136 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000137 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000138 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000139 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000140 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000141 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000142 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000143 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000144 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000145 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000146 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000147 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000148 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000149 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000150 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000151 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000152 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000153 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000154 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000155 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000156 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000157 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000158 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000159 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000160 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000161 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000162 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000163 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000164 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000165 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000166 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000167 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000168 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000169 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000170 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000171 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000172 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000173 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000174 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000175 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000176 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000177 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000178 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000179 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000180 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000181 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000182 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000183 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000184 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000185 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000186 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000187 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000188 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000189 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000190 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000191 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000192 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000193 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000194 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000195 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000196 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000197 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000198 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000199 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000200 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000201 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000202 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000203 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000204 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000205 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000206 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000207 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000208 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000209 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000210 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000211 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000212 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000213 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000214 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000215 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000216 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000217 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000218 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000219 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000220 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000221 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000222 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000223 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000224 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000225 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000226 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000227 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000228 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000229 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000230 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000231 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000232 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000233 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000234 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000235 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000236 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000237 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000238 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000239 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000240 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000241 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000242 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000243 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000244 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000245 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000246 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000247 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000248 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000249 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000250 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000251 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000252 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000253 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000254 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000255 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000256 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000257 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000258 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000259 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000260 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000261 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000262 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000263 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000264 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000265 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000266 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000267 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000268 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000269 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000270 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000271 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000272 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000273 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000274 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000275 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000276 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000277 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000278 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000279 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000280 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000281 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000282 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000283 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000284 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000285 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000286 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000287 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000288 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000289 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000290 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000291 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000292 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000293 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000294 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000295 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000296 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000297 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000298 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000299 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000300 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000301 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000302 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000303 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000304 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000305 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000306 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000307 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000308 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000309 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000310 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000311 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000312 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000313 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000314 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000315 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000316 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000317 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000318 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000319 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000320 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000321 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000322 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000323 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000324 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000325 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000326 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000327 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000328 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000329 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000330 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000331 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000332 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000333 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000334 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000335 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000336 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000337 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000338 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000339 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000340 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000341 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000342 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000343 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000344 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000345 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000346 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000347 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000348 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000349 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000350 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000351 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000352 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000353 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000354 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000355 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000356 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000357 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000358 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000359 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000360 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000361 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000362 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000363 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000364 | buy volume=345 symbol=EURUSD price=1.5 | 150      |
		| 1000000365 | buy volume=345 symbol=EURUSD price=1.5 | 150      |

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
