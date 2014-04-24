Feature: MySqlQUickStart
	In order to access MySql Data
	As a tester
	I want a working linq provider 

@SelfTest
Scenario: Create connection
	Given I have created a connection to "MySqlDataContextSubstitute"
	When I retrieve cc_tbl_position_section data from cc
	Then the cc_tbl_position_section data from cc has 4 records
