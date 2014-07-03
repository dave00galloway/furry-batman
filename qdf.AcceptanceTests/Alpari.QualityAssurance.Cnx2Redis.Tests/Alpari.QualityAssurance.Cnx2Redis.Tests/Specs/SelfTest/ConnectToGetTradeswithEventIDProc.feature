@UKUSQDF_93
Feature: ConnectToGetTradeswithEventIDProc
	In order to test that demo hedge trades are placed on cnx
	As a QDF tester
	I want to find all trades that the QDF demo account has placed in QDF.Orders

Scenario: Connect to stored proc
	Given I have a connection to QDF.GetTradeswithEventIDProc
	When I call QDF.GetTradeswithEventIDProc with ID 0
	Then at least one order and event are returned
