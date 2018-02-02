gpio.mode(4, gpio.OUTPUT)

topic1 = "lua/topic1"
topic2 = "lua/topic2"
topic3 = "lua/topic3"

m = mqtt.Client(node.chipid(), 5)
m:lwt("lua/wt", "0", 0, 0)

m:on("connect",function(m) 
  print("Connected to broker... ") 
  m:subscribe({["lua/topic1"]=0, ["lua/topic2"]=0, ["lua/topic3"]=0}, 
    0, function(m) print("sub done") 
  end)
end )

m:on("offline", function(conn)
  print("Disconnect to broker...")
end)

m:connect("v2alarm.ddns.net",1883,0,0)

m:on("message", function(client, topic, data) 
  if data ~= nil then
    print(data)
    print(topic)

    if (topic == topic1) then
      print("Is topic 1")
    end
    if (topic == topic2) then
      print("Is topic 2")
    end
    if (topic == topic3) then
      print("Is topic 3")
    end

    -- gpio.write(4, 1)
    -- tmr.alarm(0, data, 0, function()
    --   gpio.write(4, 0)
    -- end)
  end
end)