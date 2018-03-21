timerId = 3
dly = 2000
ledPin = 4
gpio.mode(ledPin,gpio.OUTPUT)
ledState = 0
ctrl = 0

tmr.alarm(timerId, dly, 1, function()
  ledState = 1 - ledState;
  gpio.write(ledPin, ledState)
  ctrl = ctrl + 1
  -- print(ctrl)
end)

-- tmr.alarm(1, 5000, 0, function()
--   print(ctrl)
--   tmr.unregister(0)
-- end)
