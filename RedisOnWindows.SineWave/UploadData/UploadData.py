import redis, csv

r = redis.StrictRedis()

r.delete('cities')