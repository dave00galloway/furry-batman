@UKUSCC_1196
Feature: UKUSCC_1196CreateLogFileParser
	In order to interpret log files from the positions 2 Redis service
	As a CC tester
	I want to be able to parse the service log and interpret the results

Scenario: Cleanse log file extract
	Given I have the following log file parser parameters:-
	| fileToParse                                           | parseSyntax                          | OuterSyntaxDelimiter | InnerSyntaxDelimiter | outputfile            |
	| TestData\LogFileTests\Build56_Service_Log_extract.log | [,1,,0, ,^],1,,0, ,^ ,0,U_TRANS,2, , | ^                    | ,                    | TestOutput\output.csv |

	When I parse the log file

Scenario: Parse log file extract
	Given I have the following log file parser parameters:-
	| fileToParse                                           | parseSyntax                          | ColumnJoins | OuputDelimiter | OuterSyntaxDelimiter | InnerSyntaxDelimiter | outputfile            |
	| TestData\LogFileTests\Build56_Service_Log_extract.log | [,1,,0, ,^],1,,0, ,^ ,0,U_TRANS,2, , | 0,1, ,      | ,              | ^                    | ,                    | TestOutput\output.csv |

	When I parse the log file to memory

Scenario: Cleanse log file
	Given I have the following log file parser parameters:-
	| fileToParse                                                                                              | parseSyntax                          | OuterSyntaxDelimiter | InnerSyntaxDelimiter | outputfile                                            |
	| C:\TEMP\LoadTestResults\build56\run002\01MixedUseScenario\MT4P2R_build56_10_10_144_25_443_2014-10-17.log | [,1,,0, ,^],1,,0, ,^ ,0,U_TRANS,2, , | ^                    | ,                    | MT4P2R_build56_10_10_144_25_443_2014-10-17_parsed.log |

	When I parse the log file
