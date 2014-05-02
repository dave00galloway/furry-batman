Feature: CsvConversions
	In order to read and write data
	As a tester
	I want to be able to create objects from csv and vice versa

@mytag
Scenario: create file from list of objects and read back as list
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I export the "expected" person data to csv "people.csv"
	And I import the csv file "people.csv" as a Person list caled "actual"
	And I compare the "expected" and "actual" person data
	Then the person data should match exactly


Scenario: create file from list of objects and read back as list with duplicates
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	And I have the following "additional" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 3  | Vladimir  | Putin    | 99  | Impaler        |
	| 4  | John      | Kerry    | 100 | stand up comic |
	When I export the "expected" person data to csv "people.csv"
	And I append the "additional" person data to csv "people.csv"
	And I import the csv file "people.csv" as a Person list caled "actual"
	And I compare the "expected" and "actual" person data
	Then the person data should contain 2 "extra"