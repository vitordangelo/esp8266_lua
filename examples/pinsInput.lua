gpio.mode(3, gpio.INPUT, gpio.PULLUP)

tmr.alarm(0, 100, 1, function()
  if (gpio.read(3) == 0) then
    print("Disparar Alarme")
  end
end)
