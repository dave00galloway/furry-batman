@UKUSQDF_92
Feature: ConnectToDataSources
	In order to test Cnx2Redis
	As a QDF Tester
	I want to be able to read data from MySql and Redis

Scenario: Connect To MySql
	Given I have connected to the cnx trade table
	When I query cnx trade by trade id "B20141740AUG600"
	Then the cnx trade has a login of "AUKD35367"

Scenario: Filter deals by date
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 25/06/2014  07:38:09 | 25/06/2014  07:55:31 |
	When I retrieve the qdf deal data
	#And I export the data to "C:\temp\cnx.csv" and import the csv
	Then no retrieved deal will have a timestamp outside "25/06/2014  07:38:09" to "25/06/2014  07:55:31"
	And the count of retrieved deals will be 11


