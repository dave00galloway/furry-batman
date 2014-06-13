@ClientSideFiltering @TeardownRedisConnection
Feature: OutputToCsv
	In order to export deal data from Redis QDF
	As a QDF Analyst
	I want to be able to save query results to CSV

@UKUSQDF_61
Scenario: Output to CSV
	Given I have the following search criteria for qdf deals
	 | Symbol               | Servers                       | ConvertedStartTime   | ConvertedEndTime     |
	 | EURUSD,GBPUSD,AUDJPY | Currenex,Mt5Pro,Mt4JapaneseC1 | 05/05/2014  12:45:42 | 05/05/2014  12:49:51 |
	When I retrieve the qdf deal data
	And I export the data to "C:\temp\temp.csv" and import the csv
	Then the deals imported for each symbol will have the following counts
	| Symbol | Count |
	| EURUSD | 16    |
	| GBPUSD | 2     |
	| AUDJPY | 1     |
	And the deals imported for each server will have the following counts
	| Server        | Count |
	| Mt4JapaneseC1 | 12    |
	| Currenex      | 5     |
	| Mt5Pro        | 2     |
	And the count of imported deals will be 19

@UKUSQDF_71
Scenario: Output ecn deals to CSV
	Given I have the following search criteria for qdf deals
	 | DealSource | Symbol               | Servers                       | ConvertedStartTime   | ConvertedEndTime     |
	 | ecn-deals  | EURUSD,GBPUSD,AUDJPY | Currenex,Mt5Pro,Mt4JapaneseC1 | 05/05/2014  12:45:42 | 05/05/2014  12:49:51 |
	When I retrieve the qdf deal data
	And I export the data to "C:\temp\temp.csv" and import the csv
	Then the deals imported for each symbol will have the following counts
	| Symbol | Count |
	| EURUSD | 11    |
	| AUDJPY | 1     |
	And the deals imported for each server will have the following counts
	| Server        | Count |
	| Mt4JapaneseC1 | 12    |
	And the count of imported deals will be 12