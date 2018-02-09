print("App...")
print(statusModuleTopic)
print(hash  )

m = mqtt.Client(hash, 10)
m:lwt(statusModuleTopic, "0", 0, 1)

m:on("connect",function(m) 
  print("Connecting to broker... ") 
  m:subscribe({[statusArmDisarmCentralAlarmTopic]=0, [timerRelayTimedTopic]=0}, 
    0, function(m) print("sub done") 
  end)
  
  m:publish(statusModuleTopic, "1", 0, 1)
  m:publish(statusRelayFixedTopic, "0", 0, 1)
  m:publish(statusRelayTimedTopic, "0", 0, 1)
  m:publish(statusTriggerTopic, "0", 0, 1)
  m:publish(statusCentralAlarmTopic, "0", 0, 1)
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
      if data == "0" then
        disarmCentralAlarm()
      end
      if data == "1" then
        armCentralAlarm()
      end
      if data == "3" then
        relayOutputFixedOn()
      end
      if data == "4" then
        relayOutputFixedOff()
      end
    end

    if (topic == timerRelayTimedTopic) then
      print("Relay Timed On")
      gpio.write(relayTimedOutput, 1)
      m:publish(statusRelayTimedTopic, "1", 0, 1)
      tmr.alarm(idTimerRelayTimer, data, 0, function()
        gpio.write(relayTimedOutput, 0)
        m:publish(statusRelayTimedTopic, "0", 0, 1)
        print("Relay Timed Off")
      end)
    end
  end
end)

relayOutputFixedOn = function 
  ()
  gpio.write(relayOutput, 1)
  m:publish(statusRelayFixedTopic, "1", 0, 1)
  print("relayOutputFixedOn")
end

relayOutputFixedOff = function 
  ()
  gpio.write(relayOutput, 0)
  m:publish(statusRelayFixedTopic, "0", 0, 1)
  print("relayOutputFixedOff")
end

armCentralAlarm = function 
  ()
  gpio.write(armDisarmOutput, 1)
  print("armCentralAlarm")
end

disarmCentralAlarm = function 
  ()
  gpio.write(armDisarmOutput, 0)
  print("disarmCentralAlarm")
end

tmr.alarm(idTimerCentralAlarmTrigger, 1000, 1, function()
  alarmTrigger = gpio.read(centralAlarmTrigger)
  if (alarmTrigger ~= alarmTriggerChanged) then
    m:publish(statusTriggerTopic, alarmTrigger, 0, 1)
    print("alarmTrigger: " .. alarmTrigger)
    alarmTriggerChanged = alarmTrigger
  end
end)

tmr.alarm(idTimerCentralAlarmState, 1000, 1, function()
  centralAlarmState = gpio.read(centralAlarmStateInput)
  if (centralAlarmState ~= centralAlarmStateChanged) then
    m:publish(statusCentralAlarmTopic, centralAlarmState, 0, 1)
    print("centralAlarmState " .. centralAlarmState)
    centralAlarmStateChanged = centralAlarmState
  end
end)