import redis, math, time

r = redis.StrictRedis()

for n in range(0,100000):
    currentrow = (62*'X')[0:32 + int(30*math.sin(n/8.0))]
    r.publish('mychannel',currentrow)
    print currentrow
    time.sleep(.01)