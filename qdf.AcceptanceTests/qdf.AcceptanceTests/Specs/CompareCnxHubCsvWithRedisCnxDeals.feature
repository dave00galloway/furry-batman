Feature: CompareCnxHubCsvWithRedisCnxDeals
	In order to reconcile cnx and redis data
	As a QDF Analyst
	I want to compare Cnx Hub data with Redis data

@mytag
Scenario: Compare Cnx Hub Csv With Redis Cnx Deals
	Given I have Cnx Hub Csv at "cnxfilenamepath"
	And I have entered 70 into the calculator
	When I press add
	Then the result should be 120 on the screen
