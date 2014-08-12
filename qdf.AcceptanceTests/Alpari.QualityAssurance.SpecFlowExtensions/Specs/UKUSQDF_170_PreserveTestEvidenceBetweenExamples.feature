@UKUSQDF_170
Feature: UKUSQDF_170_PreserveTestEvidenceBetweenExamples
	In order to preserver test evidence when running a scenario outline
	As a tester
	I want a scenario hook to move test evidence to a unique folder 
@ignore
Scenario Outline: Preserve test evidence between test runs
	Given I create a file called "<filename>"
	And I waste some time
	Examples: 
	| filename |
	| a        |
	| b        |
	| c        |

	#this functionaliuty basically doesn't work. something is holding on to files between runs, so it's impossible to recreate in a controlled way

