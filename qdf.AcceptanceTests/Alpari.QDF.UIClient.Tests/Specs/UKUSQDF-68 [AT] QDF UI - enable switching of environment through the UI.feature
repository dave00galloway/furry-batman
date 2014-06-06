@UKUSQDF_68 @TeardownRedisConnection
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

Scenario Outline: Switch Environments
	Given I am connected to qdf on "10.10.144.156"
	And I want to be able to switch environments
	When I change the redis connection to "<Environments>"
	Then I am connected to qdf on "<Environments>"
	Examples: 
	| Environments                  |
	| uk-redis-prod.corp.alpari.com |
	| uk-redis-uat.corp.alpari.com  |
	| uk-redis-dev.corp.alpari.com  |

