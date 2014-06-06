@UKUSQDF_68
Feature: UKUSQDF-68 [AT] QDF UI - enable switching of environment through the UI
	In order to compare data in different QDF Environments
	As a QDFD Analyst
	I want to be able to change environment

Scenario: Setup Environment UI Control
	Given I want to be able to switch environments
	Then the list of environments options should be:
	| Environments                  |
	| uk-redis-prod.corp.alpari.com |
	| uk-redis-uat.corp.alpari.com  |
	| uk-redis-dev.corp.alpari.com  |
