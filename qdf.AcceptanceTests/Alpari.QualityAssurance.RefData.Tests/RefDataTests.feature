Feature: RefDataTests
	In order to avoid writing multiple dictionary lookups
	As a tester
	I want to a ref data class to hold lookup data

@mytag
Scenario: Lookup values in QdfToCcServerMapping
	Given I have connected to the ref data dictionary
	When I lookup key "Currenex" in the QdfToCcServerMapping dictionary
	Then the value returned by the lookup is "CNX"

@mytag
Scenario: Lookup values in CcToQdfServerMapping
	Given I have connected to the ref data dictionary
	When I lookup key "CNX" in the CcToQdfServerMapping dictionary
	Then the value returned by the lookup is "Currenex"

#Bad style, but not worth writing more complicated Step Defs to handle table args etc at the moment
@mytag
Scenario: Lookup values in both dictionaries
	Given I have connected to the ref data dictionary
	When I lookup key "CNX" in the CcToQdfServerMapping dictionary
	Then the value returned by the lookup is "Currenex"
	When I lookup key "Currenex" in the QdfToCcServerMapping dictionary
	Then the value returned by the lookup is "CNX"
	When I lookup key "CNX" in the CcToQdfServerMapping dictionary
	Then the value returned by the lookup is "Currenex"
	When I lookup key "Currenex" in the QdfToCcServerMapping dictionary
	Then the value returned by the lookup is "CNX"
	Given I have connected to the ref data dictionary
	When I lookup key "CNX" in the CcToQdfServerMapping dictionary
	Then the value returned by the lookup is "Currenex"
	When I lookup key "Currenex" in the QdfToCcServerMapping dictionary
	Then the value returned by the lookup is "CNX"
	When I lookup key "CNX" in the CcToQdfServerMapping dictionary
	Then the value returned by the lookup is "Currenex"
	When I lookup key "Currenex" in the QdfToCcServerMapping dictionary
	Then the value returned by the lookup is "CNX"

@UKUSQDF_68
Scenario Outline: Lookup values in RedisMapping
	Given I have connected to the ref data dictionary
	When I lookup key "<Environment names>" in the RedisServerNameToIpMapping dictionary
	Then the value returned by the lookup is "<IP>"
	Examples: 
	| Environment names             | IP            |
	| uk-redis-prod.corp.alpari.com | 10.10.142.62  |
	| uk-redis-uat.corp.alpari.com  | 10.10.144.156 |
	| uk-redis-dev.corp.alpari.com  | 10.10.144.100 |