@UKUSQDF_138 @cnxHubTradeActivityImporter:Csv
Feature: UKUSQDF-138 [AT] QDF - retrieving deals over midnight cnxstp-pret-deals-all
	In order to query data over a range of dates
	As a QDF Analyst
	I want to be able to query over midnight
	#need 2 features as can't test kes in dev and prod in the same feature yet

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

Scenario: check qdf cnx-deals and cnx hub deals and do comparison Jan 2014
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals-all | deal     |
	When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	#When I load cnx trade activities with the side reversed for the included logins from
	#	| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
	#	| C:\data\Alpari UK_TradeActivity_20140131.csv | 01/01/2014  22:02:31 | 30/01/2014  23:59:59 |
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
