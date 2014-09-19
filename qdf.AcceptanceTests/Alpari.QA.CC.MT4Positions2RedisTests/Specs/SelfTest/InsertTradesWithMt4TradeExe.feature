Feature: InsertTradesWithMt4TradeExe
	In order to create open positions in MT4
	As a CC Tester
	I want to Bulk Insert trades to MT4

Scenario: Launch MT4Trade.exe
	Given I have these parameters for MT4Trade:-
	| FileName                  | Arguments                                | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
	| AUT\MT4Trade\MT4Trade.exe | -s 10.10.144.25:443 -u 7003906 -p Trader | false           | true                  | true                  | true                   | true           |
	When I launch MT4Trade
	And I send string "buy volume=345 symbol=EURUSD price=1.5" to MT4Trade
	And I send string "buy volume=345 symbol=EURUSD price=1.5" to MT4Trade
	And I send string "buy volume=345 symbol=EURUSD price=1.5" to MT4Trade
	And I send string "buy volume=345 symbol=EURUSD price=1.5" to MT4Trade
	#Then MT4Trade output contains "opened"
	When I send string "exit" to MT4Trade
	Then MT4Trade output contains "opened"
	Then MT4Trade output contains "Press Ctrl+C to exit"
	#Then MT4Trade output contains "Disconnecting '7003906'"

#don't use any command other than buy or sell as the feedback doesn't come until exit is called
#Scenario: Launch MT4Trade.exe and close trades
#	Given I have these parameters for MT4Trade:-
#	| FileName                  | Arguments                                | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
#	| AUT\MT4Trade\MT4Trade.exe | -s 10.10.144.25:443 -u 7003906 -p Trader | false           | true                  | true                  | true                   | true           |
#	When I launch MT4Trade
#	And I send string "buy volume=345 symbol=EURUSD price=1.5" to MT4Trade
#	And I send string "buy volume=345 symbol=EURUSD price=1.5" to MT4Trade
#	And I send string "buy volume=345 symbol=EURUSD price=1.5" to MT4Trade
#	And I send string "buy volume=345 symbol=EURUSD price=1.5" to MT4Trade
#	And I send string "close_all" to MT4Trade
#	
#	When I send string "exit" to MT4Trade
#	Then MT4Trade output contains "opened"
#	Then MT4Trade output contains "Press Ctrl+C to exit"
	
	#Then MT4Trade output contains "Disconnecting '7003906'"

Scenario: Launch MT4Trade.exe and bulk load identical trades
	Given I have these parameters for MT4Trade:-
	| FileName                  | Arguments                                | UseShellExecute | RedirectStandardError | RedirectStandardInput | RedirectStandardOutput | CreateNoWindow |
	| AUT\MT4Trade\MT4Trade.exe | -s 10.10.144.25:443 -u 7003906 -p Trader | false           | true                  | true                  | true                   | true           |
	When I launch MT4Trade
	And I load 100 trades with these parameters "buy volume=345 symbol=EURUSD price=1.5" with MT4Trade
	#Then MT4Trade output contains "opened"
	When I send string "exit" to MT4Trade
	Then MT4Trade output contains "opened"
	Then MT4Trade output contains "Press Ctrl+C to exit"

