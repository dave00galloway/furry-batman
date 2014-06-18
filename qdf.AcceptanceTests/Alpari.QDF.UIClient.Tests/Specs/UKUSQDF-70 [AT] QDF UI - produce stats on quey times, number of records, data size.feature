@UKUSQDF_70
Feature: UKUSQDF-70 [AT] QDF UI - produce stats on quey times, number of records, data size
	In order to benchmark query performance
	As a QDF Analyst
	I want to be told the execution time, data size, number of records in a query


Scenario: Query redis and get performance stats for deals
	Given I have the following search criteria for qdf deals
	 | Book | Symbol | Server      | ConvertedStartTime   | ConvertedEndTime     |
	 | B    | EURUSD | Mt4Classic2 | 05/05/2014  12:45:42 | 05/05/2014  12:49:51 |
	 And I start timing the query
	When I retrieve the qdf deal data
	And I stop timing the query
	Then the query execution time is recorded
