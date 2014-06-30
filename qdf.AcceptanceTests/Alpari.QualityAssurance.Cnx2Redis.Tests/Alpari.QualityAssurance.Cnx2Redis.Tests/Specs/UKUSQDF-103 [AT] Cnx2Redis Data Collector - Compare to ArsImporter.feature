@UKUSQDF_103
Feature: UKUSQDF-103 [AT] Cnx2Redis Data Collector - Compare to ArsImporter
	In order to test Cnx2Redis
	As a QDF Tester
	I want to be able to compare data from Redis cnx-deals and Redis deals

Scenario: Compare last day's data
	Given I have the following search criteria for qdf deals
	 | DealSource | StartTime | EndTime |
	 | cnx-deals  | -1D       | +1D     |
	 When I retrieve the qdf deal data
	 And I query cnx trade by using the same deal search criteria
	 And I compare the cnx trade deals with the qdf deal data excluding these fields:
	 | ExcludedFields |
	 | Side           | 
	 Then the cnx trade deals should match the qdf deal data exactly 
