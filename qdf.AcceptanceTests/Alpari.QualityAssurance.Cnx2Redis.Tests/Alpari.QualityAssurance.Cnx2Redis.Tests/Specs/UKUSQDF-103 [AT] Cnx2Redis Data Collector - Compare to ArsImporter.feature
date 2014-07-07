@UKUSQDF_103
Feature: UKUSQDF-103 [AT] Cnx2Redis Data Collector - Compare to ArsImporter
	In order to test Cnx2Redis
	As a QDF Tester
	I want to be able to compare data from Redis cnx-deals and Redis deals

#these tests need to be amended to compare across Redis instances and dbs, currently reconciling agains MySql
Scenario: Compare last day's data
	Given I have the following search criteria for qdf deals
	 | DealSource | StartTime | EndTime | DealType     |
	 | cnx-deals  | -1D       | +1D     | BookLessDeal |
	 When I retrieve the qdf deal data
		 And I query cnx trade by using the same deal search criteria
		 And I compare the cnx trade deals with the qdf deal data excluding these fields:
		 | ExcludedFields |
		 | Side           | 
	 Then the cnx trade deals should match the qdf deal data exactly 

Scenario: Compare partial day's data
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     | DealType     |
	 | cnx-deals  | 04/07/2014  11:46:26 | 04/07/2014  14:59:32 | BookLessDeal |
	 When I retrieve the qdf deal data
		 And I query cnx trade by using the same deal search criteria
		 And I compare the cnx trade deals with the qdf deal data 
	 Then the cnx trade deals should match the qdf deal data exactly 
