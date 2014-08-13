@UKUSQDF_173 @cnxHubTradeActivityImporter:WebClient
Feature: UKUSQDF-173_AT_UseWebclientToPullMonthlyDataByDay
	In order to obtain cnx trade activity data
	As a QDF tester
	I want access to historic trade activity reports

Scenario: get cnx trade activity reports for all days between 2 dates
	When I load cnx trade activities from '30-10-2012' to '02-11-2012' for the included logins
