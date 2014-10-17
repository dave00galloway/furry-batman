@UKUSCC_1196
Feature: UKUSCC_1196CreateLogFileParser
	In order to interpret log files from the positions 2 Redis service
	As a CC tester
	I want to be able to parse the service log and interpret the results

Scenario: Parse log file extract
	Given I have the following log file parser parameters:-
	| fileToParse                                           | parseSyntax                          | OuterSyntaxDelimiter | InnerSyntaxDelimiter | outputfile            |
	| TestData\LogFileTests\Build56_Service_Log_extract.log | [,1,,0, ,^],1,,0, ,^ ,0,U_TRANS,2, , | ^                    | ,                    | TestOutput\output.csv |

	When I parse the log file