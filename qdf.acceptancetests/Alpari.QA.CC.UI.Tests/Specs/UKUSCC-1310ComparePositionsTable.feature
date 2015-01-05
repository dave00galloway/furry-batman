@UKUSCC_1310
Feature: UKUSCC-1310ComparePositionsTable
In order to check the CC UI is displaying the correct data
as a tester
I want to compare the positions table in different CC environments

#note skipping actual login for moment
Scenario: Open CC UI
	Given I have opened the cc url "https://webportal.corp.alpari.com/CC_UAT"
	Then the position table is displayed

	#note manually selecting the servers, book and types for now
Scenario: Get A Book Positions
	Given I have opened the cc url "https://webportal.corp.alpari.com/CC_UAT"
	When I get the positions
	Then The count of servers is 33
	And the count of symbols is at least 60

	#note manually selecting the servers, book and types for now
Scenario: Compare A Book Positions
	Given I have opened the cc url "https://webportal.corp.alpari.com/CC_UAT"
	When I compare the positions


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
	| cc_prod   | cc_new | 5MIN       | 1MIN         |
	When I monitor the current positions
	Then the current positions should match exactly:-
	| ExportType     |  Overwrite |
	| DataTableToCsv |  true      |
