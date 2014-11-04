@UKUSCC_1236 @CCDataContextPool @Mt4ArsPositionsContext
Feature: UKUSCC_1236CompareClientPositions
	In order to find discrepancies in redis and ars open positions
	As a CC tester
	I want to compare cc_sp_get_client_positions between cc@master and cc_uat@slave3

Background: Setup Connection pool
	Given I have the following connections to cc:-
	| Connection1 | Connection2 |
	| CcMaster    | CcSlave     |

Scenario: Create 2 connections 2 CC on different connection strings
	Then the count of cc connections is 2

Scenario: Compare C1 Client Positions
	When I compare cc redis and cc ars client position data across db connections for these sets of snapshot parameters:-
	| server1 | server2   | Database1 | Database2 | Connection1 | Connection2                |
	| C1      | MT4AUKC01 | cc        | 11        | CcMaster    | uk-redis-cc1.dc.alpari.com |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |