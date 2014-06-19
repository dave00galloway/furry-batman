@UKUSQDF_70
Feature: UKUSQDF-70 [AT] QDF UI - Ecn Deal Query Stats
	In order to benchmark ecn deal query performance
	As a QDF Analyst
	I want to be told the execution time, data size, number of records in a query

Background: Set up Deal Query and start timing
	Given I have the following search criteria for qdf deals
		| DealSource | Book | Symbol | Server      | ConvertedStartTime   | ConvertedEndTime     |
		| ecn-deals  | B    | EURUSD | Mt4Classic2 | 05/05/2014  12:45:42 | 05/05/2014  12:49:51 |
		And I start measuring the query
	When I retrieve the qdf deal data
		And I stop measuring the query

Scenario: Query redis and get execution time for deal queries
	Then the query execution time is recorded

Scenario: Query redis and get data size for deal queries
	Then the deal data size is recorded

Scenario: Query redis and get record count for deal queries
	Then the deal count is recorded

Scenario: Query redis and get query speed in bytes per second
	Then the deal query speed in bytes per second is equal to the size of the query divided by the elapsed time

Scenario: Query redis and get query speed in deals per second
	Then the deal query speed in deals per second is equal to the deal count divided by the elapsed time

Scenario: Query redis and get total record count for deal queries
	Then the total deal count is recorded

Scenario: Query redis and get query speed in total deals per second
	Then the deal query speed in total deals per second is equal to the deal count divided by the elapsed time
