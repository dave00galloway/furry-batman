@UKUSQDF_92 @redisLocalhost @RedisDataImportParams:deal:cnx_deals:TestData\cnx.csv @MySqlLocalhost
Feature: ConnectToDataSources
	In order to test Cnx2Redis
	As a QDF Tester
	I want to be able to read data from MySql and Redis

Scenario: Connect To MySql
	Given I have connected to the cnx trade table
	When I query cnx trade by trade id "B20141910A7LS00"
	Then the cnx trade has a login of "AUKUS2095"

Scenario: Filter deals by date
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 2014-07-10  01:29:21 | 2014-07-10  01:30:04 |
	When I retrieve the qdf deal data
	#And I export the data to "C:\temp\cnx.csv" and import the csv
	Then no retrieved deal will have a timestamp outside "2014-07-10  01:29:21" to "2014-07-10  01:30:04"
	And the count of retrieved deals will be 14


