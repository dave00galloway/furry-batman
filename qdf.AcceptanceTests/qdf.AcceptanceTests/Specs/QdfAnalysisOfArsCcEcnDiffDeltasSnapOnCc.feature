@SnapOnCc @LongRunning 
Feature: QdfAnalysisOfArsCcEcnDiffDeltasSnapOnCc
	In order to reconcile Qdf Data
	As a tester
	I want to be able to find the biggest differences in the data streams


Scenario: Analyse diff deltas in B Book GBPUSD Mt4Pro 
	Given I want to analyse diff deltas by timeslice in
		| Book | Symbol  | Server | StartDate   | EndDate     | NumberOfDiffs |
		| B    | GBP/USD | Mt4Pro | 05-May-2014 | 06-May-2014 | 20            |
	When I analyse the diff deltas by timeslice
	Then The diff delta analysis is output to "csv"
	And no diff delta is greater than 10 percent of the mean position for the timeslice

Scenario: Analyse diff deltas in B Book EURNZD Mt4Pro 
	Given I want to analyse diff deltas by timeslice in
		| Book | Symbol  | Server | StartDate   | EndDate     | NumberOfDiffs |
		| B    | EUR/NZD | Mt4Pro | 05-May-2014 | 06-May-2014 | 20            |
	When I analyse the diff deltas by timeslice
	Then The diff delta analysis is output to "csv"
	And no diff delta is greater than 10 percent of the mean position for the timeslice

Scenario: Analyse diff deltas in A Book GBPUSD Mt4Pro 
	Given I want to analyse diff deltas by timeslice in
		| Book | Symbol  | Server | StartDate   | EndDate     | NumberOfDiffs |
		| A    | GBP/USD | Mt4Pro | 05-May-2014 | 06-May-2014 | 20            |
	When I analyse the diff deltas by timeslice
	Then The diff delta analysis is output to "csv"
	And no diff delta is greater than 10 percent of the mean position for the timeslice

Scenario: Analyse diff deltas in A Book GBPUSD Mt4Micro2 
	Given I want to analyse diff deltas by timeslice in
		| Book | Symbol  | Server    | StartDate   | EndDate     | NumberOfDiffs |
		| A    | GBP/USD | Mt4Micro2 | 05-May-2014 | 06-May-2014 | 20            |
	When I analyse the diff deltas by timeslice
	Then The diff delta analysis is output to "csv"
	And no diff delta is greater than 10 percent of the mean position for the timeslice

Scenario: Analyse diff deltas in A Book EURNZD Mt4Micro2 
	Given I want to analyse diff deltas by timeslice in
		| Book | Symbol  | Server    | StartDate   | EndDate     | NumberOfDiffs |
		| A    | EUR/NZD | Mt4Micro2 | 05-May-2014 | 06-May-2014 | 20            |
	When I analyse the diff deltas by timeslice
	Then The diff delta analysis is output to "csv"
	And no diff delta is greater than 10 percent of the mean position for the timeslice

Scenario: Analyse diff deltas in B Book GBPUSD Mt4Micro2 
	Given I want to analyse diff deltas by timeslice in
		| Book | Symbol  | Server    | StartDate   | EndDate     | NumberOfDiffs |
		| B    | GBP/USD | Mt4Micro2 | 05-May-2014 | 06-May-2014 | 20            |
	When I analyse the diff deltas by timeslice
	Then The diff delta analysis is output to "csv"
	And no diff delta is greater than 10 percent of the mean position for the timeslice

Scenario: Analyse diff deltas in A Book EURUSD Mt4Classic2 
	Given I want to analyse diff deltas by timeslice in
		| Book | Symbol  | Server      | StartDate   | EndDate     | NumberOfDiffs |
		| A    | EUR/USD | Mt4Classic2 | 05-May-2014 | 06-May-2014 | 20            |
	When I analyse the diff deltas by timeslice
	Then The diff delta analysis is output to "csv"
	And no diff delta is greater than 10 percent of the mean position for the timeslice

Scenario: Analyse diff deltas in B Book EURUSD Mt4Classic2 
	Given I want to analyse diff deltas by timeslice in
		| Book | Symbol  | Server      | StartDate   | EndDate     | NumberOfDiffs |
		| B    | EUR/USD | Mt4Classic2 | 05-May-2014 | 06-May-2014 | 20            |
	When I analyse the diff deltas by timeslice
	Then The diff delta analysis is output to "csv"
	And no diff delta is greater than 10 percent of the mean position for the timeslice

Scenario: Analyse All Distinct DiffDeltas
	Given I want to analyse these diff deltas by timeslice in
		| StartDate   | EndDate     | NumberOfDiffs |
		| 03-Feb-2014 | 09-Mar-2014 | 20            |
	When I analyse the diff deltas by timeslice and output to "csv"
	Then I can summarise the analysis and output the result to "csv"
