﻿Feature: GetDailySnapshotFromCC
	In order to get daily snapshot delatas
	As a Tester
	I want to get the nearest snapshot to midday for each position

@mytag
Scenario: Get 2 daily snapshots
	Given I have daily ccTool snapshot data from "-3D" to "+2D"
