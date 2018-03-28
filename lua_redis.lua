local parking_places = 100;

local function get_airplane_parking(airplane_id)
  
  for i=0, parking_places -1, 1
  do
    if redis.call("LINDEX", "parking", i) == airplane_id
    then
      return tostring(i);
    end
  end
  return nil
end

local function pick_airplane_parking(airplane_id)
  local parking = get_airplane_parking(airplane_id);
  
  if parking == nil
  then
    parking = redis.call("SRANDMEMBER", "free");
		redis.call("SREM", "free", parking);
		redis.call("LSET", "parking", parking, airplane_id);
  end
  
  return parking
end

print(ARGV[1])
local airplane_id = ARGV[1];
return pick_airplane_parking(airplane_id);

