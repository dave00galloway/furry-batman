@redisLocalhost @BookLessDeal:cnx_deals:TestData\cnx.csv @MySqlLocalhost
Feature: Parse Side Correctly
	In order to write reliable test code
	As a QDF Tester
	I want to be able to seed a local redis instance with test data

Scenario: write test data to localhost
	Given I am running a test on localhost
	And I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     | DataType     |
	 | cnx-deals  | 19/06/2014  17:36:00 | 19/06/2014  17:44:59 | BookLessDeal |
	 When I retrieve the qdf deal data
	 Then the count of retrieved deals will be 11
