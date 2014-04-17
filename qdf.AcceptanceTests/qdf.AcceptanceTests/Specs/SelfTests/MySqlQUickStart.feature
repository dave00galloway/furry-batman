Feature: MySqlQUickStart
	In order to access MySql Data
	As a tester
	I want a working linq provider 

@SelfTest
Scenario: Create connection
	Given I have created a connection to "MySqlDataContextSubstitute"
	When I retrieve 
	#When I press add
	#Then the result should be 120 on the screen
