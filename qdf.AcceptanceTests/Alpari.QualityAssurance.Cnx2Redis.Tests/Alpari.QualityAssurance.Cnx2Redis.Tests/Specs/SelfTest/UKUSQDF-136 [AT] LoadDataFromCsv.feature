@UKUSQDF_136 @cnxHubTradeActivityImporter:Csv
Feature: UKUSQDF-136 [AT] LoadDataFromCsv
	In order to test Redis cnx-deals agains cnx-hub
	As a QDF Tester
	I want to be able to load selected deals from cnx hub csv

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

Scenario: Load specified logins
	Then the list of included logins contains 20 logins

Scenario: Load Cnx Hub Data
	When I load cnx trade activities from "TestData\TradeActivitiesForAllAccountsFrom07-08-2014To07-08-2014.csv"
	Then the count of loaded cnx trade activities is 2460

Scenario: Load Cnx Hub Data for specified logins
	When I load cnx trade activities from "TestData\TradeActivitiesForAllAccountsFrom07-08-2014To07-08-2014.csv" for the included logins
	Then the count of loaded cnx trade activities is 2421

Scenario: Load Cnx Hub Data for specified logins and check dates
	When I load cnx trade activities from "TestData\TradeActivitiesForAllAccountsFrom07-08-2014To07-08-2014.csv" for the included logins
	Then the earliest cnx trade activity is "07/07/2014  19:13:00"
	And the latest cnx trade activity is "08/07/2014  20:56:00"

#have to use bookless deal as the qdf cnx-deals were being populated with string values not book values at this point in time
Scenario: Use Loaded data to determine query parameters for searching redis
	Given I have the following search criteria for qdf deals
	 | DealSource |  DealType     |
	 | cnx-deals  |  BookLessDeal |
	When I load cnx trade activities from "TestData\TradeActivitiesForAllAccountsFrom07-08-2014To07-08-2014.csv" for the included logins
		And I update the qdf deal criteria with start and end times 
		And I retrieve the qdf deal data
	Then no retrieved deal will have a timestamp outside "07/07/2014  19:13:00" to "08/07/2014  20:56:00"

Scenario: Use included logins to filter qdf deals
	Given I have the following search criteria for qdf deals
	 | DealSource |  DealType     |
	 | cnx-deals  |  BookLessDeal |
	When I load cnx trade activities from "TestData\TradeActivitiesForAllAccountsFrom07-08-2014To07-08-2014.csv" for the included logins
		And I retrieve the qdf deal data filtered by cnx hub start and end times and by included logins
	Then all retrieved deals will have a client id from the included logins list

#hopefully using book values now, but apparently there is some bad data as throwing on book...
Scenario: Load Cnx Hub Data for specified logins and check dates with book-fixed deals
	When I load cnx trade activities from "TestData\TradeActivitiesForAllAccountsFrom07-10-2014To07-10-2014.csv" for the included logins
	Then the earliest cnx trade activity is "09/07/2014  19:00:00"
	And the latest cnx trade activity is "10/07/2014  13:22:24"

# not returning deals over midnight
@UKUSQDF_138
Scenario: Use Loaded data to determine query parameters for searching redis with book-fixed deals
	Given I have the following search criteria for qdf deals
	 | DealSource | DealType     |
	 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities from "TestData\TradeActivitiesForAllAccountsFrom07-10-2014To07-10-2014.csv" for the included logins
		And I update the qdf deal criteria with start and end times 
		And I retrieve the qdf deal data
		#And I export the data to "C:\temp\temp.csv" and import the csv
	Then no retrieved deal will have a timestamp outside "09/07/2014  19:00:00" to "10/07/2014  13:22:24"

Scenario: Use included logins to filter qdf deals with book-fixed deals
	Given I have the following search criteria for qdf deals
	 | DealSource | DealType     |
	 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities from "TestData\TradeActivitiesForAllAccountsFrom07-10-2014To07-10-2014.csv" for the included logins
		And I retrieve the qdf deal data filtered by cnx hub start and end times and by included logins
	Then all retrieved deals will have a client id from the included logins list

#workarounds for https://jira.corp.alpari.com/browse/UKUSQDF-138
Scenario: Load Cnx Hub Data can accept hard coded date parameters workaround
	When I load cnx trade activities from
		| FileNamePath                                                         | ConvertedStartTime   | ConvertedEndTime     |
		| TestData\TradeActivitiesForAllAccountsFrom07-10-2014To07-10-2014.csv | 09/07/2014  19:00:00 | 09/07/2014  23:59:59 |
	Then the count of loaded cnx trade activities is 141

#just so happens that filtering the trades with these start and end dates and logins, makes no difference. try including only 1 name in the included list to check
Scenario: Load Cnx Hub Data for specified logins can accept hard coded date parameters workaround
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                         | ConvertedStartTime   | ConvertedEndTime     |
		| TestData\TradeActivitiesForAllAccountsFrom07-10-2014To07-10-2014.csv | 09/07/2014  19:00:00 | 09/07/2014  23:59:59 |
	Then the count of loaded cnx trade activities is 141

Scenario: Load Cnx Hub Data for specified logins and check dates can accept hard coded date parameters workaround
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                         | ConvertedStartTime   | ConvertedEndTime     |
		| TestData\TradeActivitiesForAllAccountsFrom07-10-2014To07-10-2014.csv | 09/07/2014  19:00:00 | 09/07/2014  23:59:59 |
	Then the earliest cnx trade activity is "09/07/2014  19:00:00"
		And the latest cnx trade activity is "09/07/2014  23:59:24"

Scenario: Use included logins to filter qdf deals with book-fixed deals can accept hard coded date parameters workaround
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                         | ConvertedStartTime   | ConvertedEndTime     |
		| TestData\TradeActivitiesForAllAccountsFrom07-10-2014To07-10-2014.csv | 09/07/2014  19:00:00 | 09/07/2014  23:59:59 |
		And I retrieve the qdf deal data filtered by cnx hub start and end times and by included logins
	Then all retrieved deals will have a client id from the included logins list

@redisLocalhost @RedisDataImportParams:deal:cnx_deals:TestData\cnx.csv @MySqlLocalhost
Scenario: Use Localhost to check qdf cnx-deals and cnx hub deals
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                             | ConvertedStartTime   | ConvertedEndTime     |
		| TestData\TradeActivitiesMini10thJuly.csv | 10/07/2014  01:29:20 | 10/07/2014  01:30:04 |
		And I retrieve the qdf deal data filtered by cnx hub start and end times and by included logins
	Then no retrieved deal will have a timestamp outside "10/07/2014  01:29:21" to "10/07/2014  01:30:03"
		And the count of retrieved deals will be 13
		And the earliest cnx trade activity is "10/07/2014  01:29:21"
		And the latest cnx trade activity is "10/07/2014  01:30:03"
		And the count of loaded cnx trade activities is 13

@redisLocalhost @RedisDataImportParams:deal:cnx_deals:TestData\cnx.csv @MySqlLocalhost
Scenario: Use Localhost to check qdf cnx-deals and cnx hub deals and do comparison
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                             | ConvertedStartTime   | ConvertedEndTime     |
		| TestData\TradeActivitiesMini10thJuly.csv | 10/07/2014  01:29:20 | 10/07/2014  01:30:04 |
		And I retrieve the qdf deal data filtered by cnx hub start and end times and by included logins
		#And I compare the cnx trade deals with the qdf deal data excluding these fields:
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