@UKUSQDF_156
Feature: UKUSQDF-156AutomateTestingOfSix06ConsoleApp
	In order to avoid silly mistakes
	As a math idiot
	I want to be told the sum of two numbers

Scenario: Launch 606.5Console
	Given I have the following process parameters
	| FileName                              | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
	| AUT\QDF\606.5Console\606.5Console.exe | false           | true                  | true                  | false                   | true           |
	When I launch the process
	Then the process is launched ok

Scenario: Launch 606.5Console and check config loaded
	Given I have the following process parameters
	| FileName                              | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
	| AUT\QDF\606.5Console\606.5Console.exe | false           | true                  | true                  | false                   | true           |
	When I launch the process
	Then the process is launched ok
	And the standard error output contains text "get_config: success"

Scenario: Launch 606.5Console and check SqlState
	Given I have the following process parameters
	| FileName                              | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
	| AUT\QDF\606.5Console\606.5Console.exe | false           | true                  | true                  | false                   | true           |
	When I launch the process
	Then the process is launched ok
	And the standard error output contains text "SQLSTATE: 01000"
