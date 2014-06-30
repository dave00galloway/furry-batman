@UKUSQDF_103
Feature: UKUSQDF-103 [AT] Cnx2Redis Data Collector - Compare to ArsImporter
	In order to test Cnx2Redis
	As a QDF Tester
	I want to be able to compare data from Redis cnx-deals and Redis deals

#TODO:- convert to runnable test
@Broken
Scenario: Compare last day's data
	Given I have yesterdays cnx-deals
	And I have yesterdays deals
	When I compare cnx-deals to deals except for known issues
	Then the cnx trade deals should match the qdf deal data exactly
