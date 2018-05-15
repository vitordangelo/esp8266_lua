gpio.mode(7, gpio.INPUT, gpio.PULLUP)

tmr.alarm(0, 100, 1, function()
  if (gpio.read(7) == 0) then
    print("Disparar Alarme")
  end
end)
