@UKUSQDF_92
Feature: CompareMySqlAndQdfCnxDeals
	In order to test Cnx2Redis
	As a QDF Tester
	I want to be able to compare data from MySql and Redis

#@Broken
# data has been deleted from Redis
#Scenario: Compare small range of deals where side is incorrect
#	Given I have the following search criteria for qdf deals
#	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
#	 | cnx-deals  | 19/06/2014  17:36:39 | 19/06/2014  17:44:16 |
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
#	 Then the cnx trade data should contain 5 "mismatches"
#	 And the cnx trade data should contain 5 "mismatches" in the "Side" column

Scenario: Compare small range of deals where side is incorrect excluding known issues
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 25/06/2014  07:38:09 | 25/06/2014  07:55:31 |
	 When I retrieve the qdf deal data
	 And I query cnx trade by trade id for these trade ids:
	 | DealId          |
	 | B201417601B3400 |
	 | B201417600X2L00 |
	 | B201417600X9C00 |
	 | B201417600X9F00 |
	 | B201417600XB100 |
	 | B201417600XB400 |
	 | B201417600XBA00 |
	 | B201417601B3G00 |
	 | B201417601B3K00 |
	 | B201417601B3N00 |
	 | B201417601B3R00 |
	 And I compare the cnx trade deals with the qdf deal data excluding these fields:
	 | ExcludedFields |
	 | OrderId        |
	 | Side           | 
	 Then the cnx trade deals should match the qdf deal data exactly 


Scenario: Compare small range of deals where side is incorrect and find all expected records
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 25/06/2014  07:38:09 | 25/06/2014  07:55:31 |
	 When I retrieve the qdf deal data
	 And I query cnx trade by trade id for these trade ids:
	 | DealId          |
	 | B201417601B3400 |
	 | B201417600X2L00 |
	 | B201417600X9C00 |
	 | B201417600X9F00 |
	 | B201417600XB100 |
	 | B201417600XB400 |
	 | B201417600XBA00 |
	 | B201417601B3G00 |
	 | B201417601B3K00 |
	 | B201417601B3N00 |
	 | B201417601B3R00 |
	 And I compare the cnx trade deals with the qdf deal data
	 Then the cnx trade deals should contain the same deals as the qdf deal data 

Scenario: Compare small range of deals by date time range
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 25/06/2014  07:38:09 | 25/06/2014  07:55:31 |
	 When I retrieve the qdf deal data
	 And I query cnx trade by trade id from "25/06/2014  07:38:09" to "25/06/2014  07:55:31"
	 And I compare the cnx trade deals with the qdf deal data excluding these fields:
	 | ExcludedFields |
	 | OrderId        |
	 | Side           | 
	 Then the cnx trade deals should match the qdf deal data exactly 