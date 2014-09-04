@UKUSCC_1014
Feature: UKUSCC-1014_AT_Create Tools for comparing redis positions
	In order to test MT4Positions2Redis
	As a CC Tester
	I want to be able to query redis positions

#currently assumes 1 or more manually entered trades
Background: get positions
	Given I have a connection to a redis repository on "localhost" port 6379 db 0
	When I get all positions for server "ProTest"
	
Scenario: Get open positions
	Then at least 1 position is for login 7003713

#Scenario: convert open positions
#	When I convert open positions to testable positions
#	Then at least 1 position has an OpenTime of "2014/09/02 11:59:57"

#possible SQL for retrieving positions from ARS
#SELECT 
#  o.login,
#  o.`order`,
#  o.cmd,
#  (o.volume / 100) AS volume, 
#  o.open_price,
#  o.sl,
#  o.tp,
#  FROM_UNIXTIME(o.open_ts) AS open_time, 
#  o.comment,
#  FROM_UNIXTIME(t.ts) AS timestamp, -- for info only, should always be later than redis timestamp
#  o.value_ts,
#  a.`group`,
#  o.state AS status,
#  o.symbol_name AS symbol,
#   "ProTest" AS server,
#  "UNKNOWN" AS book
#   FROM orders o
#    JOIN accounts a
#    ON  o.login = a.login
#  LEFT JOIN traderecord t
#  ON o.`order` = t.`order`
#   where 
#   o.cmd IN (0,1)
#    and o.close_ts = 0 -- open orders
#   and a.`status` NOT LIKE '%RE%'
#-- and a.`group` not rlike '^Closed.*IB$|demo|test'
#-- and a.`name` not rlike 'Test|Data Center|Data Centre'
#-- and a.email not like '%alpari.co.uk'
#  AND t.ts = (SELECT MAX(ts) FROM traderecord t2 WHERE t.`order` = t2.`order`)
#  AND o.`order`= 2969861