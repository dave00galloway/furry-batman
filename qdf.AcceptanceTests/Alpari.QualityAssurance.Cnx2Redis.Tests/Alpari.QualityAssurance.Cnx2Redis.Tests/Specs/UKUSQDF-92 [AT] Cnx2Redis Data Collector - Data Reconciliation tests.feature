@UKUSQDF_92
Feature: UKUSQDF-92 [AT] Cnx2Redis Data Collector - Data Reconciliation tests
	In order to test Cnx2Redis
	As a QDF Tester
	I want to be able to compare data from MySql and Redis

Scenario: Compare last day's data
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 25/06/2014  00:00:00 | 19/06/2014  17:44:16 |
	 When I retrieve the qdf deal data
	 And I query cnx trade by trade id for these trade ids:
	 | DealId          |
	 | B201417005FFD00 |
	 | B201417005FFN00 |
	 | B201417005FFR00 |
	 | B201417005FFU00 |
	 | B201417005FFX00 |
	 | B201417005FG000 |
	 | B201417005FG300 |
	 | B201417005FR400 |
	 | B201417005FS100 |
	 | B201417005FS400 |
	 | B201417005FTC00 |
	 And I compare the cnx trade deals with the qdf deal data excluding these fields:
	 | ExcludedFields |
	 | OrderId        |
	 | Side           | 
	 Then the cnx trade deals should match the qdf deal data exactly 
