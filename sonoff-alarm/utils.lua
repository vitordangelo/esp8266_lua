local module =  {}

function module.oneBeepSiren()
  print("Alarme armado")
  gpio.write(config.RELAY, 1)
  tmr.delay(100000)
  gpio.write(config.RELAY, 0)
end

function module.twoBeepSiren()
  print("Alarme desarmado")
  gpio.write(config.RELAY, 1)
  tmr.delay(100000)
  gpio.write(config.RELAY, 0)
  tmr.delay(2000000)
  print("Alarme desarmado")
  gpio.write(config.RELAY, 1)
  tmr.delay(100000)
  gpio.write(config.RELAY, 0)
end

return module