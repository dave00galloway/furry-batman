@localhost
Feature: UKUSQDF-117 [AT] Create a localhost redis instance for testing
	In order to write reliable test code
	As a QDF Tester
	I want to be able to seed a local redis instance with test data

@cnx.csv
Scenario: write test data to localhost
	Given I am running a test on localhost
