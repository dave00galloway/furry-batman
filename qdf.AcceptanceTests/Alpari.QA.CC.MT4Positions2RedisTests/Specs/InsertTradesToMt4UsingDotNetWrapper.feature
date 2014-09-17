Feature: InsertTradesToMt4UsingDotNetWrapper
	In order to test MT4P2R
	As a CC Tester
	I want to insert trades progammatically to MT4

Scenario: Open Positions in MT4
	Given I have a client connection to MT4:-
		| server           | login   | password |
		| 10.10.144.25:443 | 7003906 | Trader   |
	When I open a position:-
		| symbol | command | amount |
		| EURUSD | Buy     | 100    |
	#Then the result should be 120 on the screen
	And I disconnect the client
