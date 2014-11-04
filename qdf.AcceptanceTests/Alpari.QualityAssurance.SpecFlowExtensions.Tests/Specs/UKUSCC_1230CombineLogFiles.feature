@UKUSCC_1230
Feature: UKUSCC_1230CombineLogFiles
	In order to parse log files for tests that run over midnight
	As  a CC Tester
	I want to be able to join log files from different days

Scenario: Concatenate 2 Log Files
	Given I have the following log file join parameters:-
	| File1                 | File2                 | OutputFile     | 
	| TestData\LogFile1.log | TestData\LogFile2.log | OutputFile.log |  

	When I join the log files
	Then the output file should contain 9 lines

#Scenario: Concatenate 2more Log Files
#	Given I have the following log file join parameters:-
#	| File1               | File2                    | OutputFile     |
#	| C:\Temp\extract.log | C:\Temp\PostMidnight.txt | OutputFile.log |
#
#	When I join the log files
#	Then the output file should contain 9 lines