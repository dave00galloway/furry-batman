@UKUSQDF_151 @cnxHubTradeActivityImporter:Csv
Feature: UKUSQDF-151 [AT] load cnx-fix-deals
	In order to use cnxstp-pret-deals-all which have been loaded from file
	As a QDF Analyst
	I want to know the data matches with cnx-hub data

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

Scenario Outline: check qdf cnx-deals and cnx hub deals and do comparison 2013
	Given I have the following search criteria for qdf deals
		 | DealSource        | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "<report>" for the included logins
	When I load cnx trade activities with the side reversed from "<report>" for the included logins
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
	| report                       |
	| C:\data\AlpariUK_2013_08.csv |

Scenario Outline: check qdf cnx-deals and cnx hub deals and do comparison 2012
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	When I load cnx trade activities with the side reversed from "<report>" for the included logins
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
	| report                       |
	| C:\data\AlpariUK_2012_01.csv |
	| C:\data\AlpariUK_2012_02.csv |
	| C:\data\AlpariUK_2012_03.csv |
	| C:\data\AlpariUK_2012_04.csv |
	| C:\data\AlpariUK_2012_05.csv |
	| C:\data\AlpariUK_2012_06.csv |
	| C:\data\AlpariUK_2012_07.csv |
	| C:\data\AlpariUK_2012_08.csv |
	| C:\data\AlpariUK_2012_09.csv |
	| C:\data\AlpariUK_2012_10.csv |
	| C:\data\AlpariUK_2012_11.csv |
	| C:\data\AlpariUK_2012_12.csv |

Scenario Outline: check qdf cnx-deals and cnx hub deals and do comparison 2011
	Given I have the following search criteria for qdf deals
		 | DealSource        | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "<report>" for the included logins
	When I load cnx trade activities with the side reversed from "<report>" for the included logins
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
	| report                       |
	| E:\data\AlpariUK_2011_01.csv |
	| E:\data\AlpariUK_2011_02.csv |
	| E:\data\AlpariUK_2011_03.csv |
	| E:\data\AlpariUK_2011_04.csv |
	| E:\data\AlpariUK_2011_05.csv |
	| E:\data\AlpariUK_2011_06.csv |
	| E:\data\AlpariUK_2011_07.csv |
	| E:\data\AlpariUK_2011_08.csv |
	| C:\data\AlpariUK_2011_09.csv |
	| E:\data\AlpariUK_2011_10.csv |
	| E:\data\AlpariUK_2011_11.csv |
	| E:\data\AlpariUK_2011_12.csv |


Scenario: check qdf cnx-deals and cnx hub deals and do comparison Jan 2014 Pre Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	When I load cnx trade activities with the side reversed for the included logins from
		| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Alpari UK_TradeActivity_20140131.csv | 01/01/2014  22:02:31 | 30/01/2014  23:59:59 |
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

Scenario: check qdf cnx-deals and cnx hub deals and do comparison Jan 2014 Post Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	When I load cnx trade activities with the side reversed for the included logins from
		| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Alpari UK_TradeActivity_20140131.csv | 31/01/2014  00:00:00 | 31/01/2014  21:53:02 |
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
#feb
Scenario: check qdf cnx-deals and cnx hub deals and do comparison Feb 2014 Pre Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	When I load cnx trade activities with the side reversed for the included logins from
		| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Alpari UK_TradeActivity_20140228.csv | 02/02/2014  22:03:35 | 27/02/2014  23:59:59 |
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

Scenario: check qdf cnx-deals and cnx hub deals and do comparison Feb 2014 Post Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	When I load cnx trade activities with the side reversed for the included logins from
		| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Alpari UK_TradeActivity_20140228.csv | 28/02/2014  00:00:00 | 28/02/2014  21:57:51 |
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

#Mar
Scenario: check qdf cnx-deals and cnx hub deals and do comparison Mar 2014 Pre Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	When I load cnx trade activities with the side reversed for the included logins from
		| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Alpari UK_TradeActivity_20140331.csv | 02/03/2014  22:03:03 | 31/03/2014  23:59:59 |
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

Scenario: check qdf cnx-deals and cnx hub deals and do comparison Mar 2014 Post Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	When I load cnx trade activities with the side reversed for the included logins from
		| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Alpari UK_TradeActivity_20140331.csv | 31/03/2014  00:00:00 | 31/03/2014  20:57:33 |
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

#Apr
Scenario: check qdf cnx-deals and cnx hub deals and do comparison Apr 2014 Pre Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	When I load cnx trade activities with the side reversed for the included logins from
		| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Alpari UK_TradeActivity_20140430.csv | 01/04/2014  21:05:03 | 30/04/2014  23:59:59 |
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

Scenario: check qdf cnx-deals and cnx hub deals and do comparison Apr 2014 Post Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	When I load cnx trade activities with the side reversed for the included logins from
		| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Alpari UK_TradeActivity_20140430.csv | 30/04/2014  00:00:00 | 30/04/2014  20:56:26 |
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

#May
Scenario: check qdf cnx-deals and cnx hub deals and do comparison May 2014 Pre Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	When I load cnx trade activities with the side reversed for the included logins from
		| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Alpari UK_TradeActivity_20140531.csv | 30/04/2014  21:06:33 | 29/05/2014  23:59:59 |
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

Scenario: check qdf cnx-deals and cnx hub deals and do comparison May 2014 Post Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	When I load cnx trade activities with the side reversed for the included logins from
		| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Alpari UK_TradeActivity_20140531.csv | 30/05/2014  00:00:00 | 30/05/2014  20:57:22 |
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

#Jun
Scenario: check qdf cnx-deals and cnx hub deals and do comparison Jun 2014 Pre Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	When I load cnx trade activities with the side reversed for the included logins from
		| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Alpari UK_TradeActivity_20140630.csv | 01/06/2014  21:04:12 | 30/06/2014  23:59:59 |
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

Scenario: check qdf cnx-deals and cnx hub deals and do comparison Jun 2014 Post Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	#When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20140131.csv" and reverse the deal side
	When I load cnx trade activities with the side reversed for the included logins from
		| FileNamePath                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Alpari UK_TradeActivity_20140630.csv | 30/06/2014  00:00:00 | 30/06/2014  20:52:42 |
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

#2011
Scenario: check qdf cnx-deals and cnx hub deals and do comparison Nov 2011
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20111130.csv" and reverse the deal side
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

Scenario: check qdf cnx-deals and cnx hub deals and do comparison Dec 2011
	Given I have the following search criteria for qdf deals
		 | DealSource            | DealType |
		 | cnxstp-pret-deals | deal     |
		 #| cnxstp-pret-deals-all | deal     |
	When I load cnx trade activities from "C:\data\Alpari UK_TradeActivity_20111231.csv" and reverse the deal side
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