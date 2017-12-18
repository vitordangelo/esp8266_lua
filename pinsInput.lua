gpio.mode(1, gpio.INPUT, gpio.PULLUP)
gpio.mode(2, gpio.INPUT)
gpio.mode(3, gpio.INPUT)
gpio.mode(4, gpio.INPUT)
gpio.mode(5, gpio.INPUT)
gpio.mode(6, gpio.INPUT)
gpio.mode(7, gpio.INPUT)
gpio.mode(8, gpio.INPUT)
ledState = 0

tmr.alarm(0, 100, 1, function()
  if (gpio.read(1) == 0) then
    print("Hello")
  end
end)
