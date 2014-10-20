Feature: AddAccountsUsingManagerAPI
	In order to set up test data
	As a CC tester
	I want to be able to add accounts via MT4 manager API

Scenario: Add account to staging pro
	Given I have connected to the MT4 Manger API:-
		| server           | login | password |
		| 10.10.144.25:443 | 95    | 1q2w3e   |
	When I copy account 7003906 using manager API

Scenario: Add account to test micro 2
	Given I have connected to the MT4 Manger API:-
		| server           | login | password |
		| 10.10.144.24:443 | 95    | 1q2w3e   |
	When I add an account using manager API


Scenario: Copy account to MT4 Demo Classic
	Given I have connected to the MT4 Manger API:-
		| server           | login | password |
		| 10.10.144.27:443 | 95    | 1q2w3e   |
	When I copy account 4000903 using manager API