@UKUSCC_1310
Feature: WebDriverCoreSetup
	In order to configure webdrivers
	As a web tester
	I want to be able to specify configurations for multiple webdrivers

Scenario: Setup a default webdriver core
	When I create a default webdriver
	Then the default webdriver is not null

Scenario: Setup a webdriver core using an xml configuration
	When I create a webdriver from "DefaultDriver"
	And I navigate to the base url
	Then the displayed url contains "www.google.co.uk"

Scenario: Setup a webdriver core using an xml configuration based on the default driver
	When I create a webdriver from "SpecialDriver"
	And I navigate to the base url
	Then the displayed url contains "yahoo"


Scenario: Create 2 webdrivers based on the same xml file
	When I create a webdriver named "SpecialDriverA" from "SpecialDriver" 
	And I create a webdriver named "SpecialDriverB" from "SpecialDriver" 
	And I start these webdrivers "SpecialDriverA,SpecialDriverB"
	Then the webdriver manager contains 2 drivers with the name "SpecialDriver"

