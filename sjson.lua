local ssid
local password

t = sjson.decode('{"ssid":"DVRTESTE", "pass": "v2techwifi"}')

for key, value in pairs(t) do 
  if key == "ssid" then
    ssid = value
  end
  if key == "pass" then
    password = value
  end
end

print(ssid)
print(password)