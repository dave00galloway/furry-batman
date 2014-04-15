Feature: EnableCrossStepDefinitionCallsOne
	In order to avoid circular dependencies
	As a Test Designer
	I want to be able to store and retrieve references to step definitions via the scenario context

@mytag
Scenario: A lazy write once property set in an earlier call to a step def remains the same value after subsequent calls to the same step def
	Given I have called a method which sets a lazy property in step definition file one
	When I call a method in step definition two that calls the same method in step definition file one
	Then The current and new lazy property values are the same
	
@mytag
Scenario: A call to a step def via another step def when the called step def has not been directly instantiated
	Given I create an instance of step definition one from step definition two
		And I call a method in step definition two that calls the same method in step definition file one
	When I call a method in step definition two that calls the same method in step definition file one
	Then The current and new lazy property values are the same