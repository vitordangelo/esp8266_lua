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

return module