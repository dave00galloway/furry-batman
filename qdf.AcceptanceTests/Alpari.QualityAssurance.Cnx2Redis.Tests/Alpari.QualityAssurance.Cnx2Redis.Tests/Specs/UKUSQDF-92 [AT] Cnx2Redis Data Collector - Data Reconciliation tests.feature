@UKUSQDF_92
Feature: UKUSQDF-92 [AT] Cnx2Redis Data Collector - Data Reconciliation tests
	In order to test Cnx2Redis
	As a QDF Tester
	I want to be able to compare data from MySql and Redis

Scenario: Compare last day's data
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 25/06/2014  00:00:00 | 25/06/2014  23:59:59 |
	 When I retrieve the qdf deal data
		 And I query cnx trade by trade id from "25/06/2014 00:00:00" to "25/06/2014 23:59:59"
		 And I compare the cnx trade deals with the qdf deal data excluding these fields:
		 | ExcludedFields |
		 | OrderId        |
		 | Side           | 
	 Then the cnx trade deals should match the qdf deal data exactly 
