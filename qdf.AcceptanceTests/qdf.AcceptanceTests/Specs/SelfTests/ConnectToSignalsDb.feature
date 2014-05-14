Feature: ConnectToSignalsDb
	In order to get comparison data
	As a Tester
	I want to be able to get data from the SignalsDB

@mytag
Scenario: Get a server name from Signals DB
	Given I have connected to SignalsCompareData
	When I query SignalsCompareData for server "Mt4Pro"
	Then the server should be "Mt4Pro"
