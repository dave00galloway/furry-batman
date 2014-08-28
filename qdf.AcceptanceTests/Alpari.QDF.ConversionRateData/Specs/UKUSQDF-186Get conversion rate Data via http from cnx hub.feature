@UKUSQDF_186 @WebClient
Feature: UKUSQDF-186Get conversion rate Data via http from cnx hub
	In order to perform calculations using conversion rates
	As a QDF analyst
	I want access to CNX hub Conversion data

Scenario: Get a days conversion rate data via http from cnx hub
	Given I have connected to currenex hub admin
	When I download yesterday's conversion rate data
	Then the conversion rate data contains 168 lines

Scenario: Get a days conversion rate data via http from cnx hub and save as csv
	Given I have connected to currenex hub admin
	When I download yesterday's conversion rate data to csv
	Then the conversion rate data contains 168 lines
#
#      {
#        "startedDateTime": "2014-08-27T13:28:34.314Z",
#        "time": 718.0001735687256,
#        "request": {
#          "method": "POST",
#          "url": "https://pret.currenex.com/webadmin/conversionRatePackage/viewReportWithoutCache.action",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Cookie",
#              "value": "JSESSIONID=738201D9CBEEEBFA995D41187A88A990"
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
#              "value": "40"
#            }
#          ],
#          "queryString": [],
#          "cookies": [
#            {
#              "name": "JSESSIONID",
#              "value": "738201D9CBEEEBFA995D41187A88A990",
#              "expires": null,
#              "httpOnly": false,
#              "secure": false
#            }
#          ],
#          "headersSize": 582,
#          "bodySize": 40,
#          "postData": {
#            "mimeType": "application/x-www-form-urlencoded",
#            "text": "dateStr=08%2F26%2F2014&pageIndex=0&view=",
#            "params": [
#              {
#                "name": "dateStr",
#                "value": "08%2F26%2F2014"
#              },
#              {
#                "name": "pageIndex",
#                "value": "0"
#              },
#              {
#                "name": "view",
#                "value": ""
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
#              "value": "Wed, 27 Aug 2014 13:28:34 GMT"
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
#            "size": 273684,
#            "mimeType": "text/html",
#            "compression": -276
#          },
#          "redirectURL": "",
#          "headersSize": 182,
#          "bodySize": 273960
#        },
#        "cache": {},
#        "timings": {
#          "blocked": 1.999999862164259,
#          "dns": 0.9999999310821295,
#          "connect": 153.00000016577542,
#          "send": 0,
#          "wait": 126.99999986216426,
#          "receive": 435.0001737475395,
#          "ssl": 76.00000011734664
#        },
#        "connection": "345987",
#        "pageref": "page_1"
#      }
#	  
#      {
#        "startedDateTime": "2014-08-27T13:31:03.329Z",
#        "time": 516.0000324249268,
#        "request": {
#          "method": "GET",
#          "url": "https://pret.currenex.com/webadmin/conversionRatePackage/viewReportFromCache.action?view=CSV&dateStr=08/26/2014",
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
#              "value": "JSESSIONID=738201D9CBEEEBFA995D41187A88A990"
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
#            },
#            {
#              "name": "dateStr",
#              "value": "08/26/2014"
#            }
#          ],
#          "cookies": [
#            {
#              "name": "JSESSIONID",
#              "value": "738201D9CBEEEBFA995D41187A88A990",
#              "expires": null,
#              "httpOnly": false,
#              "secure": false
#            }
#          ],
#          "headersSize": 539,
#          "bodySize": 0
#        },
#        "response": {
#          "status": 200,
#          "statusText": "OK",
#          "httpVersion": "HTTP/1.1",
#          "headers": [
#            {
#              "name": "Date",
#              "value": "Wed, 27 Aug 2014 13:31:03 GMT"
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
#              "name": "Content-Length",
#              "value": "6708"
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
#            "compression": 245
#          },
#          "redirectURL": "",
#          "headersSize": 245,
#          "bodySize": -245,
#          "_error": ""
#        },
#        "cache": {},
#        "timings": {
#          "blocked": 161.00000008009374,
#          "dns": 0,
#          "connect": 239.00000005960464,
#          "send": 0,
#          "wait": 114.99999999068677,
#          "receive": 1.0000322945415974,
#          "ssl": 158.0000000540167
#        },
#        "connection": "346240",
#        "pageref": "page_1"
#      }	  

