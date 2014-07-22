@UKUSQDF_145
Feature: UKUSQDF-145LaunchProcessesAndReadOutput
	In order to launch external processes
	As a QDF Tester
	I want to be able to launch external processes and read output

Scenario: Launch cmd.exe 1
	Given I have the following process parameters
	| FileName | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput |
	| cmd.exe  | false           | true                  | true                  | true                   |
	When I launch the process
	Then the process is launched ok

Scenario: Launch cmd.exe 2
	Given I have the following process parameters
	| FileName | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput |
	| cmd.exe  | false           | true                  | true                  | true                   |
	When I launch the process
	Then the process is launched ok

Scenario: Launch cmd.exe 3
	Given I have the following process parameters
	| FileName | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput |
	| cmd.exe  | false           | true                  | true                  | true                   |
	When I launch the process
	Then the process is launched ok
# test name frigged to make this test run first
Scenario: a Launch cmd.exe and read output
	Given I have the following process parameters
	| FileName | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput |
	| cmd.exe  | false           | true                  | true                  | true                   |
	When I launch the process
	Then the process is launched ok
	And the standard output contains text "Microsoft Windows [Version 6.1.7601]"
	And the standard output contains text "Copyright (c) 2009 Microsoft Corporation.  All rights reserved."

#fails. not sure why
Scenario: Launch cmd.exe and read output
	Given I have the following process parameters
	| FileName | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput |
	| cmd.exe  | false           | false                  | true                  | true                   |
	When I launch the process
	Then the process is launched ok
	And the standard output contains text "Microsoft Windows [Version 6.1.7601]"
	And the standard output contains text "Copyright (c) 2009 Microsoft Corporation.  All rights reserved."

Scenario: Launch cmd.exe and create input and read output
	Given I have the following process parameters
	| FileName | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput |
	| cmd.exe  | false           | false                  | true                  | true                   |
	When I launch the process
	And I send the command "dir" to standard input
	Then the standard output contains text "Directory of"
