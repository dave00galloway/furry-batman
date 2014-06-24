@SelfTest
Feature: ConnectToDataSources
	In order to test Cnx2Redis
	As a QDF Tester
	I want to be able to read data from MySql and Redis

Scenario: Connect To MySql
	Given I have connected to the cnx trade table
	When I query cnx trade by trade id "B20141740AUG600"
	Then the cnx trade has a login of "AUKD35367"
