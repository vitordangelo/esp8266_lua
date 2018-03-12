tls.cert.verify(server)

m = mqtt.Client("clientid", 120, "app", "vitor123")
m:lwt("/lua/lwt", "offline", 0, 0)

m:on("connect", function(client) print ("connected") end)
m:on("offline", function(client) print ("offline") end)

m:connect("192.168.1.116", 8883, 1, function(client)
  print("connected")
  
  client:subscribe("/lua/topic", 0, function(client) print("subscribe success") end)
  client:publish("teste", "hello", 0, 0, function(client) print("sent") end)
end,
function(client, reason)
  print("failed reason: " .. reason)
end)