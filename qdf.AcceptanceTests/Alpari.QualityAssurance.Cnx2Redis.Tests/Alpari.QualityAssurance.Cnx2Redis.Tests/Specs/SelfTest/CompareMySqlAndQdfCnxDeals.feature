@UKUSQDF_92
Feature: CompareMySqlAndQdfCnxDeals
	In order to test Cnx2Redis
	As a QDF Tester
	I want to be able to compare data from MySql and Redis

Scenario: Compare small range of deals where side is incorrect
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 19/06/2014  17:36:39 | 19/06/2014  17:44:16 |
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
	 And I compare the cnx trade deals with the qdf deal data
	 Then the cnx trade deals should match the qdf deal data exactly 

Scenario: Compare small range of deals where side is incorrect excluding known issues
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 19/06/2014  17:36:39 | 19/06/2014  17:44:16 |
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
	 Then the cnx trade deals should match the qdf deal data exactly 


Scenario: Compare small range of deals where side is incorrect and find all expected records
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 19/06/2014  17:36:39 | 19/06/2014  17:44:16 |
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
	 And I compare the cnx trade deals with the qdf deal data
	 Then the cnx trade deals should contain the same deals as the qdf deal data 



#Scenario: Connect To MySql
#	Given I have connected to the cnx trade table
#	When I query cnx trade by trade id "B20141740AUG600"
#	Then the cnx trade has a login of "AUKD35367"
#
#Scenario: Filter deals by date
#	Given I have the following search criteria for qdf deals
#	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
#	 | cnx-deals  | 19/06/2014  17:36:39 | 19/06/2014  17:44:16 |
#	When I retrieve the qdf deal data
#	#And I export the data to "C:\temp\cnx.csv" and import the csv
#	Then no retrieved deal will have a timestamp outside "19/06/2014  17:35:00" to "19/06/2014  17:45:00"
#	And the count of retrieved deals will be 11