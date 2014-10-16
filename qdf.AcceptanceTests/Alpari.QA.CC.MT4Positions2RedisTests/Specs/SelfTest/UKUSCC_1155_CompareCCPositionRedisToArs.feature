@CCDataContext @UKUSCC_1155
Feature: UKUSCC_1155_CompareCCPositionRedisToArs
	In order to compare position snapshots in different data sources
	As a CC Tester
	I want to get positions from different cc ars and cc redis

#Scenario: Get data for cc redis and cc ars for eurusd C1
	#Given I have a connection to CCDataContext
	#When I get cc redis and cc ars position data for these snapshot parameters:-
	#| server1 | server2 | Database1 | section | book | symbol | startTime           | endTime             |
	#| C1      | C1Red   | cc_uat    | default | A    | EURUSD | 2014-10-29 17:36:00 | 2014-10-29 17:37:00 |

Scenario: Get data for cc redis and cc ars for various symbols C1
	Given I have a connection to CCDataContext
	When I get cc redis and cc ars position data for these sets of snapshot parameters:-
	| server1 | server2 | Database1 | section | book | symbol | startTime           | endTime             |
	| C1      | C1 Red  | cc_uat    | default | A    | EURUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C1      | C1 Red  | cc_uat    | default | A    | GBPUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C1      | C1 Red  | cc_uat    | default | A    | GBPJPY | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C1      | C1 Red  | cc_uat    | default | A    | USDCHF | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C1      | C1 Red  | cc_uat    | default | A    | EURCHF | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C1      | C1 Red  | cc_uat    | default | A    | USDJPY | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C1      | C1 Red  | cc_uat    | default | B    | EURUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C1      | C1 Red  | cc_uat    | default | B    | GBPUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C1      | C1 Red  | cc_uat    | default | B    | AUDCAD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C1      | C1 Red  | cc_uat    | default | B    | CL.X4  | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C1      | C1 Red  | cc_uat    | default | B    | XAUUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C1      | C1 Red  | cc_uat    | default | B    | XAGUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C1      | C1 Red  | cc_uat    | default | B    | USDJPY | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |

Scenario: Get data for cc redis and cc ars for various symbols C2
	Given I have a connection to CCDataContext
	When I get cc redis and cc ars position data for these sets of snapshot parameters:-
	| server1 | server2 | Database1 | section | book | symbol | startTime           | endTime             |
	| C2      | C2 Red  | cc_uat    | UK      | A    | EURUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | A    | GBPUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | A    | GBPJPY | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | A    | USDCHF | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | A    | EURCHF | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | A    | USDJPY | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | A    | XAUUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | A    | XAGUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | B    | EURUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | B    | GBPUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | B    | GBPJPY | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | B    | USDCHF | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | B    | EURCHF | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | B    | USDJPY | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | B    | XAUUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | B    | XAGUSD | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | B    | EUA.Z4 | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
	| C2      | C2 Red  | cc_uat    | UK      | B    | US30.Z | 2014/10/14 00:00:00 | 2014/10/15 14:20:00 |
