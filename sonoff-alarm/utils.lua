local module =  {}

function module.oneBeepSiren()
  print("Alarme armado")
  gpio.write(config.RELAY, 1)
  tmr.delay(50000)
  gpio.write(config.RELAY, 0)
end

function module.twoBeepSiren()
  print("Alarme desarmado")
  gpio.write(config.RELAY, 1)
  tmr.delay(50000)
  gpio.write(config.RELAY, 0)
  tmr.delay(150000)
  print("Alarme desarmado")
  gpio.write(config.RELAY, 1)
  tmr.delay(50000)
  gpio.write(config.RELAY, 0)
end

function module.triggerAlarm()
  sirenState = 0
  tmr.alarm(5, 1000, 1, function()
    sirenState = 1 - sirenState
    gpio.write(config.RELAY, sirenState)
  end)
end

function module.offSiren()
  tmr.stop(5)
  gpio.write(config.RELAY, 0)
end

function module.ledAlarmArmed()
  ledState = 0
  tmr.alarm(2, 500, 1, function()
    ledState = 1 - ledState
    gpio.write(config.LED, ledState)
  end)
end

function module.ledAlarmDisarmed()
  ledState = 0
  tmr.alarm(2, 2000, 1, function()
    ledState = 1 - ledState
    gpio.write(config.LED, ledState)
  end)
end

function module.triggerAlarmLed()
  ledState = 0
  tmr.alarm(2, 100, 1, function()
    ledState = 1 - ledState
    gpio.write(config.LED, ledState)
  end)
end

function module.reset()
  file.remove("ssid.txt")
  file.remove("password.txt")
  print("Reseting...")
end

return module