import redis

r = redis.StrictRedis()

ps = r.pubsub()
ps.subscribe('mychannel')

for item in ps.listen():
    if item['type'] == 'message':
        print item['data']
