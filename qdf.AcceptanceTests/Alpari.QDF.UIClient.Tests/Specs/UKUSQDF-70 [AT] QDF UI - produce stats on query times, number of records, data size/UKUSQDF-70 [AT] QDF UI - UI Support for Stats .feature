@UKUSQDF_70
Feature: UKUSQDF-70 [AT] QDF UI - UI Support for Stats 
	In order to display relevant stats
	As a QDF Analyst
	I want to be see appropriate stats for the type of data query

Scenario: Display stats for Deal Query
	Given I have the following search criteria for qdf deals
		 | Book | Symbol | Server      | ConvertedStartTime   | ConvertedEndTime     |
		 | B    | EURUSD | Mt4Classic2 | 05/05/2014  12:45:42 | 05/05/2014  12:49:51 |
		And I start measuring the query
	When I retrieve the qdf deal data
		And I stop measuring the query
	Then the stats for a deal query are displayed

Scenario: Display stats for Ecn Deal Query
	Given I have the following search criteria for qdf deals
		| DealSource | Book | Symbol | Server      | ConvertedStartTime   | ConvertedEndTime     |
		| ecn-deals  | B    | EURUSD | Mt4Classic2 | 05/05/2014  12:45:42 | 05/05/2014  12:49:51 |
		And I start measuring the query
	When I retrieve the qdf deal data
		And I stop measuring the query
	Then the stats for a deal query are displayed

Scenario: Display stats for Quote Query
	Given I have the following search criteria for qdf quotes
		 | Symbol | ConvertedStartTime   | ConvertedEndTime     |
		 | EURUSD | 09/06/2014  09:00:00 | 09/06/2014  09:05:00 |
		 And I start measuring the query
	When I retrieve the qdf quote data
		And I stop measuring the query
	Then the stats for a quote query are displayed

Scenario: Reset stats for Deal Query
	Given I have the following search criteria for qdf deals
		 | Book | Symbol | Server      | ConvertedStartTime   | ConvertedEndTime     |
		 | B    | EURUSD | Mt4Classic2 | 05/05/2014  12:45:42 | 05/05/2014  12:49:51 |
		And I have queried and displayed the deal query stats
	When I reset the performance stats
	Then the deal performance stats are:
	| ExecutionTime | QuerySize | QuerySizeFormatted | QuerySpeedInBytesPerSecondFormatted | DealCount | TotalDealCount | DealQuerySpeedInDealsPerSecond | DealQuerySpeedInDealsPerSecondFormatted | TotalDealQuerySpeedInDealsPerSecond | TotalDealQuerySpeedInDealsPerSecondFormatted |
	| 0             | 0         |                    | 0 Bytes/Second                      | 0         | 0              | 0                              | 0 Deals/Second                          | 0                                   | 0 Deals/Second                               |

Scenario: Reset stats for Deal Query and requery
	Given I have the following search criteria for qdf deals
		 | Book | Symbol | Server      | ConvertedStartTime   | ConvertedEndTime     |
		 | B    | EURUSD | Mt4Classic2 | 05/05/2014  12:45:42 | 05/05/2014  12:49:51 |
		And I have queried and displayed the deal query stats
	When I reset the performance stats
	Given I have the following search criteria for qdf deals
		| DealSource | Book | Symbol | Server      | ConvertedStartTime   | ConvertedEndTime     |
		| ecn-deals  | A    | EURUSD | Mt4Classic2 | 05/05/2014  12:45:42 | 05/05/2014  12:49:51 |
		And I start measuring the query
	When I retrieve the qdf deal data
		And I stop measuring the query
	Then the stats for a deal query are displayed
