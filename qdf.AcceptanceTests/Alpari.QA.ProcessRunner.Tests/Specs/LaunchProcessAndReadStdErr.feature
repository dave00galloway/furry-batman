@UKUSQDF_145
Feature: LaunchProcessAndReadStdErr
	In order to launch external processes
	As a QDF Tester
	I want to be able to launch external processes and read std err

Scenario: Launch ConsoleApplicationToErr.exe
	Given I have the following process parameters
	| FileName                                                            | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
	| TestApplications\ManagedCode\ConsoleApp\ConsoleApplicationToErr.exe | false           | true                  | true                  | true                   | true           |
	When I launch the process
	Then the process is launched ok

Scenario: Launch ConsoleApplicationToErr and read output
	Given I have the following process parameters
	| FileName                                                            | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
	| TestApplications\ManagedCode\ConsoleApp\ConsoleApplicationToErr.exe | false           | true                  | true                  | true                   | true           |
	When I launch the process
	Then the process is launched ok
	And the standard error output contains text "Hello World! (iteration9)"
