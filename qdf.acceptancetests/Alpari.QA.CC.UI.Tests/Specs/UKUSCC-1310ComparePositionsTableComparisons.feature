@UKUSCC_1310
Feature: UKUSCC-1310ComparePositionsTableComparisons
In order to check the CC UI is displaying the correct data
as a tester
I want to compare the positions table in different CC environments

#note manually selecting the servers, book and types for now
@ICcPositionTableComparison @Broken
#error: Interface cannot be resolved: Alpari.QA.CC.UI.Tests.BusinessProcesses.ICcPositionTableComparison (resolution path: Alpari.QA.CC.UI.Tests.Steps.CcPositionComparisonSteps)
Scenario: Compare new and old servers current position
	Given I have the following cc comparison parameters:-
	| CcCurrent | CcNew  | CcCurrentVersion | CcNewVersion |
	| cc_prod   | cc_new | 4.5              | 4.6          |
	When I compare the current positions
	Then the current positions should match exactly:-
	| ExportType     |  Overwrite |
	| DataTableToCsv |  true      |

#note manually selecting the servers, book and types for now
@ICcPositionTableComparison @Broken
#error: Interface cannot be resolved: Alpari.QA.CC.UI.Tests.BusinessProcesses.ICcPositionTableComparison (resolution path: Alpari.QA.CC.UI.Tests.Steps.CcPositionComparisonSteps)
Scenario: Monitor new and old servers position
	Given I have the following cc comparison parameters:-
	| CcCurrent | CcNew  | MonitorFor | MonitorEvery | CcCurrentVersion | CcNewVersion |
	| cc_prod   | cc_new | 1MIN       | 10SEC        | 4.5              | 4.6          |
	When I monitor the current positions

#note manually selecting the servers, book and types for now
@ICcPositionTableComparison @Broken
#error: Interface cannot be resolved: Alpari.QA.CC.UI.Tests.BusinessProcesses.ICcPositionTableComparison (resolution path: Alpari.QA.CC.UI.Tests.Steps.CcPositionComparisonSteps)
Scenario: Monitor new and old servers position longer test
	Given I have the following cc comparison parameters:-
	| CcCurrent | CcNew  | MonitorFor | MonitorEvery | CcCurrentVersion | CcNewVersion |
	| cc_prod   | cc_new | 1HR        | 1MIN         | 4.5              | 4.6          |
	When I monitor the current positions

@ICcPositionTableComparisons
Scenario: Configure A and B Book 
	Given I have the following cc comparison parameter sets:-
	| CcCurrent | CcNew  | CcCurrentVersion | CcNewVersion | Book | Select | Minimum Servers | Minimum Symbols |
	| cc_prod   | cc_new | 4.5              | 4.6          | A    | All    | 10              | 10              |
	| cc_prod   | cc_new | 4.5              | 4.6          | B    | All    | 10              | 10              |
	When I configure the position pages
	Then the position pages have this configuration:-
	| CcCurrent | CcNew  | Book | Minimum Servers | Minimum Symbols |
	| cc_prod   | cc_new | A    | 10              | 10              |
	| cc_prod   | cc_new | B    | 10              | 10              |

@ICcPositionTableComparisons
Scenario: Monitor new and old servers position A And B
	Given I have the following cc comparison parameter sets:-
	| CcCurrent | CcNew  | MonitorFor | MonitorEvery | CcCurrentVersion | CcNewVersion | Book | Select |
	| cc_prod   | cc_new | 1MIN       | 10SEC        | 4.5              | 4.6          | A    | All    |  
	| cc_prod   | cc_new | 1MIN       | 10SEC        | 4.5              | 4.6          | B    | All    |                 
	When I monitor the current positions in parallel

@ICcPositionTableComparisons
Scenario: Monitor new and old servers position A And B Longer Test
	Given I have the following cc comparison parameter sets:-
	| CcCurrent | CcNew  | MonitorFor | MonitorEvery | CcCurrentVersion | CcNewVersion | Book |
	| cc_prod   | cc_new | 1HR        | 10SEC        | 4.5              | 4.6          | A    |
	| cc_prod   | cc_new | 1HR        | 10SEC        | 4.5              | 4.6          | B    |
	When I monitor the current positions in parallel