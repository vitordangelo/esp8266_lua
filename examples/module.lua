ledSiren = 4
btnReset = 3
sensor1 = 1
sensor2 = 2
siren = 8
output1 = 7
output2 = 5

idTimersensorAlarm = 3

gpio.mode(sensor1, gpio.INPUT, gpio.PULLUP)
gpio.mode(sensor2, gpio.INPUT, gpio.PULLUP)
gpio.mode(ledSiren, gpio.OUTPUT)
gpio.mode(output1, gpio.OUTPUT)
gpio.mode(output2, gpio.OUTPUT)
gpio.mode(siren, gpio.OUTPUT)
gpio.mode(btnReset, gpio.INPUT, gpio.PULLUP)

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
    if data == "triggerOn" then
      triggerOn()
    end
    if data == "triggerOff" then
      triggerOff()
    end
    if data == "output1On" then
      output1Active()
    end
    if data == "output1Off" then
      output1Desacive()
    end
    if data == "output2On" then
      output2Active()
    end
    if data == "output2Off" then
      output2Desacive()
    end
  end
end)

tmr.alarm(1, 1000, 1, function()
  ledD2State = 1 - ledD2State;
  gpio.write(4, ledD2State)
  m:publish("/lua/topic", tostring(ledD2State), 0, 0)
end)

triggerOn = function 
  ()
  tmr.alarm(0, 100, 1, function()
    ledState = 1 - ledState;
    gpio.write(ledSiren, ledState)
  end)
  gpio.write(siren, 1)
end

triggerOff = function 
  ()
  tmr.unregister(0)
  gpio.write(ledSiren, 0)
  gpio.write(siren, 0)
end

sensorAlarm = function
  (n)
  tmr.alarm(idTimersensorAlarm, 100, 1, function()
    if (gpio.read(sensor1) == 0 or gpio.read(sensor2) == 0) then
      triggerOn()
      print("BTN PRESSED")
    end
  end)  
end

sensorAlarm()

output1Active = function
  (n)
  gpio.write(output1, 1)
end

output1Desacive = function
  (n)
  gpio.write(output1, 0)
end

output2Active = function
  (n)
  gpio.write(output2, 1)
end

output2Desacive = function
  (n)
  gpio.write(output2, 0)
end

if (gpio.read(btnReset) == 0) then
  print("Resetinnng")
  file.remove("ssid")
  file.remove("password")
  file.remove("hash")
end