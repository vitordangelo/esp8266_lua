print("Sonoff")
print(hash)

m = mqtt.Client(hash, 10)
m:lwt(statusModuleTopic, "0", 0, 1)

m:on("connect",function(m) 
  print("Connecting to broker... ") 
  m:subscribe({[statusArmDisarmCentralAlarmTopic]=0}, 
    0, function(m) print("sub done") 
  end)
  
  m:publish(statusModuleTopic, "1", 2, 1)
  m:publish(statusRelayFixedTopic, "0", 2, 1)
  m:publish(statusRelayTimedTopic, "0", 2, 1)
  m:publish(statusTriggerTopic, "0", 2, 1)
  m:publish(statusCentralAlarmTopic, "0", 2, 1)
  m:publish(timerTempTopic, "1000", 2, 1)
end )

m:on("offline", function(conn)
  print("Disconnect to broker...")
  print("Will restart...")
  node.restart()
end)

m:connect("v2alarm.ddns.net",1883,0,0)

m:on("message", function(client, topic, data) 
  if data ~= nil then
    if (topic == statusArmDisarmCentralAlarmTopic) then
      print(data)
      if data == "3" then
        relayOutputFixedOn()
      end
      if data == "4" then
        relayOutputFixedOff()
      end
    end
  end
end)

relayOutputFixedOn = function 
  ()
  gpio.write(relayOutput, 1)
  m:publish(statusRelayFixedTopic, "1", 2, 1)
  print("relayOutputFixedOn")
end

relayOutputFixedOff = function 
  ()
  gpio.write(relayOutput, 0)
  m:publish(statusRelayFixedTopic, "0", 2, 1)
  print("relayOutputFixedOff")
end