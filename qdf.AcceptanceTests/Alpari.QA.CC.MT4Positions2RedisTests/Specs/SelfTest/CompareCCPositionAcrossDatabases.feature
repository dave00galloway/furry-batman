@CCDataContext @UKUSCC_1153
Feature: CompareCCPositionAcrossDatabases
	In order to compare position snapshots in different databases
	As a CC Tester
	I want to get positions from differnt databases for the same server, symbol, etc

Scenario: Get data for qa and uat for eurusd mt5
	Given I have a connection to CCDataContext
	When I get position data for these snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| MT5    | default | A    | EURUSD | 2014/10/01 12:10:00 | 2014/10/02 20:10:00 | 

Scenario: Get data for qa and uat for eurusd mt5 A and B Book
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| MT5    | default | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/01 15:10:00 | 
	| MT5    | default | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/01 15:10:00 | 

Scenario: Get data for qa and uat for various symbols mt5 A and B Book
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| MT5    | default | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | A    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | A    | USDYEN | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | A    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | A    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | B    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | B    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | B    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | B    | USDYEN | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | B    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for JPY crosses mt5 A and B Book
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| MT5    | default | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | B    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MT5    | default | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for ADS
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server  | section | book | symbol | startTime           | endTime             |
	| ADS CFD | default | B    | GC.Z4  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| ADS STP | default | B    | EURGBP | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| ADS STP | default | B    | EURTRY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| ADS STP | default | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| ADS STP | default | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| ADS STP | default | B    | USDTRY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| ADS STP | default | B    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| ADS STP | default | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for B2B
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| B2B    | default | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | A    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | A    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | A    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | B    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | B    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | B    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | B    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| B2B    | default | B    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for C1
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| C1     | default | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C1     | default | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C1     | default | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C1     | default | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C1     | default | A    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C1     | default | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C1     | default | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C1     | default | B    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C1     | default | B    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C1     | default | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C1     | default | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C1     | default | B    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for C2
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| C2     | UK      | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | A    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | A    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | A    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | B    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | B    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | B    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | B    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | B    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | B    | EUA.Z4 | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | UK      | B    | US30.Z | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | A    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | B    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | B    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | B    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | B    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | B    | SI.Z4  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| C2     | US      | B    | US30   | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for CBOJ
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| CBoJ   | default | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CBoJ   | default | B    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CBoJ   | default | B    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CBoJ   | default | B    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CBoJ   | default | B    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CBoJ   | default | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CBoJ   | default | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CBoJ   | default | B    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |


Scenario: Get data for qa and uat for CNX
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| CNX    | UK      | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | UK      | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | UK      | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | UK      | A    | EUA.Z4 | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | UK      | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | UK      | B    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | UK      | B    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | UK      | B    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | UK      | B    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | UK      | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | UK      | B    | EUA.Z4 | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | A    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | A    | EUA.Z4 | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | B    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | B    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | B    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | B    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | B    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | US      | B    | EUA.Z4 | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | JP      | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | JP      | A    | HKDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | JP      | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | JP      | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | JP      | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| CNX    | JP      | A    | EUA.Z4 | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for JPN
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| JPN    | default | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| JPN    | default | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| JPN    | default | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| JPN    | default | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| JPN    | default | A    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| JPN    | default | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| JPN    | default | B    | EURJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| JPN    | default | B    | AUDUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |


Scenario: Get data for qa and uat for M1
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| M1     | default | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M1     | default | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M1     | default | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M1     | default | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M1     | default | A    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M1     | default | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M1     | default | A    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M1     | default | A    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M1     | default | A    | CADSGD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M1     | default | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M1     | default | B    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for M2
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| M2     | default | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | A    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | A    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | A    | ZARJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | A    | USDMXN | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | B    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | B    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | B    | EURJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| M2     | default | B    | EURTRY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for MENA
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol  | startTime           | endTime             |
	| MENA   | default | A    | EURUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | A    | GBPUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | A    | GBPJPY  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | A    | USDCHF  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | A    | EURCHF  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | A    | USDJPY  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | A    | XAUUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | B    | EURUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | B    | GBPUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | B    | USDJPY  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | B    | XAUUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | B    | XAGUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | B    | NQ100.Z | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MENA   | default | B    | US30.Z  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for MK1
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol  | startTime           | endTime             |
	| MK1    | default | A    | EURUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | A    | GBPUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | A    | GBPJPY  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | A    | USDCHF  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | A    | EURCHF  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | A    | USDJPY  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | A    | XAUUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | B    | EURUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | B    | GBPUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | B    | GBPJPY  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | B    | USDCHF  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | B    | EURCHF  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | B    | USDJPY  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | B    | XAUUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | B    | XAGUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | B    | UK100.Z | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MK1    | default | B    | US30.Z  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for MSCov
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| MS Cov | default | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MS Cov | default | A    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MS Cov | default | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| MS Cov | default | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for Pro
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| Pro    | JP      | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | JP      | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | JP      | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | JP      | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | JP      | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | JP      | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | JP      | B    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | A    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | A    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | A    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | B    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | B    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | B    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | B    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | B    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | B    | SI.Z4  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | UK      | B    | US30.Z | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | US      | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | US      | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | US      | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | US      | A    | USDCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | US      | A    | EURCHF | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | US      | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | US      | B    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | US      | B    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | US      | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | US      | B    | XAGUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| Pro    | US      | B    | CL.X4  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |

Scenario: Get data for qa and uat for QAH and QMH
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol | startTime           | endTime             |
	| QAH    | default | A    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | A    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | A    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | A    | EURGBP | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | A    | CHFJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | A    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | A    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | B    | EURUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | B    | GBPUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | B    | GBPJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | B    | EURGBP | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | B    | CHFJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | B    | USDJPY | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| QAH    | default | B    | XAUUSD | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |


Scenario: Get data for qa and uat for SB1
	Given I have a connection to CCDataContext
	When I get position data for these groups of snapshot parameters:-
	| server | section | book | symbol  | startTime           | endTime             |
	| SB1    | default | B    | EURUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| SB1    | default | B    | GBPUSD  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| SB1    | default | B    | GBPJPY  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| SB1    | default | B    | USDCHF  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| SB1    | default | B    | EURCHF  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| SB1    | default | B    | USDJPY  | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| SB1    | default | B    | UK100.Z | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| SB1    | default | B    | B.X4    | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| SB1    | default | B    | FRA40.V | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |
	| SB1    | default | B    | HG.V4   | 2014/09/28 20:14:00 | 2014/10/02 15:00:00 |