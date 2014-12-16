@UKUSCC_1331
Feature: UKUSCC_1331_ProvideExactSnapshotTimes
	In order to aid defect investigation
	As a CC Developer
	I want to get exact cc snapshot times

	#Requires actual data in cc_next and cc
Background: Setup Connection pool
	Given I have the following connections to cc:-
	| Connection1 | Connection2 |
	| CcMaster    | CcMaster    |

Scenario: Do JPN Comparison
	When I get cc redis and cc ars position data across db connections and databases for these sets of snapshot parameters:-
	 | Server1 | Server2 | Database1 | Database2 | Connection1 | Connection2 | Book | Section | Symbol | StartTime           | EndTime             |
	 | JPN     | JPN     | cc_next   | cc        | CcMaster    | CcMaster    | A    | Default | AUDCAD | 2014/12/12 10:30:00 | 2014/12/15 09:00:00 |

	 Then the snapshot comparison list contains fields for actual snapshot times