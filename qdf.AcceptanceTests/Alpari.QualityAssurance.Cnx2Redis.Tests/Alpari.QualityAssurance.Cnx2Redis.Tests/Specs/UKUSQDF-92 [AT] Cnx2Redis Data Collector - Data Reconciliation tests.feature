@UKUSQDF_92
Feature: UKUSQDF-92 [AT] Cnx2Redis Data Collector - Data Reconciliation tests
	In order to test Cnx2Redis
	As a QDF Tester
	I want to be able to compare data from MySql and Redis

Scenario: Compare last day's data
	Given I have the following search criteria for qdf deals
	 | DealSource | StartTime | EndTime | DealType     |
	 | cnx-deals  | -1D       | +1D     | BookLessDeal |
	 When I retrieve the qdf deal data
		 And I query cnx trade by using the same deal search criteria
		 And I compare the cnx trade deals with the qdf deal data
		# And I compare the cnx trade deals with the qdf deal data excluding these fields:
		# | ExcludedFields |
		# | Side           |
		## | OrderId |
	 Then the cnx trade deals should match the qdf deal data exactly:-
	 		| ExportType     |  Overwrite |
	 		| DataTableToCsv |  true      | 

Scenario: Compare last 2 day's data
	Given I have the following search criteria for qdf deals
	 | DealSource | StartTime | EndTime | DealType     |
	 | cnx-deals  | -2D       | +2D     | BookLessDeal |
	 When I retrieve the qdf deal data
		 And I query cnx trade by using the same deal search criteria
		 And I compare the cnx trade deals with the qdf deal data
		# And I compare the cnx trade deals with the qdf deal data excluding these fields:
		# | ExcludedFields |
		# | Side           |
		## | OrderId |
	 Then the cnx trade deals should match the qdf deal data exactly:-
	 		| ExportType     |  Overwrite |
	 		| DataTableToCsv |  true      | 

Scenario: Spot Test
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     | DealType     |
	 | cnx-deals  | 07/07/2014  06:04:52 | 07/07/2014  06:04:53 | BookLessDeal |
	 When I retrieve the qdf deal data
		 And I query cnx trade by using the same deal search criteria
		 And I compare the cnx trade deals with the qdf deal data
	 Then the cnx trade deals should match the qdf deal data exactly:-
	 		| ExportType     |  Overwrite |
	 		| DataTableToCsv |  true      | 