@ClientSideFiltering @TeardownRedisConnection @UKUSQDF_71
Feature: UKUSQDF-71[AT] QDF UI - add ability to switch between ARS and ECN deals
	In order to access ecn deal data in Redis QDF
	As a QDF Analyst
	I want a UI to retrieve and filter ecn deal data

Scenario: Filter deals by date
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | ecn-deals  | 05/05/2014  12:45:42 | 05/05/2014  12:49:51 |
	When I retrieve the qdf deal data
	Then no retrieved deal will have a timestamp outside "05/05/2014  12:45:42" to "05/05/2014  12:49:51"
	And the count of retrieved deals will be 70 
	#113 in ars
