@UKUSQDF_80
Feature: CompareCnxHubCsvWithRedisCnxDeals
	In order to reconcile cnx and redis data
	As a QDF Analyst
	I want to compare Cnx Hub data with Redis data

Scenario: Load cnx hub data and compare with Qdf deals
	Given I have loaded cnx hub data from "C:\TEMP\Alpari UK_TradeActivity_20140531.csv"
	And I have the following search criteria for qdf deals
	 | Server   | ConvertedStartTime   | ConvertedEndTime     |
	 | Currenex | 01/05/2014  00:00:00 | 31/05/2014  23:59:59 |
	When I retrieve the qdf deal data
	And I compare the cnx hub data and the qdf deals
	Then cnx hub deals missing from qdf deals are output to "Load cnx hub data and compare with Qdf deals.csv"
