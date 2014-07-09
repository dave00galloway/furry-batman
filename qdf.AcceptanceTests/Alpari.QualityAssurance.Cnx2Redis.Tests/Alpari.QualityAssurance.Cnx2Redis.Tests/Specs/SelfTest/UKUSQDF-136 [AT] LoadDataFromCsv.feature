Feature: UKUSQDF-136 [AT] LoadDataFromCsv
	In order to test Redis cnx-deals agains cnx-hub
	As a QDF Tester
	I want to be able to load selected deals from cnx hub csv

Background: List of Logins
Given I have this list of logins to load from cnx hub
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


Scenario: Add two numbers
	Given I have entered 50 into the calculator
	And I have entered 70 into the calculator
	When I press add
	Then the result should be 120 on the screen
