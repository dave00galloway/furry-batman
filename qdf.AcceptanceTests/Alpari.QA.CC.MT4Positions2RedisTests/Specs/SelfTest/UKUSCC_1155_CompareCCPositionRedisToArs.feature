@CCDataContext @UKUSCC-1155
Feature: UKUSCC_1155_CompareCCPositionRedisToArs
	In order to compare position snapshots in different data sources
	As a CC Tester
	I want to get positions from different cc ars and cc redis

Scenario: Get data for cc redis and cc ars for eurusd C1
	Given I have a connection to CCDataContext
	When I get cc redis and cc ars position data for these snapshot parameters:-
	| server1 | server2 | Database1 | section | book | symbol | startTime           | endTime             |
	| C1      | C1Red   | cc_uat    | default | A    | EURUSD | 2014-10-29 17:36:00 | 2014-10-29 17:46:00 |
