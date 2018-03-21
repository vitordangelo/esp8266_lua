tls.cert.verify(server)

m = mqtt.Client("clientid", 120, "app", "vitor123")

m:lwt("/lua/lwt", "offline", 0, 0)
m:on("offline", function(client) print ("offline") end)

m:on("connect", function(m) 
  print ("connected")
  m:publish("/lua/topic", "1", 2, 1)

  m:subscribe("topic", 0, function(m) 
    print("sub done") 
  end)
end)

m:connect("139.59.191.252", 8883, 1)

m:on("message", function(client, topic, data) 
  print(topic) 
  if data ~= nil then
    print(data)
  end
end)