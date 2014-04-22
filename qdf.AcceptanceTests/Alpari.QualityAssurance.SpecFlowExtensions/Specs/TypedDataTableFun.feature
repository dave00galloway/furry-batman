Feature: TypedDataTableFun
	In order to compare sets of actual and expected data
	As a Tester
	I want methods for comparing Typed Data Tables

@mytag
Scenario: Compare Two matching data sets
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data
	Then the person data should match exactly

Scenario: Compare Two data sets one mismatch
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	When I compare the "expected" and "actual" person data
	Then the person data should match exactly


Scenario: Compare Two data sets one missing
	Given I have the following "expected" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 99  | Impaler        |
	| 2  | John      | Kerry    | 100 | stand up comic |
	And I have the following "actual" person data:
	| ID | Forenames | Lastname | Age | Occupation     |
	| 1  | Vladimir  | Putin    | 98  | Impaler        |
	When I compare the "expected" and "actual" person data
	Then the person data should match exactly