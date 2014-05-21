Feature: GenerateDistinctDiffDeltas
	In order to get all relevant data for diff delta comparisons
	As a tester
	I want an exhaustive list of distinct book, symbol and server combinations for a specified date range

@mytag
Scenario: Generate Distinct DiffDeltas
	Given I want to analyse these diff deltas by timeslice in
		| StartDate   | EndDate     | NumberOfDiffs |
		| 03-Feb-2014 | 09-Mar-2014 | 20            |
	Then the number of parameter sets is 845

