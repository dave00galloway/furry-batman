@UKUSQDF_186 @WebClient
Feature: UKUSQDF-186Get conversion rate Data via http from cnx hub
	In order to perform calculations using conversion rates
	As a QDF analyst
	I want access to CNX hub Conversion data

Scenario: Get a days conversion rate data via http from cnx hub
	Given I have connected to currenex hub admin
	When I download yesterday's conversion rate data
	Then the conversion rate data contains 168 lines

#TODO:- work out why we get a BODI exception when running 2 consecutive tests
Scenario: Get a days conversion rate data via http from cnx hub and save as csv
	Given I have connected to currenex hub admin
	When I download yesterday's conversion rate data to csv
	Then the conversion rate data contains 168 lines

Scenario: Get conversion rate data via http from cnx hub for all days between 2 dates and save as csv
	Given I have connected to currenex hub admin
	When I download conversion rate data from "01/01/2014" to "02/01/2014"
	#Then the conversion rate data contains 168 lines
