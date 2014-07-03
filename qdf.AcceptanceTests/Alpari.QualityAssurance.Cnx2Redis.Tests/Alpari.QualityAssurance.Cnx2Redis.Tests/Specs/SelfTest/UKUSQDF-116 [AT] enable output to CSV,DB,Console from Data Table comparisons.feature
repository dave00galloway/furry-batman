@UKUSQDF_116 @redisLocalhost @deal:cnx_deals:TestData\cnx.csv @MySqlLocalhost
Feature: UKUSQDF-116 [AT] enable output to CSV,DB,Console from Data Table comparisons
	In order to facilitate test evidence gathering
	As a QDF Tester
	I want to be able to specify a test output method

Scenario: Compare small range of deals where side is incorrect excluding known issues
	Given I have the following search criteria for qdf deals
	 | DealSource | ConvertedStartTime   | ConvertedEndTime     |
	 | cnx-deals  | 25/06/2014  07:38:09 | 25/06/2014  07:55:31 |
	 When I retrieve the qdf deal data
	 And I query cnx trade by trade id for these trade ids:
	 | DealId          |
	 | B201417601B3400 |
	 | B201417600X2L00 |
	 | B201417600X9C00 |
	 | B201417600X9F00 |
	 | B201417600XB100 |
	 | B201417600XB400 |
	 | B201417600XBA00 |
	 | B201417601B3G00 |
	 | B201417601B3K00 |
	 | B201417601B3R00 |
	 And I compare the cnx trade deals with the qdf deal data excluding these fields:
	 | ExcludedFields |
	 | OrderId        |
	 | Side           | 
	 
	 #Then the cnx trade deals should match the qdf deal data exactly :-
	Then the cnx trade data should contain 10 "missing" :-
	| ExportType     | FileName |  Overwrite |
	| DataTableToCsv | missing    |  true      |