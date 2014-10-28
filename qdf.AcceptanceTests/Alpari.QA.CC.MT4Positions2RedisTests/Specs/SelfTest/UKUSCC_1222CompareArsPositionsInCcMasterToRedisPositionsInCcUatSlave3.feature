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
