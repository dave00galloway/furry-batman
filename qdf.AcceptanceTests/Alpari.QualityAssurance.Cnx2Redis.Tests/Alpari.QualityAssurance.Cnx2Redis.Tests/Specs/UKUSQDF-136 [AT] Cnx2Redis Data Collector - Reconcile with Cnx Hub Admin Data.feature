@UKUSQDF_136 @cnxHubTradeActivityImporter:Csv
Feature: UKUSQDF-136 [AT] Cnx2Redis Data Collector - Reconcile with Cnx Hub Admin Data
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

Scenario: Trade Activities For All accounts From07-09-2014 To07-09-2014 Pre Midinight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                              | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From07-09-2014 To07-09-2014.csv | 08/07/2014  19:08:13 | 08/07/2014  23:59:59 |
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

Scenario: Trade Activities For All accounts From07-09-2014 To07-09-2014 Post Midinight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                              | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From07-09-2014 To07-09-2014.csv | 09/07/2014  00:00:00 | 09/07/2014  20:53:20 |
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


Scenario: Trade Activities For All accounts From 07-10-2014  To 07-10-2014 Pre Midinight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                              | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From07-09-2014 To07-09-2014.csv | 09/07/2014  19:00:00 | 09/07/2014  23:59:24 |
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

Scenario: Trade Activities For All accounts From 07-10-2014  To 07-10-2014 Post Midinight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From 07-10-2014  To 07-10-2014.csv | 10/07/2014  00:00:00 | 10/07/2014  20:55:34 |
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

#Trade Activities For All accounts From 07-14-2014  To 07-14-2014
Scenario: Trade Activities For All accounts From 07-14-2014  To 07-14-2014 Pre Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From 07-14-2014  To 07-14-2014.csv | 13/07/2014  21:06:10 | 13/07/2014  23:59:59 |
	#When I load cnx trade activities from "C:\data\Trade Activities For All accounts From 07-14-2014  To 07-14-2014.csv" for the included logins
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

Scenario: Trade Activities For All accounts From 07-14-2014  To 07-14-2014 Post Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From 07-14-2014  To 07-14-2014.csv | 14/07/2014  00:00:00 | 14/07/2014  20:57:02 |
	#When I load cnx trade activities from "C:\data\Trade Activities For All accounts From 07-14-2014  To 07-14-2014.csv" for the included logins
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

#Trade Activities For All accounts From 07-15-2014  To 07-15-2014
Scenario: Trade Activities For All accounts From 07-15-2014  To 07-15-2014 Pre Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From 07-15-2014  To 07-15-2014.csv | 14/07/2014  19:46:42 | 14/07/2014  23:59:59 |
	#When I load cnx trade activities from "C:\data\Trade Activities For All accounts From 07-14-2014  To 07-14-2014.csv" for the included logins
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

Scenario: Trade Activities For All accounts From 07-15-2014  To 07-15-2014 Post Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From 07-15-2014  To 07-15-2014.csv | 15/07/2014  00:00:00 | 15/07/2014  20:57:50 |
	#When I load cnx trade activities from "C:\data\Trade Activities For All accounts From 07-14-2014  To 07-14-2014.csv" for the included logins
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

#Damodar did test for 16th, should merge in here somewhere

#Trade Activities For All accounts From 07-17-2014  To 07-17-2014
Scenario: Trade Activities For All accounts From 07-17-2014  To 07-17-2014 Pre Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From 07-17-2014  To 07-17-2014.csv | 16/07/2014  21:13:04 | 16/07/2014  23:59:59 |
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

Scenario: Trade Activities For All accounts From 07-17-2014  To 07-17-2014 Post Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From 07-17-2014  To 07-17-2014.csv | 17/07/2014  00:00:00 | 17/07/2014  20:56:54 |
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

#Trade Activities For All accounts From 07-18-2014  To 07-20-2014
Scenario: Trade Activities For All accounts From 07-18-2014  To 07-20-2014 Pre Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From 07-18-2014  To 07-20-2014.csv | 17/07/2014  19:31:34 | 17/07/2014  23:59:59 |
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

Scenario: Trade Activities For All accounts From 07-18-2014  To 07-20-2014 Post Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                                 | ConvertedStartTime   | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From 07-18-2014  To 07-20-2014.csv | 18/07/2014  00:00:00 | 18/07/2014  20:49:38 |
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

#Trade Activities For All accounts From 07-21-2014  To 07-21-2014
Scenario: Trade Activities For All accounts From 07-21-2014  To 07-21-2014 Pre Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                                 | ConvertedStartTime  | ConvertedEndTime     |
		| C:\data\Trade Activities For All accounts From 07-21-2014  To 07-21-2014.csv | 20/07/2014 21:04:08 | 20/07/2014  23:59:59 |
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

Scenario: Trade Activities For All accounts From 07-21-2014  To 07-21-2014 Post Midnight
	Given I have the following search criteria for qdf deals
		 | DealSource | DealType     |
		 | cnx-deals  | BookLessDeal |
	When I load cnx trade activities for the included logins from
		| FileNamePath                                                                 | ConvertedStartTime   | ConvertedEndTime    |
		| C:\data\Trade Activities For All accounts From 07-21-2014  To 07-21-2014.csv | 20/07/2014  00:00:00 | 21/07/2014 20:57:00 |
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