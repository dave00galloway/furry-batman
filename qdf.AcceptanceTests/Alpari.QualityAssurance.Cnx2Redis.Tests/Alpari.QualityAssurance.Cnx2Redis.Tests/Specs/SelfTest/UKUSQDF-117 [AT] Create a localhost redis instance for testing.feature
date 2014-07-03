@localhost
Feature: UKUSQDF-117 [AT] Create a localhost redis instance for testing
	In order to write reliable test code
	As a QDF Tester
	I want to be able to seed a local redis instance with test data

@deal:cnx_deals:TestData\cnx.csv
Scenario: write test data to localhost
	Given I am running a test on localhost
	And I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 19/06/2014  17:36:00 | 19/06/2014  17:44:59 |
	 When I retrieve the qdf deal data
