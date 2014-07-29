@UKUSQDF_156 @Mt5DealsContext
Feature: UKUSQDF-156CheckDataInMt5Database
	In order to check deals have been successfully inserted into MT5
	As a QDF Tester
	I want to be able to query deal data from MT5

Background: 
	Given I have the following process parameters
		| FileName                              | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
		| AUT\QDF\606.5Console\606.5Console.exe | false           | true                  | true                  | false                  | true           |

Scenario: Get Highest Deal ID for Login
	Given I am using mt5 manager login '8900907'
	When I get the highest mt5 deal id for my login
	Then The highest mt5 deal id is greater than 1

Scenario: Check the highest deal id increases after running the console app
	Given I have stored the highest mt5 deal id for login '8900907'
	When I launch the process and parse the order events from the console into orders and deals
	Then the new highest mt5 deal id is greater than the original

Scenario: Map Mt5Deals
	Given I have stored the highest mt5 deal id for login '8900907'
	When I launch the process and parse the order events from the console into orders and deals
	And I close the process using Ctrl+c in the StdInput
	And I query the mt5 deals table for new deals for my login

