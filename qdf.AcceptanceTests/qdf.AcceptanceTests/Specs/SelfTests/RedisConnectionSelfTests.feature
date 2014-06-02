Feature: RedisConnectionSelfTests
	In order to check deals in QDF
	As a tester
	I want to be able to get data from Redis

@mytag
Scenario: retrieve deal data by absolute date
	Given I have QDF Deal Data
	 | ConvertedStartTime   | ConvertedEndTime     |
	 | 05/05/2014  12:45:42 | 05/05/2014  12:49:51 |

	#| startTime | endTime |
	#| -5D       | +4D     |
