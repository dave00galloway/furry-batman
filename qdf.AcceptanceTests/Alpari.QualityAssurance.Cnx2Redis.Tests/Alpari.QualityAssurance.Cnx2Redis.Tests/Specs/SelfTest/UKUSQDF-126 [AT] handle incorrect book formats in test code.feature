@UKUSQDF_126 @redisLocalhost @BookLessDeal:cnx_deals:TestData\BookLessDeals.csv @MySqlLocalhost
Feature: UKUSQDF-126 [AT] handle incorrect book formats in test code
	In order to work around badly formatted data
	As a QDF tester
	I want to be able to ignore Book

Scenario: Parse Bookless deals 
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     | DealType     |
	 | cnx-deals  | 06/07/2014  00:00:00 | 06/07/2014  23:59:59 | BookLessDeal |
	When I retrieve the qdf deal data
	#And I export the data to "C:\temp\cnx.csv" and import the csv
	Then no retrieved deal will have a timestamp outside "06/07/2014  00:00:00" to "06/07/2014  23:59:59"
	And the count of retrieved deals will be 34
