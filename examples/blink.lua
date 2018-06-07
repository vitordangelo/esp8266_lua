gpio.mode(9,gpio.OUTPUT)
gpio.mode(10,gpio.OUTPUT)
led1State = 0
led2State = 0

tmr.alarm(0, 1000, 1, function()
  led1State = 1 - led1State;
  gpio.write(9, led1State)
end)

tmr.alarm(1, 1000, 1, function()
  led2State = 1 - led2State;
  gpio.write(10, led2State)
end)
