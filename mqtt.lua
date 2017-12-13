wifi_config = {}
wifi_config.ssid="DVRTESTE"
wifi_config.pwd="v2techwifi"
wifi.sta.config(wifi_config)

tmr.alarm(1, 10000, 0, function()
  print(wifi.sta.getip())
end)

m = mqtt.Client("clientid", 120)
m:lwt("/lua/lwt", "offline", 0, 0)

m:on("connect", function(client) print ("connected") end)
m:on("offline", function(client) print ("offline") end)

m:connect("v2alarm.ddns.net", 1883, 0, function(client)
  print("connected")
  
  client:subscribe("/lua/topic", 0, function(client) print("subscribe success") end)
  client:publish("/lua/topic", "hello", 0, 0, function(client) print("sent") end)
end,
function(client, reason)
  print("failed reason: " .. reason)
end)

m:on("message", function(client, topic, data) 
  --print(topic .. ":" ) 
  if data ~= nil then
    --print(data)
    if data == "hi" then
      print "hi!"
    end
  end
end)