@UKUSQDF_140 @cnxHubTradeActivityImporter:Csv
Feature: UKUSQDF-140 [AT] load cnx-fix-deals
	In order to check cnx-fix-deals have been loaded from file
	As a QDF tester
	I want to be able to compare them with cnx-hub data

Background: List of Logins
Given I have this list of takers to load from cnx hub
	| Login     | Name                                 |
	| AUKUS2102 | Lucror                               |
	| AUKUS2089 | Chase Capital                        |
	| AUKUS2065 | Leverate Financial                   |
	| AUKUS2095 | TradingServices                      |
	| AUKUS2099 | BostonPrime                          |
	| AUKUS2106 | Gedik                                |
	| AUKUS2033 | Forex Financial                      |
	| AUKUS1004 | Royal Forex Trading                  |
	| AUKP2962  | Accurate Investment                  |
	| AUKUS2026 | TTCM Traders Trust                   |
	| AUKP3064  | Fidus SAL                            |
	| AUKP2848  | Aganex                               |
	| AUKUS2078 | Scope                                |
	| AUKP3156  | Gerhardus                            |
	| AUKP3399  | Atef Abdulrahman Mohammed AlNuwaiser |
	| AUKP3038  | Arab International                   |
	| AUKP1050  | Bailey                               |
	| AUKP3233  | Mohammad Najmudeen                   |
	| AUKP2193  | Uros Frantar                         |
	| AUKP3216  | Javier Timerman                      |

Scenario: load data from uk-redis-dev cnx-fix-deals
	Given I have the following search criteria for qdf deals
		 | DealSource    | DealType | ConvertedStartTime   | ConvertedEndTime     |
		 | cnx-fix-deals | deal     | 01/05/2014  00:00:00 | 01/05/2014  23:59:59 |
	When I retrieve the qdf deal data
	#And I export the data to "C:\temp\temp.csv" and import the csv
	Then the count of retrieved deals will be 3484

@redisLocalhost @RedisDataImportParams:deal:cnx_fix_deals:TestData\cnx_fix_deals_mini.csv
Scenario: use localhost to load data to uk-redis-dev cnx-fix-deals
	Given I have the following search criteria for qdf deals
		 | DealSource    | DealType | ConvertedStartTime   | ConvertedEndTime     |
		 | cnx-fix-deals | deal     | 01/05/2014  00:00:00 | 01/05/2014  23:59:59 |
	When I retrieve the qdf deal data
	#And I export the data to "C:\temp\temp.csv" and import the csv
	Then the count of retrieved deals will be 10

Scenario: Load Cnx Hub Data
	When I load cnx trade activities from "TestData\Alpari UK_TradeActivity_20140531Mini.csv"
	Then the count of loaded cnx trade activities is 10

@redisLocalhost @RedisDataImportParams:deal:cnx_fix_deals:TestData\cnx_fix_deals_mini.csv
Scenario: Use Localhost to check qdf cnx-deals and cnx hub deals and do comparison
	Given I have the following search criteria for qdf deals
		 | DealSource    | DealType |
		 | cnx-fix-deals | deal     |
	#When I load cnx trade activities for the included logins from
	#	| FileNamePath                                      | ConvertedStartTime   | ConvertedEndTime     |
	#	| TestData\Alpari UK_TradeActivity_20140531Mini.csv | 01/05/2014  00:00:00 | 01/05/2014  23:59:59 |
	When I load cnx trade activities from "TestData\Alpari UK_TradeActivity_20140531Mini.csv" and reverse the deal side
		And I retrieve the qdf deal data filtered by cnx hub start and end times and by included logins
		And I compare the cnx hub trade deals with the qdf deal data excluding these fields:
		 | ExcludedFields |
		 | Comment        |
		 | AccountGroup   |
		 | Book           |
		 | OrderId        |
		 | State          |

	Then the cnx hub trade deals should match the qdf deal data exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |