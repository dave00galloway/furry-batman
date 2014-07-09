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
	When I load cnx trade activities from "TestData\TradeActivitiesForAllAccountsFrom07-08-2014To07-08-2014.csv" for the selected logins
	Then the count of loaded cnx trade activities is 2421

Scenario: Load Cnx Hub Data for specified logins and check dates
	When I load cnx trade activities from "TestData\TradeActivitiesForAllAccountsFrom07-08-2014To07-08-2014.csv" for the selected logins
	Then the earliest cnx trade activity is "07/07/2014  19:13:00"
	And the latest cnx trade activity is "08/07/2014  20:56:00"