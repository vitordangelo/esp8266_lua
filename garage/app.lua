m = mqtt.Client("21b2d1b0416b9367f0ffb8b3c413d39a", 5)
m:lwt("/lua/lwt", "disconnected", 0, 0)

m:on("connect",function(m) 
  print("Connected to broker... ") 
  m:subscribe("/topic1",0,function(m) print("sub done") end)
end )

m:on("offline", function(conn)
  print("Disconnect to broker...")
  print("Will restart...")
  node.restart()
end)

m:connect("v2alarm.ddns.net",1883,0,0)

m:on("message", function(client, topic, data) 
  if data ~= nil then
    print(data)
    if data == "activeAlarm" then
      activeAlarm()
    end
    if data == "desactiveAlarm" then
      desactiveAlarm()
    end
  end
end)

-- tmr.alarm(1, 1000, 1, function()
--   ledD2State = 1 - ledD2State;
--   gpio.write(ledStatus, ledD2State)
--   m:publish("/lua/topic", tostring(ledD2State), 0, 0)
-- end)

activeAlarm = function 
  ()
  tmr.alarm(timerActiveAlarm, 1000, 1, function()
    ledStatusAlarm = 1 - ledStatusAlarm;
    gpio.write(ledStatusAlarmPin, ledStatusAlarm)
  end)
  sensorPresence()
end

desactiveAlarm = function 
  ()
  tmr.unregister(timerActiveAlarm)
  tmr.unregister(timerSensorPresence)
  gpio.write(ledStatusAlarmPin, 0)
  gpio.write(sirenePin, 0)
end

sensorPresence = function
  ()
  tmr.alarm(timerSensorPresence, 100, 1, function()
    if (gpio.read(sensorPresencePin) == 0) then
      gpio.write(sirenePin, 1)
      gpio.write(ledStatusAlarmPin, 0)
      tmr.alarm(timerActiveAlarm, 100, 1, function()
        ledStatusAlarm = 1 - ledStatusAlarm;
        gpio.write(ledStatusAlarmPin, ledStatusAlarm)
      end)
    end
  end)
end