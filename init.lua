redis.replicate_commands()
redis.call("FLUSHALL")
local parking_places = 100;

for i=0, parking_places - 1, 1
do
	redis.call("LPUSH", "parking", "empty")
	redis.call("SADD", "free", i)
end
