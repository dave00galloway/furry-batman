Feature: EnableQueryOncnx-deals
	In order to get data from the cnx-deals key
	As a Qdf tester
	I want to be able to filter on cnx-deals

	#TODO:- add test data to local host, so don't have to worry about switching environments, or coping with broken deals
Scenario: Filter deals by date
	Given I change the redis connection to "uk-redis-prod.corp.alpari.com"
	And I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 15/07/2014  19:00:00 | 16/07/2014  00:05:00 |
	When I retrieve the qdf deal data
	And I export the data to "C:\temp\temp.csv" and import the csv
	Then no retrieved deal will have a timestamp outside "07/07/2014  00:00:00" to "07/07/2014  00:01:00"
	And the count of retrieved deals will be 3
	
	#because the deals are in an incorrect format in prod, there's not much poiunt trying to handle them here 
