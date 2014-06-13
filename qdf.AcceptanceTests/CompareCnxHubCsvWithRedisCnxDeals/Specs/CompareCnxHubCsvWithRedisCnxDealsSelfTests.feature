Feature: CompareCnxHubCsvWithRedisCnxDealsSelfTests
	In order to reconcile QDF and Cnx Hub Data
	As a QDF Analyst
	I want to compare Cnx csv and Redis data

@mytag
Scenario: Load cnx hub data
	Given I have loaded cnx hub data from "CompareCnxHubCsvWithRedisCnxDealsTestData\CnxTestData.csv"
