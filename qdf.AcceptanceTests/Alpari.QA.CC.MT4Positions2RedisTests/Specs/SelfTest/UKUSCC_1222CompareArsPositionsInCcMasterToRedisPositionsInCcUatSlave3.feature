@UKUSCC_1222 @CCDataContextPool
Feature: UKUSCC_1222CompareArsPositionsInCcMasterToRedisPositionsInCcUatSlave3
	In order to reconcile Ars Snapshots with Redis Snapshots
	As a CC Tester
	I want to Compare Ars positions in cc@master to Redis Positions in cc_uat@slave3

Scenario: Create 2 connections 2 CC on different connection strings
	Given I have the following connections to cc:-
	| Connection1 | Connection2 |
	| CcMaster    | CcSlave     |
	Then the count of cc connections is 2
