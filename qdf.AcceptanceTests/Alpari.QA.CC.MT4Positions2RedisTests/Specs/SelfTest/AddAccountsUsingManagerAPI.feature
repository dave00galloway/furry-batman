Feature: AddAccountsUsingManagerAPI
	In order to set up test data
	As a CC tester
	I want to be able to add accounts via MT4 manager API

Scenario: Add account
	Given I have connected to the MT4 Manger API:-
		| server           | login | password |
		| 10.10.144.25:443 | 95    | 1q2w3e   |
	When I copy account 7003906 using manager API
