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

Scenario: Kill unmanaged process by name
	When I kill the process by name "WerFault.exe"
	Then there are no processes called "WerFault.exe" running

Scenario: launch taskkill process and kill by name
	Given I have the following process parameters
	| FileName     | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow | Arguments                |
	| taskkill.exe | false           | false                 | true                  | true                   | true           | /F /T /IM "WerFault.exe" |
	When I launch the process
	Then the process is launched ok
	When I kill the process by name "taskkill.exe"
	Then there are no processes called "taskkill.exe" running

Scenario: Launch cmd.exe
	Given I have the following process parameters
	| FileName | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
	| cmd.exe  | false           | False                 | true                  | true                   | true           |
	When I launch the process
	Then the process is launched ok
	When I kill the process by name "cmd.exe"
	Then there are no processes called "cmd.exe" running
