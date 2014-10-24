@UKUSCC_1206
Feature: UKUSCC_1206LogFileSplitter
	In order to analyse a log file for specific test runs
	As a tester
	I want to split log files by timestamp

Scenario: Split a log file
	
	Given I have the following log file splitter parameters:-
	| fileToParse                                                    | startAt                 | endAt                   | outputfile  |
	| TestData\LogFileTests\Build56_Service_Log_extract_extended.log | 16/10/2014 17:03:22.951 | 16/10/2014 17:03:25.889 | extract.log |

	Given I have the following split log file parser parameters:-
	| fileToParse | parseSyntax                     | ColumnJoins | OuputDelimiter | OuterSyntaxDelimiter | InnerSyntaxDelimiter | outputfile |
	| extract.log | [,1,,0, ,^],1,,0, ,^ ,0,U_,2, , |             | ,              | ^                    | ,                    | output.csv |

	When I split the log file

	When I parse the log file to memory
	And I analyze the log file by activity frequency
	And I output the log file frequency analysis
	And I generate statistics about the frequency analysis
	And I output the frequency analysis statistics
	Then the mt4P2RLogEntryAnalysisList has the following entries:-
	| TimeStamp           | U_INIT | U_TRANS_ADD | U_TRANS_DELETE | U_TRANS_UPDATE |
	| 16/10/2014 17:03:22 | 2      | 0           | 0              | 0              |
	| 16/10/2014 17:03:23 | 2      | 1           | 2              | 3              |
	| 16/10/2014 17:03:24 | 1      | 2           | 2              | 4              |
	| 16/10/2014 17:03:25 | 0      | 0           | 0              | 1              |
