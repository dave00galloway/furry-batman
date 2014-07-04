@UKUSQDF_93
Feature: ConnectToGetTradeswithEventIDProc
	In order to test that demo hedge trades are placed on cnx
	As a QDF tester
	I want to find all trades that the QDF demo account has placed in QDF.Orders

Scenario: Connect to stored proc
	Given I have a connection to QDF.GetTradeswithEventIDProc
	When I call QDF.GetTradeswithEventIDProc with ID 0
	Then at least one order and event are returned

Scenario: Connect to stored proc and save results as datatable
	Given I have a connection to QDF.GetTradeswithEventIDProc
	When I call QDF.GetTradeswithEventIDProc with ID 0
		And I save the QDF.GetTradeswithEventIDProc result as a datatable
	Then the QDF.GetTradeswithEventIDProc data table contains at least one result

Scenario: Connect to stored proc and select a single result for comparison
	Given I have a connection to QDF.GetTradeswithEventIDProc
	When I call QDF.GetTradeswithEventIDProc with ID 0
		And I save the QDF.GetTradeswithEventIDProc result as a datatable
		And I save the TradeWithEventId with ExecId "B201418404S6E00"
	Then the SelectedTradeWithEventIdTable contains 1 row
		And the SelectedTradeWithEventIdTable contains a TradeWithEventId with an ExecId of "B201418404S6E00"

Scenario: Select a single result from qdf redis cnx-deals
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 03/07/2014  15:30:54 | 03/07/2014  15:30:56 |
	When I retrieve the qdf deal data
	And I save the qdf deal data as a TradeEventWithId datatable

#Scenario: Connect to stored proc and compare with a select a single result from qdf redis cnx-deals
#	Given I have a connection to QDF.GetTradeswithEventIDProc
#	And I have the following search criteria for qdf deals
#	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
#	 | cnx-deals  | 03/07/2014  15:30:54 | 03/07/2014  15:30:56 |
#	When I call QDF.GetTradeswithEventIDProc with ID 0
#		And I save the QDF.GetTradeswithEventIDProc result as a datatable
#		And I save the TradeWithEventId with ExecId "B201418404S6E00"
#		And I retrieve the qdf deal data
#	Then the SelectedTradeWithEventIdTable contains 1 row
#		And the SelectedTradeWithEventIdTable contains a TradeWithEventId with an ExecId of "B201418404S6E00"