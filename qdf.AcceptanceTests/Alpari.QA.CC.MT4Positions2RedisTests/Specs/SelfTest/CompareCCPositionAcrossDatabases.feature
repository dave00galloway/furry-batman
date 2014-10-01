@CCDataContext
Feature: CompareCCPositionAcrossDatabases
	In order to compare position snapshots in different databases
	As a CC Tester
	I want to get positions from differnt databases for the same server, symbol, etc

Scenario: Get data for qa and uat for eurusd mt5
	Given I have a connection to CCDataContext
	When I get position data for these snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| MT5    | default | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/01 15:10:00 | 

