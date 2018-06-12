gpio.mode(5, gpio.INPUT, gpio.PULLUP)
gpio.mode(11, gpio.INPUT, gpio.PULLUP)
gpio.mode(12, gpio.INPUT, gpio.PULLUP)
gpio.mode(7, gpio.OUTPUT)

tmr.alarm(0, 100, 1, function()
  if (gpio.read(5) == 0 or gpio.read(11) == 0 or gpio.read(12) == 0) then
    gpio.write(7, 1)
  end
  if (gpio.read(5) == 1 or gpio.read(11) == 1 or gpio.read(12) == 1) then
    gpio.write(7, 0)
  end
  
end)
