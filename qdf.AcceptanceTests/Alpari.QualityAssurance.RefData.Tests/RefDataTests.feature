Feature: RefDataTests
	In order to avoid writing multiple dictionary lookups
	As a tester
	I want to a ref data class to hold lookup data

@mytag
Scenario: Lookup values in QdfToCcServerMapping
	Given I have connected to the ref data dictionary
	When I lookup key "Currenex" in the QdfToCcServerMapping dictionary
	Then the value returned by the lookup is "CNX"
