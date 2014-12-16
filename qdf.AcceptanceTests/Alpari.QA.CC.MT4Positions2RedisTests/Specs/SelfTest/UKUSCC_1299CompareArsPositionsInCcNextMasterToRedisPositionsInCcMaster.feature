@UKUSCC_1299 @CCDataContextPool
Feature: UKUSCC_1299CompareArsPositionsInCcNextMasterToRedisPositionsInCcMaster
	In order to reconcile Ars Snapshots with Redis Snapshots
	As a CC Tester
	I want to Compare Ars positions in cc_next@master to Redis Positions in cc@master

#could potentially go back to using just the CCConnection rathett than the pool, but this is easier in case we need to change the setup. WQill be slower though
Background: Setup Connection pool
	Given I have the following connections to cc:-
	| Connection1 | Connection2 |
	| CcMaster    | CcMaster    |

Scenario: Do JPN Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	 | Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CHFJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURAUD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURGBP | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURTRY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPAUD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | SGDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDDKK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDHKD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDNOK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSEK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDTRY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

Scenario: Do C1 Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | B.F5    | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CHFJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | CL.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | DE30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EUR50.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURGBP  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | FRA40.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | HKDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NOKSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | NQ100.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | NZDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | SGDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | UK100.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US500.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCNH  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDHKD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDMXN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDNOK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDPLN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDRUB  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | ZC.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
| C1      | C1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | ZS.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |


Scenario: Do C2 Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | AUDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | AUDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | AUDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | AUDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | AUDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | AUDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | AUDNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | AUDNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | AUDSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | AUDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | AUDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | AUDZAR  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | B.F5    | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | CADCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | CADCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | CADJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | CADJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | CADSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | CHFJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | CHFJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | CL.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | DE30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EUA.Z4  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EUR50.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURGBP  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURGBP  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURNOK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURPLN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURZAR  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURZAR  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | FRA40.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPNOK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GC.G5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | HG.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | MXNJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | NQ100.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | NZDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | NZDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | NZDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | NZDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | NZDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | NZDSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | NZDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | NZDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | SB.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | SGDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | SI.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | UK100.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | US30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | US500.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDCNH  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDDKK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDHKD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDMXN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDMXN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDNOK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDNOK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDPLN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDRUB  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDRUB  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDZAR  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | XAGUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | XAGUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | XAUUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | XAUUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | ZARJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | ZC.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | ZS.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | AUDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | AUDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | AUDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | AUDNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | AUDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | CADJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | CL.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | DE30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | EURCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | EURCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | EURCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | EURGBP  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | EURJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | EURNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | FRA40.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | GBPJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | GBPJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | GC.G5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | NZDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | NZDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | SI.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | US30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | US500.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | USDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | USDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | XAGUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | GBPCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| C2      | C2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | XAUUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

Scenario: Do M1 Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CHFJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURAUD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURGBP | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURMXN | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURNOK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURTRY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURZAR | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPAUD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPNOK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPSEK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | HKDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | SGDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCNH | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDDKK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDHKD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDMXN | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDNOK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDRUB | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSEK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDTRY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | ZARJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M1      | M1      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDZAR | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

Scenario: Do M2 Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CHFJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CHFSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURAUD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURDKK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURGBP | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURHKD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURMXN | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURNOK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURPLN | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURTRY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURZAR | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPAUD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPNOK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | HKDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | MXNJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NOKJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NOKSEK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDZAR | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | SGDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCNH | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDDKK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDHKD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDMXN | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDNOK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDPLN | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDRUB | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSEK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDTRY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | XAUUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | ZARJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| M2      | M2      | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

Scenario: Do Pro Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | AUDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | AUDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | AUDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | AUDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | AUDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | AUDNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | AUDNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | AUDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | AUDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | CADCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | CADJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | CADJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | CHFJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | CHFJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | CHFSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | CL.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | DE30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURDKK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURGBP  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURGBP  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURMXN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURNOK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURPLN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | GC.G5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | HG.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | NQ100.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | NZDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | NZDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | NZDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | NZDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | SI.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | US30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | US500.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDHKD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDMXN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDNOK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDPLN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDRUB  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | XAGUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | XAGUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | XAUUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | XAUUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | UK      | USDTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | USDZAR  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | UK      | CADSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | CL.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | EURCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | US      | GBPNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | XAGUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | B    | US      | XAUUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | JP      | AUDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | JP      | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | JP      | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | JP      | USDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| Pro     | Pro     | cc_next   | cc        | CcMaster    | CcMaster    | A    | JP      | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

Scenario: Do SB1 Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | B.F5    | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | CADCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | CADJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | CHFJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | CL.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | DE30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EUA.Z4  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURGBP  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURMXN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | FRA40.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | G.Z4    | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GC.G5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | HG.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | NQ100.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | NZDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | NZDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | SB.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | SGDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | UK100.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US500.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDHKD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDNOK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | ZARJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| SB1     | SB1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | ZS.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

Scenario: Do CBoJ Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | CHFJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURAUD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURGBP | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | NZDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDTRY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| CBoJ    | CBoJ    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

Scenario: Do B2B Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | CADJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CHFJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURAUD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURAUD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURGBP | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURGBP | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURMXN | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURNOK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURPLN | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURSEK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURTRY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPAUD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPAUD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPNOK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPNOK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPSEK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NOKSEK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | NZDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCNH | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDHKD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDMXN | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDNOK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDPLN | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSEK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDTRY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDTRY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | XAGUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | XAUUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURNZD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURTRY | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURNOK | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| B2B     | B2B     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

	Scenario: Do MK1 Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDZAR  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | B.F5    | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CHFJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | CL.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | DE30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EUR50.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURGBP  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURHKD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURMXN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURNOK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURPLN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURZAR  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | FRA40.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | G.Z4    | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPNOK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPZAR  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GC.G5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | HG.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NOKJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | NQ100.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDZAR  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | SB.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | SGDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | SI.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | UK100.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US500.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCNH  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDMXN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDNOK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDRUB  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDZAR  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | XAUUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | ZC.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | ZC.Z4   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | ZS.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | ZARJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDDKK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EUA.Z4  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MK1     | MK1     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

Scenario: Do MENA Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | B.F5    | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CADJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CHFJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | CHFSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | CL.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | DE30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURGBP  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | EURZAR  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | FRA40.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPAUD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPNZD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | HG.H5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | NQ100.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | NZDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | NZDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US500.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCAD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCHF  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDCNH  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDMXN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDPLN  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDRUB  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDSEK  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDTRY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | USDZAR  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | ZS.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | SGDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GC.G5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | HKDJPY  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | GBPSGD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| MENA    | MENA    | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | XAGUSD  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

#Scenario: Do ADS Comparison
#	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
#	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
#	| ADS     | ADS     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GBPUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
#	| ADS     | ADS     | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | GC.G5  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

	#no ASV or MS Cov positions
Scenario: Do ADS STP Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| ADS STP | ADS STP | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| ADS STP | ADS STP | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAUUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| ADS STP | ADS STP | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | AUDUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| ADS STP | ADS STP | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | USDSGD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

Scenario: Do ADS CFD Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol  | StartTime           | EndTime             |
	| ADS CFD | ADS CFD | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | CL.F5   | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| ADS CFD | ADS CFD | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US30.Z  | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| ADS CFD | ADS CFD | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | US500.Z | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

Scenario: Do FXCM FX Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	| Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	| FXCM FX | FXCM FX | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURCHF | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| FXCM FX | FXCM FX | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | EURUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
	| FXCM FX | FXCM FX | cc_next   | cc        | CcMaster    | CcMaster    | B    | Default | XAGUSD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |
