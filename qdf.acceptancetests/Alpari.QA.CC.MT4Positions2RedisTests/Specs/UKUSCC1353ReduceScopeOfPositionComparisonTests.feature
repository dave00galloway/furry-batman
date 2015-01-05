@UKUSCC_1353 @CCDataContextPool
Feature: UKUSCC1353ReduceScopeOfPositionComparisonTests.feature
	In order to reconcile Ars Snapshots with Redis Snapshots
	As a CC Tester
	I want to Compare a small subset of Ars positions in cc_next@master to Redis Positions in cc@master

#could potentially go back to using just the CCConnection rathett than the pool, but this is easier in case we need to change the setup. WQill be slower though
Background: Setup Connection pool
	Given I have the following connections to cc:-
	| Connection1 | Connection2 |
	| CcMaster    | CcMaster    |


Scenario: Do JPN Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

Scenario: Do C1 Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | B.G5    | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US500.H | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

Scenario: Do C2 Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | XAGUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | US500.H | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | B.G5    | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | B.G5    | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | XAGUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | US500.H | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | XAUUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | XAUUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | XAGUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | XAUUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

Scenario: Do M1 Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | XAUUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

Scenario: Do M2 Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | XAUUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

Scenario: Do Pro Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | XAUUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | JP      | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | JP      | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | US500.H | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | XAGUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | JP      | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | XAUUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | JP      | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | XAGUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | B.G5    | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

Scenario: Do SB1 Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US500.H | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | B.G5    | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

Scenario: Do CBoJ Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCHF | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

Scenario: Do B2B Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | XAGUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | XAUUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCHF | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

	Scenario: Do MK1 Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | XAGUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US500.H | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | XAUUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | B.G5    | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

Scenario: Do MENA Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US500.H | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | XAUUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | B.G5    | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD  | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

#Scenario: Do ADS Comparison
#	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
#	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
#	| ADS     | ADS     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
#	| ADS     | ADS     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GC.G5  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

	#no ASV
Scenario: Do MS Cov Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| MS Cov  | MS Cov  | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MS Cov  | MS Cov  | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MS Cov  | MS Cov  | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| MS Cov  | MS Cov  | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

Scenario: Do ADS STP Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| ADS STP | ADS STP | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| ADS STP | ADS STP | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| ADS STP | ADS STP | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| ADS STP | ADS STP | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

Scenario: Do ADS CFD Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| ADS CFD | ADS CFD | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | CL.G5   | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| ADS CFD | ADS CFD | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US500.H | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |

Scenario: Do FXCM FX Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| FXCM FX | FXCM FX | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURCHF | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| FXCM FX | FXCM FX | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
	| FXCM FX | FXCM FX | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD | 2014/12/19 10:00:00 | 2015/01/05 11:00:00 |
