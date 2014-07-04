@UKUSQDF_93
Feature: UKUSQDF-93 [AT] Cnx2Redis Data Collector - Track QDF Hedge Trades through Cnx2Redis
	In order to test that demo hedge trades are placed on cnx
	As a QDF Analyst
	I want to find all trades that the QDF demo account has placed in QDF.Orders

Scenario: Compare all trades in cnx-deals and QDF.Orders
	Given I have the following search criteria for qdf deals
		| DealSource | ConvertedStartTime   | ConvertedEndTime     |
		| cnx-deals  | 03/07/2014  15:30:55 | 03/07/2014  15:35:46 |
	When I call QDF.GetTradeswithEventIDProc with ID 0
		And I save the QDF.GetTradeswithEventIDProc result as a datatable
		And I retrieve the qdf deal data
		And I save the qdf deal data as a TradeEventWithId datatable
		And I compare TradeWithEventId deals with the qdf deal data excluding these fields:
         | ExcludedFields |
         | OrderEventID   |
         | Comment        |
	Then the TradeWithEventId deals should match the qdf deal data exactly 
