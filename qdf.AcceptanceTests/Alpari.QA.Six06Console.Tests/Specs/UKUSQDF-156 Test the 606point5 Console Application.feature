@UKUSQDF_156
Feature: UKUSQDF-156AutomateTestingOfSix06ConsoleApp
	In order to provide a log of auto hedged trades
	As a QDF Analyst
	I want to be able to view autohedged trades copied from QDF database and inserted into MT5

Background: Setup 606.5 console parameters
	Given I have the following process parameters
	| FileName                              | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
	| AUT\QDF\606.5Console\606.5Console.exe | false           | true                  | true                  | false                  | true           |

Scenario: Launch 606.5Console and check deals against stored proc results
	When I call QDF.GetAutoTradeswithEventID with ID 0 and save the result as a datatable
	And I launch the process and parse the order events from the console into orders and deals
	Then the order Event ID to deal mapping dictionary contains all the deals returned by QDF.GetAutoTradeswithEventID 

@Mt5DealsContext
Scenario: Run 606.5Console and compare Mt5 deals against QDF
	Given I have stored the highest mt5 deal id for login '8900907'
	When I import auto hedged trades into MT5 starting at deal id 0
		And I compare the MT5 deals against QDF except for these fields
		| ExcludedFields   |
		| Deal             |
		| login            |
		| Order            |
		| ExecID           |
		| OrderTimeTypeID  |
		| OrderPriceTypeID |

	Then the MT5 deals exactly match the QDF deals:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |