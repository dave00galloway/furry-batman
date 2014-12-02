@UKUSCC_1222 @CCDataContextPool
Feature: UKUSCC_1222CompareArsPositionsInCcMasterToRedisPositionsInCcUatSlave3
	In order to reconcile Ars Snapshots with Redis Snapshots
	As a CC Tester
	I want to Compare Ars positions in cc@master to Redis Positions in cc_uat@slave3

Background: Setup Connection pool
	Given I have the following connections to cc:-
	| Connection1 | Connection2 |
	| CcMaster    | CcSlave     |

#If I want to compare snapshots of Pro and Pro Red, or M2 and M2 Red for the current UAT build, which DB do I get the snapshots from, and where do I get the server IDs from?
#compare cc@master to cc_uat@slave3
#list of servers in tbl_server table
Scenario: Create 2 connections 2 CC on different connection strings
	Then the count of cc connections is 2

Scenario: Get sample snapshot data from C1
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	| server1 | server2 | Database1 | Database2 | Connection1 | Connection2 | section | book | symbol | startTime           | endTime             |
	| C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURUSD | 2014/10/27 12:00:00 | 2014/10/27 12:10:00 |
	Then the snapshot comparison list contains 11 results
#ok, but bug raised. C:\Reports\20141029092251838\UKUSCC_1222CompareArsPositionsInCcMasterToRedisPositionsInCcUatSlave3\DoC1Comparison
Scenario: Do C1 Comparison
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	 | server1 | server2 | Database1 | Database2 | Connection1 | Connection2 | section | book | symbol | startTime           | endTime             |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURUSD | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDCHF | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURCHF | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDJPY | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | EURUSD | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | AUDCAD | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | CL.X4  | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAGUSD | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
	 | C1      | C1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | USDJPY | 2014/10/28 17:00:00 | 2014/10/29 09:20:00 |
#no positions speak to sergey
Scenario: Do C2 Comparison 
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	| server1 | server2 | Database1 | Database2 | Connection1 | Connection2 | section | book | symbol | startTime           | endTime             |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | EURUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | USDCHF | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | EURCHF | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | USDJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | XAGUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | EURUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | USDCHF | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | EURCHF | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | USDJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | XAGUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | EUA.Z4 | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| C2      | C2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | US30.Z | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
#ok - see C:\Reports\20141030151029084\UKUSCC_1222CompareArsPositionsInCcMasterToRedisPositionsInCcUatSlave3\DoCBojComparison
Scenario: Do CBoj Comparison
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	| server1 | server2  | Database1 | Database2 | Connection1 | Connection2 | section | book | symbol | startTime           | endTime             |
	| CBoJ    | CBoJ Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | EURUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| CBoJ    | CBoJ Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| CBoJ    | CBoJ Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| CBoJ    | CBoJ Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | USDCHF | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| CBoJ    | CBoJ Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | EURCHF | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| CBoJ    | CBoJ Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | USDJPY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| CBoJ    | CBoJ Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| CBoJ    | CBoJ Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAGUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |

#USDJPY was out between 28/10/2014 21:59 and 28/10/2014 22:14. keep an eye on this. There had been a redeploy so that may explain it.
#C:\Reports\20141030153158837\UKUSCC_1222CompareArsPositionsInCcMasterToRedisPositionsInCcUatSlave3\DoJpnComparison
Scenario: Do Jpn Comparison
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	| server1 | server2 | Database1 | Database2 | Connection1 | Connection2 | section | book | symbol | startTime           | endTime             |
	| JPN     | JPN Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| JPN     | JPN Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| JPN     | JPN Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| JPN     | JPN Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDCHF | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| JPN     | JPN Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURCHF | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| JPN     | JPN Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDJPY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| JPN     | JPN Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | EURJPY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| JPN     | JPN Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | AUDUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |

#M1 check out EURUSD A 30/10/2014 12:50  30/10/2014 12:51 was out by 1 lot for 2 minutes
#C:\Reports\20141030155736637\UKUSCC_1222CompareArsPositionsInCcMasterToRedisPositionsInCcUatSlave3\DoM1Comparison
Scenario: Do M1 Comparison
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	| server1 | server2 | Database1 | Database2 | Connection1 | Connection2 | section | book | symbol | startTime           | endTime             |
	| M1      | M1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | AUDUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M1      | M1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M1      | M1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M1      | M1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M1      | M1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDCHF | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M1      | M1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURCHF | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M1      | M1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDJPY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M1      | M1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M1      | M1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | XAGUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M1      | M1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | CADSGD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M1      | M1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M1      | M1 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAGUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |

#29/10/2014 18:04 to 29/10/2014  18:21:00 USDMXN - redis was behind then caught up. need to check trades at this time
Scenario: Do M2 Comparison
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	| server1 | server2 | Database1 | Database2 | Connection1 | Connection2 | section | book | symbol | startTime           | endTime             |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAGUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDCHF | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURCHF | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDJPY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | ZARJPY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDMXN | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | USDJPY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAGUSD | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | EURJPY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |
	| M2      | M2 Red  | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | EURTRY | 2014/10/28 17:00:00 | 2014/10/30 15:06:00 |

Scenario: Do MENA Comparison
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	| server1 | server2  | Database1 | Database2 | Connection1 | Connection2 | section | book | symbol  | startTime           | endTime             |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | GBPUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | GBPJPY  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDCHF  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURCHF  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDJPY  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | XAUUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | EURUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | GBPUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | USDJPY  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAUUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAGUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | NQ100.Z | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MENA    | MENA Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | US30.Z  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |

Scenario: Do MK1 Comparison
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	| server1 | server2 | Database1 | Database2 | Connection1 | Connection2 | section | book | symbol  | startTime           | endTime             |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | GBPUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | GBPJPY  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDCHF  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | EURCHF  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDJPY  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | XAUUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | EURUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | GBPUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | GBPJPY  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | USDCHF  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | EURCHF  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | USDJPY  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAUUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAGUSD  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | UK100.Z | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MK1     | MK1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | US30.Z  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |

Scenario: Do MSCov Comparison
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	| server1 | server2  | Database1 | Database2 | Connection1 | Connection2 | section | book | symbol | startTime           | endTime             |
	| MS Cov  | MS Cov R | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | USDJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MS Cov  | MS Cov R | cc        | cc_uat    | CcMaster    | CcSlave     | default | A    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MS Cov  | MS Cov R | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | USDJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| MS Cov  | MS Cov R | cc        | cc_uat    | CcMaster    | CcSlave     | default | B    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |

Scenario: Do Pro Comparison
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	| server1 | server2 | Database1 | Database2 | Connection1 | Connection2 | section | book | symbol | startTime           | endTime             |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | JP      | A    | EURUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | JP      | A    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | JP      | A    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | JP      | A    | USDCHF | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | JP      | A    | USDJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | JP      | B    | EURUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | JP      | B    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | EURUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | USDCHF | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | EURCHF | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | USDJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | A    | XAGUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | EURUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | USDCHF | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | EURCHF | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | USDJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | XAGUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | SI.Z4  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | UK      | B    | US30.Z | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | A    | EURUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | A    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | A    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | A    | USDCHF | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | A    | EURCHF | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | A    | USDJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | GBPUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | GBPJPY | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | XAUUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | XAGUSD | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |
	| Pro     | Pro Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | CL.X4  | 2014/10/28 17:00:00 | 2014/10/31 13:00:00 |

Scenario: Do SB1 Comparison
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	| server1 | server2 | Database1 | Database2 | Connection1 | Connection2 | section | book | symbol  | startTime           | endTime             |
	| SB1     | SB1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | EURUSD  | 2014/10/28 17:00:00 | 2014/10/02 15:00:00 |
	| SB1     | SB1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | GBPUSD  | 2014/10/28 17:00:00 | 2014/10/02 15:00:00 |
	| SB1     | SB1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | GBPJPY  | 2014/10/28 17:00:00 | 2014/10/02 15:00:00 |
	| SB1     | SB1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | USDCHF  | 2014/10/28 17:00:00 | 2014/10/02 15:00:00 |
	| SB1     | SB1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | EURCHF  | 2014/10/28 17:00:00 | 2014/10/02 15:00:00 |
	| SB1     | SB1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | USDJPY  | 2014/10/28 17:00:00 | 2014/10/02 15:00:00 |
	| SB1     | SB1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | UK100.Z | 2014/10/28 17:00:00 | 2014/10/02 15:00:00 |
	| SB1     | SB1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | B.X4    | 2014/10/28 17:00:00 | 2014/10/02 15:00:00 |
	| SB1     | SB1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | FRA40.V | 2014/10/28 17:00:00 | 2014/10/02 15:00:00 |
	| SB1     | SB1 Red | cc        | cc_uat    | CcMaster    | CcSlave     | US      | B    | HG.V4   | 2014/10/28 17:00:00 | 2014/10/02 15:00:00 |


Scenario: Do ADS STP Comparison
	When I get cc redis and cc ars position data across db connections for these sets of snapshot parameters:-
	| Server1 | Server2   | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| ADS STP | ADS STP R | cc        | cc_uat    | CcMaster    | CcSlave     | B    | Default | EURUSD | 2014-11-28 09:30:00 | 2014-11-28 10:00:00 |