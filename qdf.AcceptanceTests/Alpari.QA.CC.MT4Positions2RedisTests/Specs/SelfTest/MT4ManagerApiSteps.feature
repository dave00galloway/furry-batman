Feature: MT4ManagerApiSteps
	In order to simulate advanced trading actions in MT4
	As a CC tester
	I want to be able to use the MT4Manger API

Scenario: Connect to MT4 Manager API
	Given I have connected to the MT4 Manger API:-
		| server           | login | password |
		| 10.10.144.25:443 | 95    | 1q2w3e   |
	When I query open positions for user "7003906"

