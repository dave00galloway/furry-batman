Feature: TestDataToShareClientOne
	In order to avoid repeating set up data in feature files
	As a tester
	I want to be able to save test data for a whole test run

@mytag
Scenario: Test data from another feature can be used in a client feature
	Given the Test Run Context does not contain templated data named "defaultUser"
	When I create or retrieve the templated data named "defaultUser" as "userOne"
	Given the Test Run Context does contain templated data named "defaultUser"
	When I create or retrieve the templated data named "defaultUser" as "userTwo"
	Then the templated data "userOne" is the same as the templated data "userTwo"

	
