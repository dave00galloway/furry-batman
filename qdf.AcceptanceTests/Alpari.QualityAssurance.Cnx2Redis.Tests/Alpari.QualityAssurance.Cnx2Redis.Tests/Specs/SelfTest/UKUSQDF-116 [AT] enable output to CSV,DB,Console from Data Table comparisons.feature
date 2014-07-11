@UKUSQDF_116 @redisLocalhost @RedisDataImportParams:deal:cnx_deals:TestData\cnx.csv @MySqlLocalhost
Feature: UKUSQDF-116 [AT] enable output to CSV,DB,Console from Data Table comparisons
	In order to facilitate test evidence gathering
	As a QDF Tester
	I want to be able to specify a test output method

Scenario: Compare small range of deals where side is incorrect excluding known issues
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 2014-07-10  01:29:21 | 2014-07-10  01:30:04 |
	 When I retrieve the qdf deal data
	 And I query cnx trade by trade id for these trade ids:
		 | DealId          |
		 | B20141910A7K300 |
		 | B20141910A7L300 |
		 | B20141910A7L700 |
		 | B2014191054GN00 |
		 | B201419106E6U00 |
		 | B20141910A7LS00 |
		 | B201419106E7600 |
		 | B201419107NV800 |
		 | B201419107NVA00 |
		 | B20141910A7MN00 |
		 | B20141910A7R800 |
		 | B20141910A7RA00 |
		 | B20141910A7SV00 |
	 And I compare the cnx trade deals with the qdf deal data excluding these fields:
	 | ExcludedFields |
	 | Comment        |
	 
	 #Then the cnx trade deals should match the qdf deal data exactly :-
	Then the cnx trade data should contain 1 "extra" :-
	| ExportType     | FileName | Overwrite |
	| DataTableToCsv | extra    | true      |