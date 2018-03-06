gpio.mode(0, gpio.INPUT, gpio.PULLUP)
gpio.mode(1, gpio.INPUT, gpio.PULLUP)
gpio.mode(2, gpio.INPUT, gpio.PULLUP)
gpio.mode(3, gpio.INPUT, gpio.PULLUP)
gpio.mode(4, gpio.OUTPUT)
gpio.mode(5, gpio.OUTPUT)
gpio.mode(6, gpio.OUTPUT)
gpio.mode(7, gpio.OUTPUT)
gpio.mode(8, gpio.OUTPUT)
ledState = 0

tmr.alarm(1, 1000, 1, function()
  ledState = 1 - ledState;
  gpio.write(4, ledState)
  gpio.write(5, ledState)
  gpio.write(6, ledState)
  gpio.write(7, ledState)
  gpio.write(8, ledState)
end)

tmr.alarm(0, 100, 1, function()
  if (gpio.read(0) == 0) then
    print("Buttom 0")
  end
  if (gpio.read(1) == 0) then
    print("Buttom 1")
  end
  if (gpio.read(2) == 0) then
    print("Buttom 2")
  end
  if (gpio.read(3) == 0) then
    print("Buttom 3")
  end
end)