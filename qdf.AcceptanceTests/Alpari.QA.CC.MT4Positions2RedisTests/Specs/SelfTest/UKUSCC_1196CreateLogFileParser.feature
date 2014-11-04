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
	| fileToParse                                           | parseSyntax                          | ColumnJoins | OuputDelimiter | OuterSyntaxDelimiter | InnerSyntaxDelimiter | outputfile |
	| TestData\LogFileTests\Build56_Service_Log_extract.log | [,1,,0, ,^],1,,0, ,^ ,0,U_TRANS,2, , |             | ,              | ^                    | ,                    | output.csv |

	When I parse the log file to memory
	And I write the parsed log file to disk

Scenario: Parse log extended file extract
	Given I have the following log file parser parameters:-
	| fileToParse                                                    | parseSyntax                     | ColumnJoins | OuputDelimiter | OuterSyntaxDelimiter | InnerSyntaxDelimiter | outputfile |
	| TestData\LogFileTests\Build56_Service_Log_extract_extended.log | [,1,,0, ,^],1,,0, ,^ ,0,U_,2, , |             | ,              | ^                    | ,                    | output.csv |

	When I parse the log file to memory
	And I analyze the log file by activity frequency
	And I output the log file frequency analysis
	And I generate statistics about the frequency analysis
	And I output the frequency analysis statistics
	Then the mt4P2RLogEntryAnalysisList has the following entries:-
	| TimeStamp           | U_INIT | U_TRANS_ADD | U_TRANS_DELETE | U_TRANS_UPDATE |
	| 16/10/2014 17:03:22 | 2      | 2           | 2              | 4              |
	| 16/10/2014 17:03:23 | 2      | 1           | 2              | 3              |
	| 16/10/2014 17:03:24 | 1      | 2           | 2              | 4              |
	| 16/10/2014 17:03:25 | 2      | 2           | 2              | 4              |

Scenario: Parse log extended file extract and export to graph
	Given I have the following log file parser parameters:-
	| fileToParse                                                    | parseSyntax                     | ColumnJoins | OuputDelimiter | OuterSyntaxDelimiter | InnerSyntaxDelimiter | outputfile |
	| TestData\LogFileTests\Build56_Service_Log_extract_extended.log | [,1,,0, ,^],1,,0, ,^ ,0,U_,2, , |             | ,              | ^                    | ,                    | output.csv |

	When I parse the log file to memory
	And I analyze the log file by activity frequency
	Then I can export the the analysis as a line graph



Scenario: Cleanse log file
	Given I have the following log file parser parameters:-
	| fileToParse                                            | parseSyntax                     | OuterSyntaxDelimiter | InnerSyntaxDelimiter | outputfile                                                |
	| C:\TEMP\MT4P2R_Build73_10_10_144_25_443_2014-10-29.log | [,1,,0, ,^],1,,0, ,^ ,0,U_,2, , | ^                    | ,                    | MT4P2R_Build73_10_10_144_25_443_2014-10-29.log_parsed.log |

	When I parse the log file


Scenario: Parse log file and export to graph
	Given I have the following log file parser parameters:-
	| fileToParse                                                                                     | parseSyntax                     | ColumnJoins | OuputDelimiter | OuterSyntaxDelimiter | InnerSyntaxDelimiter | outputfile                                            |
	| C:\Reports\20141030143800568\UKUSCC_1230CombineLogFiles\Concatenate2moreLogFiles\OutputFile.log | [,1,,0, ,^],1,,0, ,^ ,0,U_,2, , |             | ,              | ^                    | ,                    | MT4P2R_build73_10_10_144_25_443_2014-10-29_parsed.log |

	When I parse the log file to memory
	And I write the parsed log file to disk
	And I analyze the log file by activity frequency
	And I output the log file frequency analysis
	And I generate statistics about the frequency analysis
	And I output the frequency analysis statistics
	Then I can export the the analysis as a line graph
