@UKUSQDF_117 @redisLocalhost @deal:cnx_deals:TestData\cnx.csv @MySqlLocalhost
Feature: UKUSQDF-117 [AT] Create a localhost redis instance for testing
	In order to write reliable test code
	As a QDF Tester
	I want to be able to seed a local redis instance with test data

Scenario: write test data to localhost
	Given I am running a test on localhost
	And I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 2014-07-10  01:29:21 | 2014-07-10  01:30:04 |
	 When I retrieve the qdf deal data
	 Then the count of retrieved deals will be 14

Scenario: write test data to localhost and check with MySql
	Given I am running a test on localhost
	And I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 2014-07-10  01:29:21 | 2014-07-10  01:30:04 |
	 When I retrieve the qdf deal data
		 And I query cnx trade by trade id for these trade ids:
		 | DealId          |
		 | B20141910A7K300 |
		 | B20141910A7L300 |
		 | B20141910A7L700 |
		 | B2014191054GN00 |
		 | B201419106E6U00 |
		 | B20141910A7LS00 |
		 | B201419106E7600 |
		 | B201419107NV800 |
		 | B201419107NVA00 |
		 | B20141910A7MN00 |
		 | B20141910A7R800 |
		 | B20141910A7RA00 |
		 | B20141910A7SV00 |
		 | B201419106E7Z00 |

		 And I compare the cnx trade deals with the qdf deal data 
	 Then the cnx trade deals should match the qdf deal data exactly:-
	 		| ExportType     |  Overwrite |
	 		| DataTableToCsv |  true      | 

#cnx_old.csv
#Scenario: write test data to localhost
#	Given I am running a test on localhost
#	And I have the following search criteria for qdf deals
#	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
#	 | cnx-deals  | 19/06/2014  17:36:00 | 19/06/2014  17:44:59 |
#	 When I retrieve the qdf deal data
#	 Then the count of retrieved deals will be 11
#
#Scenario: write test data to localhost and check with MySql
#	Given I am running a test on localhost
#	And I have the following search criteria for qdf deals
#	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
#	 | cnx-deals  | 19/06/2014  17:36:00 | 19/06/2014  17:44:59 |
#	 When I retrieve the qdf deal data
#	 And I query cnx trade by trade id for these trade ids:
#	 | DealId          |
#	 | B201417005FFD00 |
#	 | B201417005FFN00 |
#	 | B201417005FFR00 |
#	 | B201417005FFU00 |
#	 | B201417005FFX00 |
#	 | B201417005FG000 |
#	 | B201417005FG300 |
#	 | B201417005FR400 |
#	 | B201417005FS100 |
#	 | B201417005FS400 |
#	 | B201417005FTC00 |
#	 And I compare the cnx trade deals with the qdf deal data excluding these fields:
#	 | ExcludedFields |
#	 | OrderId        |
#	 | Side           | 
#	 Then the cnx trade deals should match the qdf deal data exactly 
