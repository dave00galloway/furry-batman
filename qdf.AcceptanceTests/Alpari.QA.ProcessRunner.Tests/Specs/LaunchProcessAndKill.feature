Feature: LaunchProcessAndKill
	In order to close processes not launched by the current test
	As a tester
	I want to be able to close named processes

Scenario: launch unmanaged process and kill by name
	Given I have the following process parameters
	| FileName                                                   | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
	| TestApplications\UnManagedCode\6.11ForLoop\6.11ForLoop.exe | false           | false                 | true                  | true                   | true           |
	When I launch the process
	Then the process is launched ok
	When I kill the process by name "6.11ForLoop.exe"
	Then there are no processes called "6.11ForLoop.exe" running
