@UKUSQDF_70
Feature: UKUSQDF-70 [AT] QDF UI - Deal Query Stats
	In order to benchmark deal query performance
	As a QDF Analyst
	I want to be told the execution time, data size, number of records in a query

Background: Set up Deal Query and start timing
	Given I have the following search criteria for qdf deals
	 | Book | Symbol | Server      | ConvertedStartTime   | ConvertedEndTime     |
	 | B    | EURUSD | Mt4Classic2 | 05/05/2014  12:45:42 | 05/05/2014  12:49:51 |
	 And I start measuring the query

Scenario: Query redis and get execution time for deal queries
	When I retrieve the qdf deal data
	And I stop measuring the query
	Then the query execution time is recorded

Scenario: Query redis and get data size for deal queries
	When I retrieve the qdf deal data
	And I stop measuring the query
	Then the deal data size is recorded

Scenario: Query redis and get record count for deal queries
	When I retrieve the qdf deal data
	And I stop measuring the query
	Then the deal count is recorded

Scenario: Query redis and get query speed in bytes per second
	When I retrieve the qdf deal data
	And I stop measuring the query
	Then the deal query speed in bytes per second is equal to the size of the query divided by the elapsed time

Scenario: Query redis and get query speed in deals per second
	When I retrieve the qdf deal data
	And I stop measuring the query
	Then the deal query speed in deals per second is equal to the deal count divided by the elapsed time

Scenario: Query redis and get total record count for deal queries
	When I retrieve the qdf deal data
	And I stop measuring the query
	Then the total deal count is recorded

Scenario: Query redis and get query speed in total deals per second
	When I retrieve the qdf deal data
	And I stop measuring the query
	Then the deal query speed in total deals per second is equal to the deal count divided by the elapsed time