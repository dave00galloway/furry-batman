Feature: ShareContextOne
	In order to do complicated and lengthy setup only once per test run
	As a Test Designer
	I want to be able to share context across features

@selfTestContext
Scenario: Access a static object from ShareContextOne ScenarioOne
	Given I access the static object
	When I display the static object "timeNowIs" property
	And I display the static object "randomFileName" property
	Then the static object "timeNowIs" property matches the feature "timeNowIs" property
	And the static object "randomFileName" property matches the feature "randomFileName" property

@selfTestContext
Scenario: Access a static object from ShareContextOne ScenarioTwo
	Given I access the static object
	When I display the static object "timeNowIs" property
	And I display the static object "randomFileName" property
	Then the static object "timeNowIs" property matches the feature "timeNowIs" property
	And the static object "randomFileName" property matches the feature "randomFileName" property