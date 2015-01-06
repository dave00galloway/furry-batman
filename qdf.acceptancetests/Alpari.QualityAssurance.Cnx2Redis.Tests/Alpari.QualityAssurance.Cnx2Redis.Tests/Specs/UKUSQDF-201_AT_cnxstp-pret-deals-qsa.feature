@UKUSQDF_201 @cnxHubTradeActivityImporter:WebClient
Feature: UKUSQDF-201 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data http request
	In order to have confidence in the cnx-deals data
	As a QDF analyst
	I want to see that cnx-deals data matches data from cnx admin hub

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

Scenario Outline: UKUSQDF-201 Test Redis STP data from new FIX STP feed
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType     |
		 | cnxstp-pret-deals-qsa | BookLessDeal |
	When I load cnx trade activities for "<reportDate>" for the included logins
		And I retrieve the qdf deal data filtered by cnx hub start and end times and by included logins
		And I compare the cnx hub trade deals with the qdf deal data excluding these fields:
		 | ExcludedFields |
		 | Comment        |
		 | AccountGroup   |
		 | Book           |
		 | OrderId        |
		 | State          |
		 | BankPrice      |
	Then the cnx hub trade deals should match the qdf deal data exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
	Examples: 
	| reportDate |
	| 12/08/2014 |
	| 12/09/2014 |
	| 12/10/2014 |
	| 12/11/2014 |
	| 12/12/2014 |
	| 12/13/2014 |
	| 12/14/2014 |
	| 12/15/2014 |
	| 12/16/2014 |
	| 12/17/2014 |
	| 12/18/2014 |
	| 12/19/2014 |
	| 12/20/2014 |
	| 12/21/2014 |
	| 12/22/2014 |
	| 12/23/2014 |
	| 12/24/2014 |
	| 12/25/2014 |
	| 12/26/2014 |
	| 12/27/2014 |
	| 12/28/2014 |
	| 12/29/2014 |
	| 12/30/2014 |
	| 12/31/2014 |
	| 12/01/2014 |
	| 12/02/2014 |
	| 12/03/2014 |


Scenario Outline: UKUSQDF-201 Test Redis STP data from new FIX STP feed Jan 2015
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType     |
		 | cnxstp-pret-deals-qsa | BookLessDeal |
	When I load cnx trade activities for "<reportDate>" for the included logins
		And I retrieve the qdf deal data filtered by cnx hub start and end times and by included logins
		And I compare the cnx hub trade deals with the qdf deal data excluding these fields:
		 | ExcludedFields |
		 | Comment        |
		 | AccountGroup   |
		 | Book           |
		 | OrderId        |
		 | State          |
		 | BankPrice      |
	Then the cnx hub trade deals should match the qdf deal data exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
	Examples: 
	| reportDate |
	| reportDate |
	| 01/01/2014 |
	| 01/02/2014 |
	| 01/03/2014 |
	| 01/04/2014 |
	| 01/05/2014 |
	#| 01/06/2014 |
	#| 01/07/2014 |
	#| 01/08/2014 |
	#| 01/09/2014 |
	#| 01/10/2014 |
	#| 01/11/2014 |
	#| 01/12/2014 |
	#| 01/13/2014 |
	#| 01/14/2014 |
	#| 01/15/2014 |
	#| 01/16/2014 |
	#| 01/17/2014 |
	#| 01/18/2014 |
	#| 01/19/2014 |
	#| 01/20/2014 |
	#| 01/21/2014 |
	#| 01/22/2014 |
	#| 01/23/2014 |
	#| 01/24/2014 |
	#| 01/25/2014 |
	#| 01/26/2014 |
	#| 01/27/2014 |
	#| 01/28/2014 |
	#| 01/29/2014 |
	#| 01/30/2014 |
	#| 01/31/2014 |