@UKUSQDF_173 @cnxHubTradeActivityImporter:WebClient
Feature: UKUSQDF-173_AT_UseWebclientToPullMonthlyDataByDay
	In order to obtain cnx trade activity data
	As a QDF tester
	I want access to historic trade activity reports

Scenario: get cnx trade activity reports for all days between 2 dates
	When I load cnx trade activities from '22-04-2012' to '31-12-2012' for the included logins

@ignore
# there is a unique id generated which isn't visible in the html response that is needed to generate the page. 
#the list of logins is also not complete, so a hardcoded list should be used instead
Scenario: get list of accounts from trade activity report page
	Given I have a list of logins from the trade activity report
