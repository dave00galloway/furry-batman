@UKUSCC_1310 @CcPositionTableComparison
Feature: UKUSCC-1310ComparePositionsTableComparisons
In order to check the CC UI is displaying the correct data
as a tester
I want to compare the positions table in different CC environments


#note manually selecting the servers, book and types for now
Scenario: Compare new and old servers current position
	Given I have the following cc comparison parameters:-
	| CcCurrent | CcNew  |
	| cc_prod   | cc_new |
	When I compare the current positions
	Then the current positions should match exactly:-
	| ExportType     |  Overwrite |
	| DataTableToCsv |  true      |

#note manually selecting the servers, book and types for now
Scenario: Monitor new and old servers position
	Given I have the following cc comparison parameters:-
	| CcCurrent | CcNew  | MonitorFor | MonitorEvery |
	| cc_prod   | cc_new | 1MIN       | 10SEC        |
	When I monitor the current positions
