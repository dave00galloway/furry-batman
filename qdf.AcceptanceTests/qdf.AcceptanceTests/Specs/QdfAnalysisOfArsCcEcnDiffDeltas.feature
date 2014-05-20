Feature: QdfAnalysisOfArsCcEcnDiffDeltas
	In order to reconcile Qdf Data
	As a tester
	I want to be able to find the biggest differences in the data streams

@mytag
Scenario: Analyse diff deltas in B Book GBPUSD Mt4Pro 
	Given I want to analyse diff deltas by timeslice in
		| Book | Symbol  | Server | StartDate   | EndDate     | NumberOfDiffs |
		| B    | GBP/USD | Mt4Pro | 03-Feb-2014 | 09-Mar-2014 | 10            |
	When I analyse the diff deltas by timeslice
	Then The diff delta analysis is output to "csv"
	And no diff delta is greater than 10 percent of the mean position for the timeslice
