@UKUSQDF_164 @WebClient
Feature: UKUSQDF-164[AT] investigate automation of requesting reports from CNX hhh
	In order to verify Cnx2Redis data in the cnx-deals key
	As a QDF Tester
	I want to get cnx hub data via a scheduled job

Scenario: Connect to hub admin and download report
	Given I have connected to currenex hub admin
	#When I request the trade activity report
	When I request the trade activity report as csv
#conclusion - can connect to Cnx ok, but acessing reports is problematic. an error message is returned when posting the values, but it doesn't say what the problem is in enought detail.

##login HAR
#
#      {
#        "startedDateTime": "2014-08-01T15:29:01.782Z",
#        "time": 517.0001983642578,
#        "request": {
#          "method": "POST",
#          "url": "https://pret.currenex.com/webadmin/loginAction.action",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Cookie",
#              "value": "JSESSIONID=0C89386B0F811F96EDCEC476C0188DEB"
#            },
#            {
#              "name": "Origin",
#              "value": "https://pret.currenex.com"
#            },
#            {
#              "name": "Accept-Encoding",
#              "value": "gzip,deflate,sdch"
#            },
#            {
#              "name": "Host",
#              "value": "pret.currenex.com"
#            },
#            {
#              "name": "Accept-Language",
#              "value": "en-US,en;q=0.8"
#            },
#            {
#              "name": "User-Agent",
#              "value": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"
#            },
#            {
#              "name": "Content-Type",
#              "value": "application/x-www-form-urlencoded"
#            },
#            {
#              "name": "Accept",
#              "value": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
#            },
#            {
#              "name": "Cache-Control",
#              "value": "max-age=0"
#            },
#            {
#              "name": "Referer",
#              "value": "https://pret.currenex.com/webadmin/index.action"
#            },
#            {
#              "name": "Connection",
#              "value": "keep-alive"
#            },
#            {
#              "name": "Content-Length",
#              "value": "59"
#            }
#          ],
#          "queryString": [],
#          "cookies": [
#            {
#              "name": "JSESSIONID",
#              "value": "0C89386B0F811F96EDCEC476C0188DEB",
#              "expires": null,
#              "httpOnly": false,
#              "secure": false
#            }
#          ],
#          "headersSize": 612,
#          "bodySize": 59,
#          "postData": {
#            "mimeType": "application/x-www-form-urlencoded",
#            "text": "e2ee=&username=auk_dgalloway&password=auk12345&loginsource=",
#            "params": [
#              {
#                "name": "e2ee",
#                "value": ""
#              },
#              {
#                "name": "username",
#                "value": "auk_dgalloway"
#              },
#              {
#                "name": "password",
#                "value": "auk12345"
#              },
#              {
#                "name": "loginsource",
#                "value": ""
#              }
#            ]
#          }
#        },
#        "response": {
#          "status": 302,
#          "statusText": "Found",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Location",
#              "value": "https://pret.currenex.com/webadmin/index.action"
#            },
#            {
#              "name": "Date",
#              "value": "Fri, 01 Aug 2014 15:29:02 GMT"
#            },
#            {
#              "name": "Server",
#              "value": "Apache"
#            },
#            {
#              "name": "Connection",
#              "value": "Keep-Alive"
#            },
#            {
#              "name": "Keep-Alive",
#              "value": "timeout=15, max=500"
#            },
#            {
#              "name": "Content-Length",
#              "value": "0"
#            },
#            {
#              "name": "Content-Type",
#              "value": "text/plain"
#            }
#          ],
#          "cookies": [],
#          "content": {
#            "size": 0,
#            "mimeType": "text/plain",
#            "compression": 0
#          },
#          "redirectURL": "https://pret.currenex.com/webadmin/index.action",
#          "headersSize": 236,
#          "bodySize": 0
#        },
#        "cache": {},
#        "timings": {
#          "blocked": 172.99999999886495,
#          "dns": 1.0000000002037268,
#          "connect": 258.99999999819556,
#          "send": 0,
#          "wait": 83.00000000235741,
#          "receive": 1.0001983646361623,
#          "ssl": 175.99999999947613
#        },
#        "connection": "65637",
#        "pageref": "page_2"
#      },
#
##go to reports
#      {
#        "startedDateTime": "2014-08-01T15:33:57.108Z",
#        "time": 641.9999599456787,
#        "request": {
#          "method": "GET",
#          "url": "https://pret.currenex.com/webadmin/report/types.action?_=1406907237120",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Cookie",
#              "value": "JSESSIONID=0C89386B0F811F96EDCEC476C0188DEB"
#            },
#            {
#              "name": "Accept-Encoding",
#              "value": "gzip,deflate,sdch"
#            },
#            {
#              "name": "Host",
#              "value": "pret.currenex.com"
#            },
#            {
#              "name": "Accept-Language",
#              "value": "en-US,en;q=0.8"
#            },
#            {
#              "name": "User-Agent",
#              "value": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"
#            },
#            {
#              "name": "Accept",
#              "value": "text/html, */*; q=0.01"
#            },
#            {
#              "name": "Referer",
#              "value": "https://pret.currenex.com/webadmin/index.action"
#            },
#            {
#              "name": "X-Requested-With",
#              "value": "XMLHttpRequest"
#            },
#            {
#              "name": "Connection",
#              "value": "keep-alive"
#            }
#          ],
#          "queryString": [
#            {
#              "name": "_",
#              "value": "1406907237120"
#            }
#          ],
#          "cookies": [
#            {
#              "name": "JSESSIONID",
#              "value": "0C89386B0F811F96EDCEC476C0188DEB",
#              "expires": null,
#              "httpOnly": false,
#              "secure": false
#            }
#          ],
#          "headersSize": 480,
#          "bodySize": 0
#        },
#        "response": {
#          "status": 200,
#          "statusText": "OK",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Date",
#              "value": "Fri, 01 Aug 2014 15:33:57 GMT"
#            },
#            {
#              "name": "Server",
#              "value": "Apache"
#            },
#            {
#              "name": "Connection",
#              "value": "Keep-Alive"
#            },
#            {
#              "name": "Keep-Alive",
#              "value": "timeout=15, max=500"
#            },
#            {
#              "name": "Transfer-Encoding",
#              "value": "chunked"
#            },
#            {
#              "name": "Content-Type",
#              "value": "text/html;charset=UTF-8"
#            }
#          ],
#          "cookies": [],
#          "content": {
#            "size": 9549,
#            "mimeType": "text/html",
#            "compression": -20
#          },
#          "redirectURL": "",
#          "headersSize": 196,
#          "bodySize": 9569
#        },
#        "cache": {},
#        "timings": {
#          "blocked": 158.99999999965075,
#          "dns": 1.0000000002037268,
#          "connect": 262.0000000024447,
#          "send": 1.0000000002037268,
#          "wait": 147.99999999740976,
#          "receive": 70.99995994576602,
#          "ssl": 180.00000000029104
#        },
#        "connection": "66290",
#        "pageref": "page_2"
#      },
#
#	  #go to trade activity report
#     {
#        "startedDateTime": "2014-08-01T15:36:34.175Z",
#        "time": 625.499963760376,
#        "request": {
#          "method": "POST",
#          "url": "https://pret.currenex.com/webadmin/report/list.action",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Cookie",
#              "value": "JSESSIONID=0C89386B0F811F96EDCEC476C0188DEB"
#            },
#            {
#              "name": "Origin",
#              "value": "https://pret.currenex.com"
#            },
#            {
#              "name": "Accept-Encoding",
#              "value": "gzip,deflate,sdch"
#            },
#            {
#              "name": "Host",
#              "value": "pret.currenex.com"
#            },
#            {
#              "name": "Accept-Language",
#              "value": "en-US,en;q=0.8"
#            },
#            {
#              "name": "User-Agent",
#              "value": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"
#            },
#            {
#              "name": "Content-Type",
#              "value": "application/x-www-form-urlencoded"
#            },
#            {
#              "name": "Accept",
#              "value": "text/html, */*; q=0.01"
#            },
#            {
#              "name": "Referer",
#              "value": "https://pret.currenex.com/webadmin/index.action"
#            },
#            {
#              "name": "X-Requested-With",
#              "value": "XMLHttpRequest"
#            },
#            {
#              "name": "Connection",
#              "value": "keep-alive"
#            },
#            {
#              "name": "Content-Length",
#              "value": "15"
#            }
#          ],
#          "queryString": [],
#          "cookies": [
#            {
#              "name": "JSESSIONID",
#              "value": "0C89386B0F811F96EDCEC476C0188DEB",
#              "expires": null,
#              "httpOnly": false,
#              "secure": false
#            }
#          ],
#          "headersSize": 568,
#          "bodySize": 15,
#          "postData": {
#            "mimeType": "application/x-www-form-urlencoded",
#            "text": "_=1406907237120",
#            "params": [
#              {
#                "name": "_",
#                "value": "1406907237120"
#              }
#            ]
#          }
#        },
#        "response": {
#          "status": 200,
#          "statusText": "OK",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Date",
#              "value": "Fri, 01 Aug 2014 15:36:34 GMT"
#            },
#            {
#              "name": "Server",
#              "value": "Apache"
#            },
#            {
#              "name": "Connection",
#              "value": "Keep-Alive"
#            },
#            {
#              "name": "Keep-Alive",
#              "value": "timeout=15, max=500"
#            },
#            {
#              "name": "Transfer-Encoding",
#              "value": "chunked"
#            },
#            {
#              "name": "Content-Type",
#              "value": "text/html;charset=UTF-8"
#            }
#          ],
#          "cookies": [],
#          "content": {
#            "size": 76693,
#            "mimeType": "text/html",
#            "compression": -84
#          },
#          "redirectURL": "",
#          "headersSize": 196,
#          "bodySize": 76777
#        },
#        "cache": {},
#        "timings": {
#          "blocked": 2.0000000004074536,
#          "dns": 1.0000000002037268,
#          "connect": 290.0000000008731,
#          "send": 0,
#          "wait": 112.99999999755528,
#          "receive": 219.4999637613364,
#          "ssl": 77.00000000113505
#        },
#        "connection": "66525",
#        "pageref": "page_2"
#      },
#
##select report
#      {
#        "startedDateTime": "2014-08-01T15:40:17.002Z",
#        "time": 1039.0000343322754,
#        "request": {
#          "method": "POST",
#          "url": "https://pret.currenex.com/webadmin/report/viewTradeReport.action",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Cookie",
#              "value": "JSESSIONID=0C89386B0F811F96EDCEC476C0188DEB"
#            },
#            {
#              "name": "Origin",
#              "value": "https://pret.currenex.com"
#            },
#            {
#              "name": "Accept-Encoding",
#              "value": "gzip,deflate,sdch"
#            },
#            {
#              "name": "Host",
#              "value": "pret.currenex.com"
#            },
#            {
#              "name": "Accept-Language",
#              "value": "en-US,en;q=0.8"
#            },
#            {
#              "name": "User-Agent",
#              "value": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"
#            },
#            {
#              "name": "Content-Type",
#              "value": "application/x-www-form-urlencoded"
#            },
#            {
#              "name": "Accept",
#              "value": "*/*"
#            },
#            {
#              "name": "Referer",
#              "value": "https://pret.currenex.com/webadmin/index.action"
#            },
#            {
#              "name": "X-Requested-With",
#              "value": "XMLHttpRequest"
#            },
#            {
#              "name": "Connection",
#              "value": "keep-alive"
#            },
#            {
#              "name": "Content-Length",
#              "value": "145"
#            }
#          ],
#          "queryString": [],
#          "cookies": [
#            {
#              "name": "JSESSIONID",
#              "value": "0C89386B0F811F96EDCEC476C0188DEB",
#              "expires": null,
#              "httpOnly": false,
#              "secure": false
#            }
#          ],
#          "headersSize": 561,
#          "bodySize": 145,
#          "postData": {
#            "mimeType": "application/x-www-form-urlencoded",
#            "text": "currentDate=08%2F01%2F2014&pageIndex=0&view=HTML&fromDateStr=07%2F31%2F2014&toDateStr=07%2F31%2F2014&selectedAccountId=&selectReport=Trade+Report",
#            "params": [
#              {
#                "name": "currentDate",
#                "value": "08%2F01%2F2014"
#              },
#              {
#                "name": "pageIndex",
#                "value": "0"
#              },
#              {
#                "name": "view",
#                "value": "HTML"
#              },
#              {
#                "name": "fromDateStr",
#                "value": "07%2F31%2F2014"
#              },
#              {
#                "name": "toDateStr",
#                "value": "07%2F31%2F2014"
#              },
#              {
#                "name": "selectedAccountId",
#                "value": ""
#              },
#              {
#                "name": "selectReport",
#                "value": "Trade+Report"
#              }
#            ]
#          }
#        },
#        "response": {
#          "status": 200,
#          "statusText": "OK",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Date",
#              "value": "Fri, 01 Aug 2014 15:40:17 GMT"
#            },
#            {
#              "name": "Server",
#              "value": "Apache"
#            },
#            {
#              "name": "Connection",
#              "value": "Keep-Alive"
#            },
#            {
#              "name": "Keep-Alive",
#              "value": "timeout=15, max=500"
#            },
#            {
#              "name": "Transfer-Encoding",
#              "value": "chunked"
#            },
#            {
#              "name": "Content-Type",
#              "value": "text/html"
#            }
#          ],
#          "cookies": [],
#          "content": {
#            "size": 123661,
#            "mimeType": "text/html",
#            "compression": -132
#          },
#          "redirectURL": "",
#          "headersSize": 182,
#          "bodySize": 123793
#        },
#        "cache": {},
#        "timings": {
#          "blocked": 173.99999999906868,
#          "dns": 0,
#          "connect": 258.0000000016298,
#          "send": 0,
#          "wait": 386.99999999880674,
#          "receive": 220.00003433277016,
#          "ssl": 175.99999999947613
#        },
#        "connection": "66847",
#        "pageref": "page_2"
#      },
#
##download csv
#      {
#        "startedDateTime": "2014-08-01T15:41:50.155Z",
#        "time": 337.50009536743164,
#        "request": {
#          "method": "GET",
#          "url": "https://pret.currenex.com/webadmin/report/viewReport.action?view=CSV",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Accept-Encoding",
#              "value": "gzip,deflate,sdch"
#            },
#            {
#              "name": "Host",
#              "value": "pret.currenex.com"
#            },
#            {
#              "name": "Accept-Language",
#              "value": "en-US,en;q=0.8"
#            },
#            {
#              "name": "User-Agent",
#              "value": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"
#            },
#            {
#              "name": "Accept",
#              "value": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
#            },
#            {
#              "name": "Referer",
#              "value": "https://pret.currenex.com/webadmin/index.action"
#            },
#            {
#              "name": "Cookie",
#              "value": "JSESSIONID=0C89386B0F811F96EDCEC476C0188DEB"
#            },
#            {
#              "name": "Connection",
#              "value": "keep-alive"
#            }
#          ],
#          "queryString": [
#            {
#              "name": "view",
#              "value": "CSV"
#            }
#          ],
#          "cookies": [
#            {
#              "name": "JSESSIONID",
#              "value": "0C89386B0F811F96EDCEC476C0188DEB",
#              "expires": null,
#              "httpOnly": false,
#              "secure": false
#            }
#          ],
#          "headersSize": 496,
#          "bodySize": 0
#        },
#        "response": {
#          "status": 200,
#          "statusText": "OK",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Date",
#              "value": "Fri, 01 Aug 2014 15:41:50 GMT"
#            },
#            {
#              "name": "Content-Disposition",
#              "value": "attachment; filename=report.csv"
#            },
#            {
#              "name": "Connection",
#              "value": "Keep-Alive"
#            },
#            {
#              "name": "Keep-Alive",
#              "value": "timeout=15, max=500"
#            },
#            {
#              "name": "Transfer-Encoding",
#              "value": "chunked"
#            },
#            {
#              "name": "Server",
#              "value": "Apache"
#            },
#            {
#              "name": "Content-Type",
#              "value": "application/vnd.ms-excel"
#            }
#          ],
#          "cookies": [],
#          "content": {
#            "size": 0,
#            "mimeType": "application/octet-stream",
#            "compression": 251
#          },
#          "redirectURL": "",
#          "headersSize": 251,
#          "bodySize": -251,
#          "_error": ""
#        },
#        "cache": {},
#        "timings": {
#          "blocked": 3.0000000006111804,
#          "dns": 1.0000000002037268,
#          "connect": 154.99999999883585,
#          "send": 0,
#          "wait": 176.99999999967986,
#          "receive": 1.5000953681010287,
#          "ssl": 75.0000000007276
#        },
#        "connection": "67001",
#        "pageref": "page_2"
#      }
#
##Logout
#      {
#        "startedDateTime": "2014-08-01T15:46:11.153Z",
#        "time": 496.0000514984131,
#        "request": {
#          "method": "GET",
#          "url": "https://pret.currenex.com/webadmin/logout.action",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Accept-Encoding",
#              "value": "gzip,deflate,sdch"
#            },
#            {
#              "name": "Host",
#              "value": "pret.currenex.com"
#            },
#            {
#              "name": "Accept-Language",
#              "value": "en-US,en;q=0.8"
#            },
#            {
#              "name": "User-Agent",
#              "value": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"
#            },
#            {
#              "name": "Accept",
#              "value": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
#            },
#            {
#              "name": "Referer",
#              "value": "https://pret.currenex.com/webadmin/index.action"
#            },
#            {
#              "name": "Cookie",
#              "value": "JSESSIONID=0C89386B0F811F96EDCEC476C0188DEB"
#            },
#            {
#              "name": "Connection",
#              "value": "keep-alive"
#            }
#          ],
#          "queryString": [],
#          "cookies": [
#            {
#              "name": "JSESSIONID",
#              "value": "0C89386B0F811F96EDCEC476C0188DEB",
#              "expires": null,
#              "httpOnly": false,
#              "secure": false
#            }
#          ],
#          "headersSize": 476,
#          "bodySize": 0
#        },
#        "response": {
#          "status": 200,
#          "statusText": "OK",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Date",
#              "value": "Fri, 01 Aug 2014 15:46:11 GMT"
#            },
#            {
#              "name": "Connection",
#              "value": "Keep-Alive"
#            },
#            {
#              "name": "Server",
#              "value": "Apache"
#            },
#            {
#              "name": "Set-Cookie",
#              "value": "JSESSIONID=4B89B409DF37109307DC0139E46B5588; Path=/webadmin; Secure"
#            },
#            {
#              "name": "Keep-Alive",
#              "value": "timeout=15, max=500"
#            },
#            {
#              "name": "Content-Length",
#              "value": "4237"
#            },
#            {
#              "name": "Content-Type",
#              "value": "text/html"
#            }
#          ],
#          "cookies": [
#            {
#              "name": "JSESSIONID",
#              "value": "4B89B409DF37109307DC0139E46B5588",
#              "path": "/webadmin",
#              "expires": null,
#              "httpOnly": false,
#              "secure": true
#            }
#          ],
#          "content": {
#            "size": 4237,
#            "mimeType": "text/html",
#            "compression": 0
#          },
#          "redirectURL": "",
#          "headersSize": 257,
#          "bodySize": 4237
#        },
#        "cache": {},
#        "timings": {
#          "blocked": 161.0000000000582,
#          "dns": 0,
#          "connect": 250,
#          "send": 0,
#          "wait": 83.99999999892316,
#          "receive": 1.00005149943172,
#          "ssl": 172.99999999886495
#        },
#        "connection": "67381",
#        "pageref": "page_3"
#      },