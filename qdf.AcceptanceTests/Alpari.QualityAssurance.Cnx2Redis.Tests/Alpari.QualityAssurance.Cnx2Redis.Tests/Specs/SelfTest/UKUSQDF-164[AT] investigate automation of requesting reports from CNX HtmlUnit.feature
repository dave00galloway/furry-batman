@UKUSQDF_164 @HtmlUnit
Feature: UKUSQDF-164[AT] investigate automation of requesting reports from CNX
	In order to verify Cnx2Redis data in the cnx-deals key
	As a QDF Tester
	I want to get cnx hub data via a scheduled job

Scenario: Connect to hub admin and download report with htmlunit
	Given I have connected to currenex hub admin with htmlunit
	#When I request the trade activity report
	When I request the trade activity report as csv with htmlunit

