ledSiren = 0
sensor1 = 1
sensor2 = 2
siren = 3
output1 = 4
output2 = 5
idTimersensorAlarm = 3

gpio.mode(sensor1, gpio.INPUT, gpio.PULLUP)
gpio.mode(sensor2, gpio.INPUT, gpio.PULLUP)
gpio.mode(ledSiren, gpio.OUTPUT)
gpio.mode(4, gpio.OUTPUT)
ledState = 0
ledD2State = 0

m = mqtt.Client("21b2d1b0416b9367f0ffb8b3c413d39a", 5)
m:lwt("/lua/lwt", "disconnected", 0, 0)

m:on("connect",function(m) 
  print("connection ") 
  m:subscribe("/topic1",0,function(m) print("sub done") end)
end )

m:on("offline", function(conn)
  print("disconnect to broker...")
end)

m:connect("v2alarm.ddns.net",1883,0,0)

m:on("message", function(client, topic, data) 
  if data ~= nil then
    print(data)
    if data == "hi" then
      print "hi!"
    end
    if data == "ledOn" then
      ledOn()
    end
    if data == "ledOff" then
      ledOff()
    end
  end
end)

-- tmr.alarm(0, 100, 1, function()
--   if (gpio.read(1) == 0) then
--     ledState = 1 - ledState;
--     gpio.write(0, ledState)
--   else 
--     gpio.write(0, 1)
--   end
-- end)

tmr.alarm(1, 1000, 1, function()
  ledD2State = 1 - ledD2State;
  gpio.write(4, ledD2State)
  m:publish("/lua/topic", tostring(ledD2State), 0, 0)
end)

ledOn = function 
  ()
  tmr.alarm(0, 100, 1, function()
    ledState = 1 - ledState;
    gpio.write(ledSiren, ledState)
  end)
end

ledOff = function 
  ()
  tmr.unregister(0)
  gpio.write(ledSiren, 0)
end

sensorAlarm = function
  (n)
  tmr.alarm(idTimersensorAlarm, 100, 1, function()
    if (gpio.read(sensor1) == 0 or gpio.read(sensor2) == 0) then
      ledOn()
    end
  end)  
end

sensorAlarm()