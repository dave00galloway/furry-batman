﻿@UKUSQDF_136 @cnxHubTradeActivityImporter:WebClient
Feature: UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data http request
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

Scenario Outline: UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data from http request
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for "<reportDate>" for the included logins
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
	Examples: 
	| reportDate | 
	| 08/05/2014 |  
	| 08/06/2014 |
	| 08/07/2014 |
	| 08/08/2014 |
	| 08/09/2014 |
	| 08/10/2014 |
	| 08/11/2014 |
	| 08/12/2014 |
	| 08/13/2014 |
	| 08/14/2014 |
	| 08/15/2014 |
	| 08/16/2014 |
	| 08/17/2014 |
	| 08/18/2014 |
	| 08/19/2014 |
	| 08/20/2014 |
	| 08/21/2014 |
	| 08/22/2014 |
	| 08/23/2014 |
	| 08/24/2014 |
	| 08/25/2014 |
	| 08/26/2014 |
	| 08/27/2014 |
	| 08/28/2014 |
	| 08/29/2014 |
	| 08/30/2014 |
	| 08/31/2014 |
	| 09/01/2014 |

Scenario Outline: UKUSQDF-136 [AT] Cnx2Redis Data Collector - redeploy at build 31
	Given I have the following search criteria for qdf deals
		 | DealSource        | DealType     |
		 | cnxstp-pret-deals | BookLessDeal |
	When I load cnx trade activities for "<reportDate>" for the included logins
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
	Examples: 
	| reportDate |
	| 08/31/2014 |
	| 09/01/2014 |
	| 09/02/2014 |
	| 09/03/2014 |		 
	| 09/04/2014 |
	| 09/05/2014 |
	| 09/06/2014 |
	| 09/07/2014 |
	| 09/08/2014 |
	| 09/09/2014 |
	| 09/10/2014 |
	| 09/11/2014 |
	| 09/12/2014 |
	| 09/13/2014 |
	| 09/14/2014 |
	| 09/15/2014 |
	| 09/16/2014 |
	| 09/17/2014 |
	| 09/18/2014 |
	| 09/19/2014 |


Scenario Outline: UKUSQDF-136 [AT] Cnx2Redis Data Collector - redeploy at build 31 2014
	Given I have the following search criteria for qdf deals
		 | DealSource        | DealType     |
		 | cnxstp-pret-deals | BookLessDeal |
	When I load cnx trade activities for "<reportDate>" for the included logins
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
	Examples: 
	| reportDate |
	| 09/01/2014 |
	| 08/31/2014 |
	| 08/30/2014 |
	| 08/29/2014 |
	| 08/28/2014 |
	| 08/27/2014 |
	| 08/26/2014 |
	| 08/25/2014 |
	| 08/24/2014 |
	| 08/23/2014 |
	| 08/22/2014 |
	| 08/21/2014 |
	| 08/20/2014 |
	| 08/19/2014 |
	| 08/18/2014 |
	| 08/17/2014 |
	| 08/16/2014 |
	| 08/15/2014 |
	| 08/14/2014 |
	| 08/13/2014 |
	| 08/12/2014 |
	| 08/11/2014 |
	| 08/10/2014 |
	| 08/09/2014 |
	| 08/08/2014 |
	| 08/07/2014 |
	| 08/06/2014 |
	| 08/05/2014 |
	| 08/04/2014 |
	| 08/03/2014 |
	| 08/02/2014 |
	| 08/01/2014 |
	| 07/31/2014 |
	| 07/30/2014 |
	| 07/29/2014 |
	| 07/28/2014 |
	| 07/27/2014 |
	| 07/26/2014 |
	| 07/25/2014 |
	| 07/24/2014 |
	| 07/23/2014 |
	| 07/22/2014 |
	| 07/21/2014 |
	| 07/20/2014 |
	| 07/19/2014 |
	| 07/18/2014 |
	| 07/17/2014 |
	| 07/16/2014 |
	| 07/15/2014 |
	| 07/14/2014 |
	| 07/13/2014 |
	| 07/12/2014 |
	| 07/11/2014 |
	| 07/10/2014 |
	| 07/09/2014 |
	| 07/08/2014 |
	| 07/07/2014 |
	| 07/06/2014 |
	| 07/05/2014 |
	| 07/04/2014 |
	| 07/03/2014 |
	| 07/02/2014 |
	| 07/01/2014 |
	| 06/30/2014 |
	| 06/29/2014 |
	| 06/28/2014 |
	| 06/27/2014 |
	| 06/26/2014 |
	| 06/25/2014 |
	| 06/24/2014 |
	| 06/23/2014 |
	| 06/22/2014 |
	| 06/21/2014 |
	| 06/20/2014 |
	| 06/19/2014 |
	| 06/18/2014 |
	| 06/17/2014 |
	| 06/16/2014 |
	| 06/15/2014 |
	| 06/14/2014 |
	| 06/13/2014 |
	| 06/12/2014 |
	| 06/11/2014 |
	| 06/10/2014 |
	| 06/09/2014 |
	| 06/08/2014 |
	| 06/07/2014 |
	| 06/06/2014 |
	| 06/05/2014 |
	| 06/04/2014 |
	| 06/03/2014 |
	| 06/02/2014 |
	| 06/01/2014 |
	| 05/31/2014 |
	| 05/30/2014 |
	| 05/29/2014 |
	| 05/28/2014 |
	| 05/27/2014 |
	| 05/26/2014 |
	| 05/25/2014 |
	| 05/24/2014 |
	| 05/23/2014 |
	| 05/22/2014 |
	| 05/21/2014 |
	| 05/20/2014 |
	| 05/19/2014 |
	| 05/18/2014 |
	| 05/17/2014 |
	| 05/16/2014 |
	| 05/15/2014 |
	| 05/14/2014 |
	| 05/13/2014 |
	| 05/12/2014 |
	| 05/11/2014 |
	| 05/10/2014 |
	| 05/09/2014 |
	| 05/08/2014 |
	| 05/07/2014 |
	| 05/06/2014 |
	| 05/05/2014 |
	| 05/04/2014 |
	| 05/03/2014 |
	| 05/02/2014 |
	| 05/01/2014 |
	| 04/30/2014 |
	| 04/29/2014 |
	| 04/28/2014 |
	| 04/27/2014 |
	| 04/26/2014 |
	| 04/25/2014 |
	| 04/24/2014 |
	| 04/23/2014 |
	| 04/22/2014 |
	| 04/21/2014 |
	| 04/20/2014 |
	| 04/19/2014 |
	| 04/18/2014 |
	| 04/17/2014 |
	| 04/16/2014 |
	| 04/15/2014 |
	| 04/14/2014 |
	| 04/13/2014 |
	| 04/12/2014 |
	| 04/11/2014 |
	| 04/10/2014 |
	| 04/09/2014 |
	| 04/08/2014 |
	| 04/07/2014 |
	| 04/06/2014 |
	| 04/05/2014 |
	| 04/04/2014 |
	| 04/03/2014 |
	| 04/02/2014 |
	| 04/01/2014 |
	| 03/31/2014 |
	| 03/30/2014 |
	| 03/29/2014 |
	| 03/28/2014 |
	| 03/27/2014 |
	| 03/26/2014 |
	| 03/25/2014 |
	| 03/24/2014 |
	| 03/23/2014 |
	| 03/22/2014 |
	| 03/21/2014 |
	| 03/20/2014 |
	| 03/19/2014 |
	| 03/18/2014 |
	| 03/17/2014 |
	| 03/16/2014 |
	| 03/15/2014 |
	| 03/14/2014 |
	| 03/13/2014 |
	| 03/12/2014 |
	| 03/11/2014 |
	| 03/10/2014 |
	| 03/09/2014 |
	| 03/08/2014 |
	| 03/07/2014 |
	| 03/06/2014 |
	| 03/05/2014 |
	| 03/04/2014 |
	| 03/03/2014 |
	| 03/02/2014 |
	| 03/01/2014 |
	| 02/28/2014 |
	| 02/27/2014 |
	| 02/26/2014 |
	| 02/25/2014 |
	| 02/24/2014 |
	| 02/23/2014 |
	| 02/22/2014 |
	| 02/21/2014 |
	| 02/20/2014 |
	| 02/19/2014 |
	| 02/18/2014 |
	| 02/17/2014 |
	| 02/16/2014 |
	| 02/15/2014 |
	| 02/14/2014 |
	| 02/13/2014 |
	| 02/12/2014 |
	| 02/11/2014 |
	| 02/10/2014 |
	| 02/09/2014 |
	| 02/08/2014 |
	| 02/07/2014 |
	| 02/06/2014 |
	| 02/05/2014 |
	| 02/04/2014 |
	| 02/03/2014 |
	| 02/02/2014 |
	| 02/01/2014 |
	| 01/31/2014 |
	| 01/30/2014 |
	| 01/29/2014 |
	| 01/28/2014 |
	| 01/27/2014 |
	| 01/26/2014 |
	| 01/25/2014 |
	| 01/24/2014 |
	| 01/23/2014 |
	| 01/22/2014 |
	| 01/21/2014 |
	| 01/20/2014 |
	| 01/19/2014 |
	| 01/18/2014 |
	| 01/17/2014 |
	| 01/16/2014 |
	| 01/15/2014 |
	| 01/14/2014 |
	| 01/13/2014 |
	| 01/12/2014 |
	| 01/11/2014 |
	| 01/10/2014 |
	| 01/09/2014 |
	| 01/08/2014 |
	| 01/07/2014 |
	| 01/06/2014 |
	| 01/05/2014 |
	| 01/04/2014 |
	| 01/03/2014 |
	| 01/02/2014 |
	| 01/01/2014 |

Scenario Outline: UKUSQDF-136 [AT] Cnx2Redis Data Collector - redeploy at build 31 2013
	Given I have the following search criteria for qdf deals
		 | DealSource        | DealType     |
		 | cnxstp-pret-deals | BookLessDeal |
	When I load cnx trade activities for "<reportDate>" for the included logins
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
	Examples: 
	| reportDate |
	| 12/31/2013 |
	| 12/30/2013 |
	| 12/29/2013 |
	| 12/28/2013 |
	| 12/27/2013 |
	| 12/26/2013 |
	| 12/25/2013 |
	| 12/24/2013 |
	| 12/23/2013 |
	| 12/22/2013 |
	| 12/21/2013 |
	| 12/20/2013 |
	| 12/19/2013 |
	| 12/18/2013 |
	| 12/17/2013 |
	| 12/16/2013 |
	| 12/15/2013 |
	| 12/14/2013 |
	| 12/13/2013 |
	| 12/12/2013 |
	| 12/11/2013 |
	| 12/10/2013 |
	| 12/09/2013 |
	| 12/08/2013 |
	| 12/07/2013 |
	| 12/06/2013 |
	| 12/05/2013 |
	| 12/04/2013 |
	| 12/03/2013 |
	| 12/02/2013 |
	| 12/01/2013 |
	| 11/30/2013 |
	| 11/29/2013 |
	| 11/28/2013 |
	| 11/27/2013 |
	| 11/26/2013 |
	| 11/25/2013 |
	| 11/24/2013 |
	| 11/23/2013 |
	| 11/22/2013 |
	| 11/21/2013 |
	| 11/20/2013 |
	| 11/19/2013 |
	| 11/18/2013 |
	| 11/17/2013 |
	| 11/16/2013 |
	| 11/15/2013 |
	| 11/14/2013 |
	| 11/13/2013 |
	| 11/12/2013 |
	| 11/11/2013 |
	| 11/10/2013 |
	| 11/09/2013 |
	| 11/08/2013 |
	| 11/07/2013 |
	| 11/06/2013 |
	| 11/05/2013 |
	| 11/04/2013 |
	| 11/03/2013 |
	| 11/02/2013 |
	| 11/01/2013 |
	| 10/31/2013 |
	| 10/30/2013 |
	| 10/29/2013 |
	| 10/28/2013 |
	| 10/27/2013 |
	| 10/26/2013 |
	| 10/25/2013 |
	| 10/24/2013 |
	| 10/23/2013 |
	| 10/22/2013 |
	| 10/21/2013 |
	| 10/20/2013 |
	| 10/19/2013 |
	| 10/18/2013 |
	| 10/17/2013 |
	| 10/16/2013 |
	| 10/15/2013 |
	| 10/14/2013 |
	| 10/13/2013 |
	| 10/12/2013 |
	| 10/11/2013 |
	| 10/10/2013 |
	| 10/09/2013 |
	| 10/08/2013 |
	| 10/07/2013 |
	| 10/06/2013 |
	| 10/05/2013 |
	| 10/04/2013 |
	| 10/03/2013 |
	| 10/02/2013 |
	| 10/01/2013 |
	| 09/30/2013 |
	| 09/29/2013 |
	| 09/28/2013 |
	| 09/27/2013 |
	| 09/26/2013 |
	| 09/25/2013 |
	| 09/24/2013 |
	| 09/23/2013 |
	| 09/22/2013 |
	| 09/21/2013 |
	| 09/20/2013 |
	| 09/19/2013 |
	| 09/18/2013 |
	| 09/17/2013 |
	| 09/16/2013 |
	| 09/15/2013 |
	| 09/14/2013 |
	| 09/13/2013 |
	| 09/12/2013 |
	| 09/11/2013 |
	| 09/10/2013 |
	| 09/09/2013 |
	| 09/08/2013 |
	| 09/07/2013 |
	| 09/06/2013 |
	| 09/05/2013 |
	| 09/04/2013 |
	| 09/03/2013 |
	| 09/02/2013 |
	| 09/01/2013 |
	| 08/31/2013 |
	| 08/30/2013 |
	| 08/29/2013 |
	| 08/28/2013 |
	| 08/27/2013 |
	| 08/26/2013 |
	| 08/25/2013 |
	| 08/24/2013 |
	| 08/23/2013 |
	| 08/22/2013 |
	| 08/21/2013 |
	| 08/20/2013 |
	| 08/19/2013 |
	| 08/18/2013 |
	| 08/17/2013 |
	| 08/16/2013 |
	| 08/15/2013 |
	| 08/14/2013 |
	| 08/13/2013 |
	| 08/12/2013 |
	| 08/11/2013 |
	| 08/10/2013 |
	| 08/09/2013 |
	| 08/08/2013 |
	| 08/07/2013 |
	| 08/06/2013 |
	| 08/05/2013 |
	| 08/04/2013 |
	| 08/03/2013 |
	| 08/02/2013 |
	| 08/01/2013 |
	| 07/31/2013 |
	| 07/30/2013 |
	| 07/29/2013 |
	| 07/28/2013 |
	| 07/27/2013 |
	| 07/26/2013 |
	| 07/25/2013 |
	| 07/24/2013 |
	| 07/23/2013 |
	| 07/22/2013 |
	| 07/21/2013 |
	| 07/20/2013 |
	| 07/19/2013 |
	| 07/18/2013 |
	| 07/17/2013 |
	| 07/16/2013 |
	| 07/15/2013 |
	| 07/14/2013 |
	| 07/13/2013 |
	| 07/12/2013 |
	| 07/11/2013 |
	| 07/10/2013 |
	| 07/09/2013 |
	| 07/08/2013 |
	| 07/07/2013 |
	| 07/06/2013 |
	| 07/05/2013 |
	| 07/04/2013 |
	| 07/03/2013 |
	| 07/02/2013 |
	| 07/01/2013 |
	| 06/30/2013 |
	| 06/29/2013 |
	| 06/28/2013 |
	| 06/27/2013 |
	| 06/26/2013 |
	| 06/25/2013 |
	| 06/24/2013 |
	| 06/23/2013 |
	| 06/22/2013 |
	| 06/21/2013 |
	| 06/20/2013 |
	| 06/19/2013 |
	| 06/18/2013 |
	| 06/17/2013 |
	| 06/16/2013 |
	| 06/15/2013 |
	| 06/14/2013 |
	| 06/13/2013 |
	| 06/12/2013 |
	| 06/11/2013 |
	| 06/10/2013 |
	| 06/09/2013 |
	| 06/08/2013 |
	| 06/07/2013 |
	| 06/06/2013 |
	| 06/05/2013 |
	| 06/04/2013 |
	| 06/03/2013 |
	| 06/02/2013 |
	| 06/01/2013 |
	| 05/31/2013 |
	| 05/30/2013 |
	| 05/29/2013 |
	| 05/28/2013 |
	| 05/27/2013 |
	| 05/26/2013 |
	| 05/25/2013 |
	| 05/24/2013 |
	| 05/23/2013 |
	| 05/22/2013 |
	| 05/21/2013 |
	| 05/20/2013 |
	| 05/19/2013 |
	| 05/18/2013 |
	| 05/17/2013 |
	| 05/16/2013 |
	| 05/15/2013 |
	| 05/14/2013 |
	| 05/13/2013 |
	| 05/12/2013 |
	| 05/11/2013 |
	| 05/10/2013 |
	| 05/09/2013 |
	| 05/08/2013 |
	| 05/07/2013 |
	| 05/06/2013 |
	| 05/05/2013 |
	| 05/04/2013 |
	| 05/03/2013 |
	| 05/02/2013 |
	| 05/01/2013 |
	| 04/30/2013 |
	| 04/29/2013 |
	| 04/28/2013 |
	| 04/27/2013 |
	| 04/26/2013 |
	| 04/25/2013 |
	| 04/24/2013 |
	| 04/23/2013 |
	| 04/22/2013 |
	| 04/21/2013 |
	| 04/20/2013 |
	| 04/19/2013 |
	| 04/18/2013 |
	| 04/17/2013 |
	| 04/16/2013 |
	| 04/15/2013 |
	| 04/14/2013 |
	| 04/13/2013 |
	| 04/12/2013 |
	| 04/11/2013 |
	| 04/10/2013 |
	| 04/09/2013 |
	| 04/08/2013 |
	| 04/07/2013 |
	| 04/06/2013 |
	| 04/05/2013 |
	| 04/04/2013 |
	| 04/03/2013 |
	| 04/02/2013 |
	| 04/01/2013 |
	| 03/31/2013 |
	| 03/30/2013 |
	| 03/29/2013 |
	| 03/28/2013 |
	| 03/27/2013 |
	| 03/26/2013 |
	| 03/25/2013 |
	| 03/24/2013 |
	| 03/23/2013 |
	| 03/22/2013 |
	| 03/21/2013 |
	| 03/20/2013 |
	| 03/19/2013 |
	| 03/18/2013 |
	| 03/17/2013 |
	| 03/16/2013 |
	| 03/15/2013 |
	| 03/14/2013 |
	| 03/13/2013 |
	| 03/12/2013 |
	| 03/11/2013 |
	| 03/10/2013 |
	| 03/09/2013 |
	| 03/08/2013 |
	| 03/07/2013 |
	| 03/06/2013 |
	| 03/05/2013 |
	| 03/04/2013 |
	| 03/03/2013 |
	| 03/02/2013 |
	| 03/01/2013 |
	| 02/28/2013 |
	| 02/27/2013 |
	| 02/26/2013 |
	| 02/25/2013 |
	| 02/24/2013 |
	| 02/23/2013 |
	| 02/22/2013 |
	| 02/21/2013 |
	| 02/20/2013 |
	| 02/19/2013 |
	| 02/18/2013 |
	| 02/17/2013 |
	| 02/16/2013 |
	| 02/15/2013 |
	| 02/14/2013 |
	| 02/13/2013 |
	| 02/12/2013 |
	| 02/11/2013 |
	| 02/10/2013 |
	| 02/09/2013 |
	| 02/08/2013 |
	| 02/07/2013 |
	| 02/06/2013 |
	| 02/05/2013 |
	| 02/04/2013 |
	| 02/03/2013 |
	| 02/02/2013 |
	| 02/01/2013 |
	| 01/31/2013 |
	| 01/30/2013 |
	| 01/29/2013 |
	| 01/28/2013 |
	| 01/27/2013 |
	| 01/26/2013 |
	| 01/25/2013 |
	| 01/24/2013 |
	| 01/23/2013 |
	| 01/22/2013 |
	| 01/21/2013 |
	| 01/20/2013 |
	| 01/19/2013 |
	| 01/18/2013 |
	| 01/17/2013 |
	| 01/16/2013 |
	| 01/15/2013 |
	| 01/14/2013 |
	| 01/13/2013 |
	| 01/12/2013 |
	| 01/11/2013 |
	| 01/10/2013 |
	| 01/09/2013 |
	| 01/08/2013 |
	| 01/07/2013 |
	| 01/06/2013 |
	| 01/05/2013 |
	| 01/04/2013 |
	| 01/03/2013 |
	| 01/02/2013 |
	| 01/01/2013 |


Scenario Outline: UKUSQDF-136 [AT] Cnx2Redis Data Collector - redeploy at build 31 2012
	Given I have the following search criteria for qdf deals
		 | DealSource        | DealType     |
		 | cnxstp-pret-deals | BookLessDeal |
	When I load cnx trade activities for "<reportDate>" for the included logins
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
	Examples: 
	| reportDate |
	| 12/31/2012 |
	| 12/30/2012 |
	| 12/29/2012 |
	| 12/28/2012 |
	| 12/27/2012 |
	| 12/26/2012 |
	| 12/25/2012 |
	| 12/24/2012 |
	| 12/23/2012 |
	| 12/22/2012 |
	| 12/21/2012 |
	| 12/20/2012 |
	| 12/19/2012 |
	| 12/18/2012 |
	| 12/17/2012 |
	| 12/16/2012 |
	| 12/15/2012 |
	| 12/14/2012 |
	| 12/13/2012 |
	| 12/12/2012 |
	| 12/11/2012 |
	| 12/10/2012 |
	| 12/09/2012 |
	| 12/08/2012 |
	| 12/07/2012 |
	| 12/06/2012 |
	| 12/05/2012 |
	| 12/04/2012 |
	| 12/03/2012 |
	| 12/02/2012 |
	| 12/01/2012 |
	| 11/30/2012 |
	| 11/29/2012 |
	| 11/28/2012 |
	| 11/27/2012 |
	| 11/26/2012 |
	| 11/25/2012 |
	| 11/24/2012 |
	| 11/23/2012 |
	| 11/22/2012 |
	| 11/21/2012 |
	| 11/20/2012 |
	| 11/19/2012 |
	| 11/18/2012 |
	| 11/17/2012 |
	| 11/16/2012 |
	| 11/15/2012 |
	| 11/14/2012 |
	| 11/13/2012 |
	| 11/12/2012 |
	| 11/11/2012 |
	| 11/10/2012 |
	| 11/09/2012 |
	| 11/08/2012 |
	| 11/07/2012 |
	| 11/06/2012 |
	| 11/05/2012 |
	| 11/04/2012 |
	| 11/03/2012 |
	| 11/02/2012 |
	| 11/01/2012 |
	| 10/31/2012 |
	| 10/30/2012 |
	| 10/29/2012 |
	| 10/28/2012 |
	| 10/27/2012 |
	| 10/26/2012 |
	| 10/25/2012 |
	| 10/24/2012 |
	| 10/23/2012 |
	| 10/22/2012 |
	| 10/21/2012 |
	| 10/20/2012 |
	| 10/19/2012 |
	| 10/18/2012 |
	| 10/17/2012 |
	| 10/16/2012 |
	| 10/15/2012 |
	| 10/14/2012 |
	| 10/13/2012 |
	| 10/12/2012 |
	| 10/11/2012 |
	| 10/10/2012 |
	| 10/09/2012 |
	| 10/08/2012 |
	| 10/07/2012 |
	| 10/06/2012 |
	| 10/05/2012 |
	| 10/04/2012 |
	| 10/03/2012 |
	| 10/02/2012 |
	| 10/01/2012 |
	| 09/30/2012 |
	| 09/29/2012 |
	| 09/28/2012 |
	| 09/27/2012 |
	| 09/26/2012 |
	| 09/25/2012 |
	| 09/24/2012 |
	| 09/23/2012 |
	| 09/22/2012 |
	| 09/21/2012 |
	| 09/20/2012 |
	| 09/19/2012 |
	| 09/18/2012 |
	| 09/17/2012 |
	| 09/16/2012 |
	| 09/15/2012 |
	| 09/14/2012 |
	| 09/13/2012 |
	| 09/12/2012 |
	| 09/11/2012 |
	| 09/10/2012 |
	| 09/09/2012 |
	| 09/08/2012 |
	| 09/07/2012 |
	| 09/06/2012 |
	| 09/05/2012 |
	| 09/04/2012 |
	| 09/03/2012 |
	| 09/02/2012 |
	| 09/01/2012 |
	| 08/31/2012 |
	| 08/30/2012 |
	| 08/29/2012 |
	| 08/28/2012 |
	| 08/27/2012 |
	| 08/26/2012 |
	| 08/25/2012 |
	| 08/24/2012 |
	| 08/23/2012 |
	| 08/22/2012 |
	| 08/21/2012 |
	| 08/20/2012 |
	| 08/19/2012 |
	| 08/18/2012 |
	| 08/17/2012 |
	| 08/16/2012 |
	| 08/15/2012 |
	| 08/14/2012 |
	| 08/13/2012 |
	| 08/12/2012 |
	| 08/11/2012 |
	| 08/10/2012 |
	| 08/09/2012 |
	| 08/08/2012 |
	| 08/07/2012 |
	| 08/06/2012 |
	| 08/05/2012 |
	| 08/04/2012 |
	| 08/03/2012 |
	| 08/02/2012 |
	| 08/01/2012 |
	| 07/31/2012 |
	| 07/30/2012 |
	| 07/29/2012 |
	| 07/28/2012 |
	| 07/27/2012 |
	| 07/26/2012 |
	| 07/25/2012 |
	| 07/24/2012 |
	| 07/23/2012 |
	| 07/22/2012 |
	| 07/21/2012 |
	| 07/20/2012 |
	| 07/19/2012 |
	| 07/18/2012 |
	| 07/17/2012 |
	| 07/16/2012 |
	| 07/15/2012 |
	| 07/14/2012 |
	| 07/13/2012 |
	| 07/12/2012 |
	| 07/11/2012 |
	| 07/10/2012 |
	| 07/09/2012 |
	| 07/08/2012 |
	| 07/07/2012 |
	| 07/06/2012 |
	| 07/05/2012 |
	| 07/04/2012 |
	| 07/03/2012 |
	| 07/02/2012 |
	| 07/01/2012 |
	| 06/30/2012 |
	| 06/29/2012 |
	| 06/28/2012 |
	| 06/27/2012 |
	| 06/26/2012 |
	| 06/25/2012 |
	| 06/24/2012 |
	| 06/23/2012 |
	| 06/22/2012 |
	| 06/21/2012 |
	| 06/20/2012 |
	| 06/19/2012 |
	| 06/18/2012 |
	| 06/17/2012 |
	| 06/16/2012 |
	| 06/15/2012 |
	| 06/14/2012 |
	| 06/13/2012 |
	| 06/12/2012 |
	| 06/11/2012 |
	| 06/10/2012 |
	| 06/09/2012 |
	| 06/08/2012 |
	| 06/07/2012 |
	| 06/06/2012 |
	| 06/05/2012 |
	| 06/04/2012 |
	| 06/03/2012 |
	| 06/02/2012 |
	| 06/01/2012 |
	| 05/31/2012 |
	| 05/30/2012 |
	| 05/29/2012 |
	| 05/28/2012 |
	| 05/27/2012 |
	| 05/26/2012 |
	| 05/25/2012 |
	| 05/24/2012 |
	| 05/23/2012 |
	| 05/22/2012 |
	| 05/21/2012 |
	| 05/20/2012 |
	| 05/19/2012 |
	| 05/18/2012 |
	| 05/17/2012 |
	| 05/16/2012 |
	| 05/15/2012 |
	| 05/14/2012 |
	| 05/13/2012 |
	| 05/12/2012 |
	| 05/11/2012 |
	| 05/10/2012 |
	| 05/09/2012 |
	| 05/08/2012 |
	| 05/07/2012 |
	| 05/06/2012 |
	| 05/05/2012 |
	| 05/04/2012 |
	| 05/03/2012 |
	| 05/02/2012 |
	| 05/01/2012 |
	| 04/30/2012 |
	| 04/29/2012 |
	| 04/28/2012 |
	| 04/27/2012 |
	| 04/26/2012 |
	| 04/25/2012 |
	| 04/24/2012 |
	| 04/23/2012 |
	| 04/22/2012 |
	| 04/21/2012 |
	| 04/20/2012 |
	| 04/19/2012 |
	| 04/18/2012 |
	| 04/17/2012 |
	| 04/16/2012 |
	| 04/15/2012 |
	| 04/14/2012 |
	| 04/13/2012 |
	| 04/12/2012 |
	| 04/11/2012 |
	| 04/10/2012 |
	| 04/09/2012 |
	| 04/08/2012 |
	| 04/07/2012 |
	| 04/06/2012 |
	| 04/05/2012 |
	| 04/04/2012 |
	| 04/03/2012 |
	| 04/02/2012 |
	| 04/01/2012 |
	| 03/31/2012 |
	| 03/30/2012 |
	| 03/29/2012 |
	| 03/28/2012 |
	| 03/27/2012 |
	| 03/26/2012 |
	| 03/25/2012 |
	| 03/24/2012 |
	| 03/23/2012 |
	| 03/22/2012 |
	| 03/21/2012 |
	| 03/20/2012 |
	| 03/19/2012 |
	| 03/18/2012 |
	| 03/17/2012 |
	| 03/16/2012 |
	| 03/15/2012 |
	| 03/14/2012 |
	| 03/13/2012 |
	| 03/12/2012 |
	| 03/11/2012 |
	| 03/10/2012 |
	| 03/09/2012 |
	| 03/08/2012 |
	| 03/07/2012 |
	| 03/06/2012 |
	| 03/05/2012 |
	| 03/04/2012 |
	| 03/03/2012 |
	| 03/02/2012 |
	| 03/01/2012 |
	| 02/29/2012 |
	| 02/28/2012 |
	| 02/27/2012 |
	| 02/26/2012 |
	| 02/25/2012 |
	| 02/24/2012 |
	| 02/23/2012 |
	| 02/22/2012 |
	| 02/21/2012 |
	| 02/20/2012 |
	| 02/19/2012 |
	| 02/18/2012 |
	| 02/17/2012 |
	| 02/16/2012 |
	| 02/15/2012 |
	| 02/14/2012 |
	| 02/13/2012 |
	| 02/12/2012 |
	| 02/11/2012 |
	| 02/10/2012 |
	| 02/09/2012 |
	| 02/08/2012 |
	| 02/07/2012 |
	| 02/06/2012 |
	| 02/05/2012 |
	| 02/04/2012 |
	| 02/03/2012 |
	| 02/02/2012 |
	| 02/01/2012 |
	| 01/31/2012 |
	| 01/30/2012 |
	| 01/29/2012 |
	| 01/28/2012 |
	| 01/27/2012 |
	| 01/26/2012 |
	| 01/25/2012 |
	| 01/24/2012 |
	| 01/23/2012 |
	| 01/22/2012 |
	| 01/21/2012 |
	| 01/20/2012 |
	| 01/19/2012 |
	| 01/18/2012 |
	| 01/17/2012 |
	| 01/16/2012 |
	| 01/15/2012 |
	| 01/14/2012 |
	| 01/13/2012 |
	| 01/12/2012 |
	| 01/11/2012 |
	| 01/10/2012 |
	| 01/09/2012 |
	| 01/08/2012 |
	| 01/07/2012 |
	| 01/06/2012 |
	| 01/05/2012 |
	| 01/04/2012 |
	| 01/03/2012 |
	| 01/02/2012 |
	| 01/01/2012 |


Scenario Outline: UKUSQDF-136 [AT] Cnx2Redis Data Collector - redeploy at build 31 2011
	Given I have the following search criteria for qdf deals
		 | DealSource        | DealType     |
		 | cnxstp-pret-deals | BookLessDeal |
	When I load cnx trade activities for "<reportDate>" for the included logins
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
	Examples: 
	| reportDate |
	| 12/31/2011 |
	| 12/30/2011 |
	| 12/29/2011 |
	| 12/28/2011 |
	| 12/27/2011 |
	| 12/26/2011 |
	| 12/25/2011 |
	| 12/24/2011 |
	| 12/23/2011 |
	| 12/22/2011 |
	| 12/21/2011 |
	| 12/20/2011 |
	| 12/19/2011 |
	| 12/18/2011 |
	| 12/17/2011 |
	| 12/16/2011 |
	| 12/15/2011 |
	| 12/14/2011 |
	| 12/13/2011 |
	| 12/12/2011 |
	| 12/11/2011 |
	| 12/10/2011 |
	| 12/09/2011 |
	| 12/08/2011 |
	| 12/07/2011 |
	| 12/06/2011 |
	| 12/05/2011 |
	| 12/04/2011 |
	| 12/03/2011 |
	| 12/02/2011 |
	| 12/01/2011 |
	| 11/30/2011 |
	| 11/29/2011 |
	| 11/28/2011 |
	| 11/27/2011 |
	| 11/26/2011 |
	| 11/25/2011 |
	| 11/24/2011 |
	| 11/23/2011 |
	| 11/22/2011 |
	| 11/21/2011 |
	| 11/20/2011 |
	| 11/19/2011 |
	| 11/18/2011 |
	| 11/17/2011 |
	| 11/16/2011 |
	| 11/15/2011 |
	| 11/14/2011 |
	| 11/13/2011 |
	| 11/12/2011 |
	| 11/11/2011 |
	| 11/10/2011 |
	| 11/09/2011 |
	| 11/08/2011 |
	| 11/07/2011 |
	| 11/06/2011 |
	| 11/05/2011 |
	| 11/04/2011 |
	| 11/03/2011 |
	| 11/02/2011 |
	| 11/01/2011 |
	| 10/31/2011 |
	| 10/30/2011 |
	| 10/29/2011 |
	| 10/28/2011 |
	| 10/27/2011 |
	| 10/26/2011 |
	| 10/25/2011 |
	| 10/24/2011 |
	| 10/23/2011 |
	| 10/22/2011 |
	| 10/21/2011 |
	| 10/20/2011 |
	| 10/19/2011 |
	| 10/18/2011 |
	| 10/17/2011 |
	| 10/16/2011 |
	| 10/15/2011 |
	| 10/14/2011 |
	| 10/13/2011 |
	| 10/12/2011 |
	| 10/11/2011 |
	| 10/10/2011 |
	| 10/09/2011 |
	| 10/08/2011 |
	| 10/07/2011 |
	| 10/06/2011 |
	| 10/05/2011 |
	| 10/04/2011 |
	| 10/03/2011 |
	| 10/02/2011 |
	| 10/01/2011 |
	| 09/30/2011 |
	| 09/29/2011 |
	| 09/28/2011 |
	| 09/27/2011 |
	| 09/26/2011 |
	| 09/25/2011 |
	| 09/24/2011 |
	| 09/23/2011 |
	| 09/22/2011 |
	| 09/21/2011 |
	| 09/20/2011 |
	| 09/19/2011 |
	| 09/18/2011 |
	| 09/17/2011 |
	| 09/16/2011 |
	| 09/15/2011 |
	| 09/14/2011 |
	| 09/13/2011 |
	| 09/12/2011 |
	| 09/11/2011 |
	| 09/10/2011 |
	| 09/09/2011 |
	| 09/08/2011 |
	| 09/07/2011 |
	| 09/06/2011 |
	| 09/05/2011 |
	| 09/04/2011 |
	| 09/03/2011 |
	| 09/02/2011 |
	| 09/01/2011 |
	| 08/31/2011 |
	| 08/30/2011 |
	| 08/29/2011 |
	| 08/28/2011 |
	| 08/27/2011 |
	| 08/26/2011 |
	| 08/25/2011 |
	| 08/24/2011 |
	| 08/23/2011 |
	| 08/22/2011 |
	| 08/21/2011 |
	| 08/20/2011 |
	| 08/19/2011 |
	| 08/18/2011 |
	| 08/17/2011 |
	| 08/16/2011 |
	| 08/15/2011 |
	| 08/14/2011 |
	| 08/13/2011 |
	| 08/12/2011 |
	| 08/11/2011 |
	| 08/10/2011 |
	| 08/09/2011 |
	| 08/08/2011 |
	| 08/07/2011 |
	| 08/06/2011 |
	| 08/05/2011 |
	| 08/04/2011 |
	| 08/03/2011 |
	| 08/02/2011 |
	| 08/01/2011 |
	| 07/31/2011 |
	| 07/30/2011 |
	| 07/29/2011 |
	| 07/28/2011 |
	| 07/27/2011 |
	| 07/26/2011 |
	| 07/25/2011 |
	| 07/24/2011 |
	| 07/23/2011 |
	| 07/22/2011 |
	| 07/21/2011 |
	| 07/20/2011 |
	| 07/19/2011 |
	| 07/18/2011 |
	| 07/17/2011 |
	| 07/16/2011 |
	| 07/15/2011 |
	| 07/14/2011 |
	| 07/13/2011 |
	| 07/12/2011 |
	| 07/11/2011 |
	| 07/10/2011 |
	| 07/09/2011 |
	| 07/08/2011 |
	| 07/07/2011 |
	| 07/06/2011 |
	| 07/05/2011 |
	| 07/04/2011 |
	| 07/03/2011 |
	| 07/02/2011 |
	| 07/01/2011 |
	| 06/30/2011 |
	| 06/29/2011 |
	| 06/28/2011 |
	| 06/27/2011 |
	| 06/26/2011 |
	| 06/25/2011 |
	| 06/24/2011 |
	| 06/23/2011 |
	| 06/22/2011 |
	| 06/21/2011 |
	| 06/20/2011 |
	| 06/19/2011 |
	| 06/18/2011 |
	| 06/17/2011 |
	| 06/16/2011 |
	| 06/15/2011 |
	| 06/14/2011 |
	| 06/13/2011 |
	| 06/12/2011 |
	| 06/11/2011 |
	| 06/10/2011 |
	| 06/09/2011 |
	| 06/08/2011 |
	| 06/07/2011 |
	| 06/06/2011 |
	| 06/05/2011 |
	| 06/04/2011 |
	| 06/03/2011 |
	| 06/02/2011 |
	| 06/01/2011 |
	| 05/31/2011 |
	| 05/30/2011 |
	| 05/29/2011 |
	| 05/28/2011 |
	| 05/27/2011 |
	| 05/26/2011 |
	| 05/25/2011 |
	| 05/24/2011 |
	| 05/23/2011 |
	| 05/22/2011 |
	| 05/21/2011 |
	| 05/20/2011 |
	| 05/19/2011 |
	| 05/18/2011 |
	| 05/17/2011 |
	| 05/16/2011 |
	| 05/15/2011 |
	| 05/14/2011 |
	| 05/13/2011 |
	| 05/12/2011 |
	| 05/11/2011 |
	| 05/10/2011 |
	| 05/09/2011 |
	| 05/08/2011 |
	| 05/07/2011 |
	| 05/06/2011 |
	| 05/05/2011 |
	| 05/04/2011 |
	| 05/03/2011 |
	| 05/02/2011 |
	| 05/01/2011 |
	| 04/30/2011 |
	| 04/29/2011 |
	| 04/28/2011 |
	| 04/27/2011 |
	| 04/26/2011 |
	| 04/25/2011 |
	| 04/24/2011 |
	| 04/23/2011 |
	| 04/22/2011 |
	| 04/21/2011 |
	| 04/20/2011 |
	| 04/19/2011 |
	| 04/18/2011 |
	| 04/17/2011 |
	| 04/16/2011 |
	| 04/15/2011 |
	| 04/14/2011 |
	| 04/13/2011 |
	| 04/12/2011 |
	| 04/11/2011 |
	| 04/10/2011 |
	| 04/09/2011 |
	| 04/08/2011 |
	| 04/07/2011 |
	| 04/06/2011 |
	| 04/05/2011 |
	| 04/04/2011 |
	| 04/03/2011 |
	| 04/02/2011 |
	| 04/01/2011 |
	| 03/31/2011 |
	| 03/30/2011 |
	| 03/29/2011 |
	| 03/28/2011 |
	| 03/27/2011 |
	| 03/26/2011 |
	| 03/25/2011 |
	| 03/24/2011 |
	| 03/23/2011 |
	| 03/22/2011 |
	| 03/21/2011 |
	| 03/20/2011 |
	| 03/19/2011 |
	| 03/18/2011 |
	| 03/17/2011 |
	| 03/16/2011 |
	| 03/15/2011 |
	| 03/14/2011 |
	| 03/13/2011 |
	| 03/12/2011 |
	| 03/11/2011 |
	| 03/10/2011 |
	| 03/09/2011 |
	| 03/08/2011 |
	| 03/07/2011 |
	| 03/06/2011 |
	| 03/05/2011 |
	| 03/04/2011 |
	| 03/03/2011 |
	| 03/02/2011 |
	| 03/01/2011 |
	| 02/28/2011 |
	| 02/27/2011 |
	| 02/26/2011 |
	| 02/25/2011 |
	| 02/24/2011 |
	| 02/23/2011 |
	| 02/22/2011 |
	| 02/21/2011 |
	| 02/20/2011 |
	| 02/19/2011 |
	| 02/18/2011 |
	| 02/17/2011 |
	| 02/16/2011 |
	| 02/15/2011 |
	| 02/14/2011 |
	| 02/13/2011 |
	| 02/12/2011 |
	| 02/11/2011 |
	| 02/10/2011 |
	| 02/09/2011 |
	| 02/08/2011 |
	| 02/07/2011 |
	| 02/06/2011 |
	| 02/05/2011 |
	| 02/04/2011 |
	| 02/03/2011 |
	| 02/02/2011 |
	| 02/01/2011 |
	| 01/31/2011 |
	| 01/30/2011 |
	| 01/29/2011 |
	| 01/28/2011 |
	| 01/27/2011 |
	| 01/26/2011 |
	| 01/25/2011 |
	| 01/24/2011 |
	| 01/23/2011 |
	| 01/22/2011 |
	| 01/21/2011 |
	| 01/20/2011 |
	| 01/19/2011 |
	| 01/18/2011 |
	| 01/17/2011 |
	| 01/16/2011 |
	| 01/15/2011 |
	| 01/14/2011 |
	| 01/13/2011 |
	| 01/12/2011 |
	| 01/11/2011 |
	| 01/10/2011 |
	| 01/09/2011 |
	| 01/08/2011 |
	| 01/07/2011 |
	| 01/06/2011 |
	| 01/05/2011 |
	| 01/04/2011 |
	| 01/03/2011 |
	| 01/02/2011 |
	| 01/01/2011 |


Scenario Outline: UKUSQDF-136 [AT] Cnx2Redis Data Collector - redeploy at build 31 2010
	Given I have the following search criteria for qdf deals
		 | DealSource        | DealType     |
		 | cnxstp-pret-deals | BookLessDeal |
	When I load cnx trade activities for "<reportDate>" for the included logins
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
	Examples: 
	| reportDate |
	| 12/31/2010 |
	| 12/30/2010 |
	| 12/29/2010 |
	| 12/28/2010 |
	| 12/27/2010 |
	| 12/26/2010 |
	| 12/25/2010 |
	| 12/24/2010 |
	| 12/23/2010 |
	| 12/22/2010 |
	| 12/21/2010 |
	| 12/20/2010 |
	| 12/19/2010 |
	| 12/18/2010 |
	| 12/17/2010 |
	| 12/16/2010 |
	| 12/15/2010 |
	| 12/14/2010 |
	| 12/13/2010 |
	| 12/12/2010 |
	| 12/11/2010 |
	| 12/10/2010 |
	| 12/09/2010 |
	| 12/08/2010 |
	| 12/07/2010 |
	| 12/06/2010 |
	| 12/05/2010 |
	| 12/04/2010 |
	| 12/03/2010 |
	| 12/02/2010 |
	| 12/01/2010 |
	| 11/30/2010 |
	| 11/29/2010 |
	| 11/28/2010 |
	| 11/27/2010 |
	| 11/26/2010 |
	| 11/25/2010 |
	| 11/24/2010 |
	| 11/23/2010 |
	| 11/22/2010 |
	| 11/21/2010 |
	| 11/20/2010 |
	| 11/19/2010 |
	| 11/18/2010 |
	| 11/17/2010 |
	| 11/16/2010 |
	| 11/15/2010 |
	| 11/14/2010 |
	| 11/13/2010 |
	| 11/12/2010 |
	| 11/11/2010 |
	| 11/10/2010 |
	| 11/09/2010 |
	| 11/08/2010 |
	| 11/07/2010 |
	| 11/06/2010 |
	| 11/05/2010 |
	| 11/04/2010 |
	| 11/03/2010 |
	| 11/02/2010 |
	| 11/01/2010 |
	| 10/31/2010 |
	| 10/30/2010 |
	| 10/29/2010 |
	| 10/28/2010 |
	| 10/27/2010 |
	| 10/26/2010 |
	| 10/25/2010 |
	| 10/24/2010 |
	| 10/23/2010 |
	| 10/22/2010 |
	| 10/21/2010 |
	| 10/20/2010 |
	| 10/19/2010 |
	| 10/18/2010 |
	| 10/17/2010 |
	| 10/16/2010 |
	| 10/15/2010 |
	| 10/14/2010 |
	| 10/13/2010 |
	| 10/12/2010 |
	| 10/11/2010 |
	| 10/10/2010 |
	| 10/09/2010 |
	| 10/08/2010 |
	| 10/07/2010 |
	| 10/06/2010 |
	| 10/05/2010 |
	| 10/04/2010 |
	| 10/03/2010 |
	| 10/02/2010 |
	| 10/01/2010 |
