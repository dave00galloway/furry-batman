@UKUSQDF_70
Feature: UKUSQDF-70 [AT] QDF UI - Quote Query Stats
	In order to benchmark quote query performance
	As a QDF Analyst
	I want to be told the execution time, data size, number of records in a query

Background: Set up Quote Query and start timing
	Given I have the following search criteria for qdf quotes
		 | Symbol | ConvertedStartTime   | ConvertedEndTime     |
		 | EURUSD | 09/06/2014  09:00:00 | 09/06/2014  09:05:00 |
		 And I start measuring the query
	When I retrieve the qdf quote data
		And I stop measuring the query

Scenario: Query redis and get execution time for quote queries
	Then the query execution time is recorded

Scenario: Query redis and get data size for quote queries
	Then the quote data size is recorded

Scenario: Query redis and get record count for quote queries
	Then the quote count is recorded

Scenario: Query redis and get query speed in bytes per second
	Then the quote query speed in bytes per second is equal to the size of the query divided by the elapsed time

Scenario: Query redis and get query speed in quotes per second
	Then the quote query speed in quotes per second is equal to the quote count divided by the elapsed time

Scenario: Query redis and get total record count for deal queries
	Then the total quote count is recorded

Scenario: Query redis and get query speed in total deals per second
	Then the deal quote speed in total quotes per second is equal to the quote count divided by the elapsed time

