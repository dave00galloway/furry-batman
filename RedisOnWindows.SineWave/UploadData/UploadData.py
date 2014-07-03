import redis, csv

r = redis.StrictRedis()

r.delete('cities')

#readColsAlready = False
#colCount = 0

csvFile = csv.reader(open('cnx-deals-data.csv','rb'),delimiter='|')
for row in csvFile:
    #key = float(row[0])
    key = float(row.pop(0)) # works! 
    #key = row.pop(0)
    #for x in range(1,row
    #if readColsAlready != True:
    #    readColsAlready = True
    #    for col in row:
    #        colCount +=1
    #for x in range(1,colCount):
    #dataSource = row
    #for col in dataSource

    data = ",".join(row)
    r.zadd('cities',key,data)