﻿@UKUSQDF_156
Feature: UKUSQDF-156AutomateTestingOfSix06ConsoleApp
	In order to test the 606.5 Console App
	As a QDF Tester
	I want to be able to launch the console and read its output

Background: Setup 606.5 console parameters
	Given I have the following process parameters
	| FileName                              | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
	| AUT\QDF\606.5Console\606.5Console.exe | false           | true                  | true                  | false                  | true           |

Scenario: Launch 606.5Console
	When I launch the process
	Then the process is launched ok

Scenario: Launch 606.5Console and check config loaded
	When I launch the process
	Then the process is launched ok
	And the standard error output contains text "get_config: success"

Scenario: Launch 606.5Console and check SqlState
	When I launch the process
	Then the process is launched ok
	And the standard error output contains text "SQLSTATE: 01000"

Scenario: Launch 606.5Console and check Sql Executed ok
	When I launch the process
	Then the process is launched ok
	And the standard error output contains text "SQLExecDirect: success"
	And the standard error output contains text ">"
	And the standard error output contains text "waiting 2 seconds.."

Scenario: Launch 606.5Console and parse deal mapping
	When I launch the process
	And I parse the order events from the console into orders and deals
	Then the order Event ID to deal mapping dictionary contains at least 1 record

Scenario: Call 606.5 Stored Proc and retrieve deals from qdf database
	Given I have a connection to QDF.GetTradeswithEventIDProc
	When I call QDF.GetAutoTradeswithEventID with ID 0
		And I save the QDF.GetAutoTradeswithEventID result as a datatable
	Then the QDF.GetAutoTradeswithEventID data table contains at least one result

Scenario: Launch 606.5Console and check deals against stored proc results
	When I call QDF.GetAutoTradeswithEventID with ID 0 and save the result as a datatable
	And I launch the process and parse the order events from the console into orders and deals
	Then the order Event ID to deal mapping dictionary contains all the deals returned by QDF.GetAutoTradeswithEventID 

Scenario: Launch 606.5Console and close the process gracefully
	When I launch the process
	And I close the process using Ctrl+c in the StdInput
	Then the process is closed ok

