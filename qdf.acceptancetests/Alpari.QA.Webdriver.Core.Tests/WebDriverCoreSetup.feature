@UKUSCC_1310
Feature: WebDriverCoreSetup
	In order to configure webdrivers
	As a web tester
	I want to be able to specify configurations for multiple webdrivers

Scenario: Setup a default webdriver core
	When I create a default webdriver
	Then the default webdriver is not null

Scenario: Setup a webdriver core using an xml configuration
	When I create a webdriver from "DriverConfig\DefaultDriver.xml"
	And I navigate to the base url
	Then the displayed url is "www.google.co.uk"
