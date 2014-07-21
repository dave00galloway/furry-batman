@UKUSQDF_149 @redisLocalhost @RedisDataImportParams:deal:cnx_deals:TestData\UKUSQDF-149cnx-deals.csv @cnxHubTradeActivityImporter:Csv
Feature: UKUSQDF-149FilterNonKiwiDealsDuringRollover
	In order to get the correct deals for comparison between cnx-deals and cnx hub admin
	As a QDF Tester
	I want to filter non NZD deals during the rollover period

Scenario: Filter non kiwi deals during rollover
	Given I have the following search criteria for qdf deals
		 | DealSource |
		 | cnx-deals  |
	When I load cnx trade activities from "TestData\UKUSQDF-149CnxHubData.csv" for the included logins
		And I retrieve the qdf deal data filtered by cnx hub start and end times and by included logins
	Then the count of loaded cnx trade activities is 6
	And the count of retrieved deals will be 4



#		And I compare the cnx hub trade deals with the qdf deal data excluding these fields:
#		 | ExcludedFields |
#		 | Comment        |
#		 | AccountGroup   |
#		 | Book           |
#		 | OrderId        |
#		 | State          |
#
#	Then the cnx hub trade deals should match the qdf deal data exactly:-
#		| ExportType     |  Overwrite |
#		| DataTableToCsv |  true      |