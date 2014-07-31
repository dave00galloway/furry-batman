@UKUSQDF_156
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

Scenario: Map Trade with Event Ids to Mt5 Order Ids
	When I call QDF.GetAutoTradeswithEventID with ID 0 and save the result as a datatable
		And I launch the process and parse the order events from the console into orders and deals
		And I close the process using Ctrl+c in the StdInput
		# And I query the mt5 deals table for new deals for my login
		And I convert the trades with event ids to trades with deal and order ids
	Then all order events in the order event id to deal mapping dictionary are mapped to trades with event ids

Scenario: Map Trade with Event Ids to Mt5 Order Ids if they have them
	When I call QDF.GetAutoTradeswithEventID with ID 0 and save the result as a datatable
		And I launch the process and parse the order events from the console into orders and deals
		And I close the process using Ctrl+c in the StdInput
		# And I query the mt5 deals table for new deals for my login
		And I convert the trades with event ids to trades with deal and order ids if they exist
	Then at least one order event in the order event id to deal mapping dictionary is mapped to trades with event ids

@Mt5DealsContext
Scenario: Run 606.5Console and compare Mt5 deals against QDF
	Given I have stored the highest mt5 deal id for login '8900907'
	#When I call QDF.GetAutoTradeswithEventID with ID 0 and save the result as a datatable
	#	And I launch the process and parse the order events from the console into orders and deals
	#	And I close the process using Ctrl+c in the StdInput
	When I import auto hedged trades into MT5 starting at deal id 0
		# And I query the mt5 deals table for new deals for my login
		# And I convert the trades with event ids to trades with deal and order ids if they exist|ExcludedFields
		And I compare the MT5 deals against QDF except for these fields
		| ExcludedFields |
		| Deal           |
		| Login          |
		| Order          |

	Then the MT5 deals exactly match the QDF deals:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
	

