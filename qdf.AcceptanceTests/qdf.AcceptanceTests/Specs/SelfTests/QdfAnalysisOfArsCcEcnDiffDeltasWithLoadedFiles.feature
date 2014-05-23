@SnapOnCc
Feature: QdfAnalysisOfArsCcEcnDiffDeltasWithLoadedFiles
	In order to test the analysis of the diff delta summaries
	As a tester
	I want to load pre run result files and analyse them

@mytag
Scenario: Load and analyse 6 summary files
	Given I have loaded all "Summary.csv" files
	Then I can summarise the analysis and output the result to "csv"
	And the combination with the highest diffdelta sum is "AGBPUSDMt4Micro2DiffDeltaSummary.csv" with 4662000.000000004

