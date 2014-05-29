@SnapOnCc
Feature: QdfAnalysisOfArsCcEcnDiffDeltasWithLoadedFiles
	In order to test the analysis of the diff delta summaries
	As a tester
	I want to load pre run result files and analyse them

@mytag
Scenario: Load and analyse 6 summary files and check combination deltas
	Given I have loaded all "Summary.csv" files
	When I summarise the analysis and output the result to "csv"
	Then the combination with the highest diffdelta sum is "AGBPUSDMt4Micro2DiffDeltaSummary.csv" with 4662000.000000004

@mytag
Scenario: Load and analyse 6 summary files and check book deltas
	Given I have loaded all "Summary.csv" files
	When I summarise the analysis and output the result to "csv"
	Then the book with the highest diffdelta sum is "A" with 7736000.000000004

@mytag
Scenario: Load and analyse 6 summary files and check server deltas
	Given I have loaded all "Summary.csv" files
	When I summarise the analysis and output the result to "csv"
	Then the server with the highest diffdelta sum is "Mt4Micro2" with 4696000.000000004

@mytag
Scenario: Load and analyse 6 summary files and check symbol deltas
	Given I have loaded all "Summary.csv" files
	And I have loaded all "Deltas.csv" files as lists of deltas
	When I summarise the analysis and output the result to "csv"
	Then the symbol with the highest diffdelta sum is "GBPUSD" with 7983000.000000004

@mytag
Scenario: Load and analyse 6 Delta files and check for unknown data
	Given I have loaded all "Deltas.csv" files as lists of deltas
	Then these combinations contain unknown data
	| Combinations                   |
	| BGBPUSDMt4Micro2DiffDeltas.csv |
	| BEURNZDMt4ProDiffDeltas.csv    |



