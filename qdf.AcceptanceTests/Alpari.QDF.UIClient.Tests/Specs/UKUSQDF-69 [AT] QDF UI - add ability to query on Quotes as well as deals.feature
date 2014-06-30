@UKUSQDF_69
Feature:UKUSQDF-69 [AT] QDF UI - add ability to query on Quotes as well as deals
	In order to get information about quotes
	As a QDF Analyst
	I want access to quote data in QDF

Scenario: Filter quotes by date
	Given I have the following search criteria for qdf quotes
	 | ConvertedStartTime   | ConvertedEndTime     |
	 | 09/06/2014  09:00:00 | 09/06/2014  09:05:00 |
	When I retrieve the qdf quote data
	Then no retrieved quote will have a timestamp outside "09/06/2014  09:00:00" to "09/06/2014  09:05:00"
	And the count of retrieved quotes will be 10893


Scenario: Filter quotes by symbol
	Given I have the following search criteria for qdf quotes
	 | Symbol | ConvertedStartTime   | ConvertedEndTime     |
	 | EURUSD | 09/06/2014  09:00:00 | 09/06/2014  09:05:00 |
	When I retrieve the qdf quote data
	Then all retrieved quotes will be for symbol "EURUSD"
	And the count of retrieved quotes will be 214

Scenario: Filter quotes by multiple symbols
	Given I have the following search criteria for qdf quotes
	 | Symbol               | ConvertedStartTime   | ConvertedEndTime     |
	 | EURUSD,NZDUSD,AUDNZD | 09/06/2014  09:00:00 | 09/06/2014  09:05:00 |
	When I retrieve the qdf quote data
	Then the quotes retrieved for each symbol will have the following counts
	| Symbol | Count |
	| EURUSD | 214   |
	| NZDUSD | 156   |
	| AUDNZD | 166   |
	And the count of retrieved quotes will be 536

Scenario: Output to CSV all quotes
	Given I have the following search criteria for qdf quotes
	 | ConvertedStartTime   | ConvertedEndTime     |
	 | 09/06/2014  09:00:00 | 09/06/2014  09:05:00 |
	When I retrieve the qdf quote data
	And I export the quote data to "C:\temp\temp.csv" and import the csv
	Then the count of retrieved quotes will be 10893

Scenario: Output to CSV filtered quotes
	Given I have the following search criteria for qdf quotes
	 | Symbol               | ConvertedStartTime   | ConvertedEndTime     |
	 | EURUSD,NZDUSD,AUDNZD | 09/06/2014  09:00:00 | 09/06/2014  09:05:00 |
	When I retrieve the qdf quote data
	And I export the quote data to "C:\temp\temp.csv" and import the csv
	Then the quotes imported for each symbol will have the following counts
	| Symbol | Count |
	| EURUSD | 214   |
	| NZDUSD | 156   |
	| AUDNZD | 166   |
	Then the count of retrieved quotes will be 536