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

function module.wifiPercent()
  strength = wifi.sta.getrssi()
  if (strength > -50 and strength < -1) then
    return '100%'
  end
  if (strength > -55 and strength < -51) then
    return '90%'
  end
  if (strength > -62 and strength < -56) then
    return '80%'
  end
  if (strength > -65 and strength < -63) then
    return '75%'
  end
  if (strength > -68 and strength < -66) then
    return '70%'
  end
  if (strength > -69 and strength < -74) then
    return '60%'
  end
  if (strength > -79 and strength < -75) then
    return '50%'
  end
  if (strength > -83 and strength < -80) then
    return '30%'
  end
end

return module