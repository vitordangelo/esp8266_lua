gpio.mode(3, gpio.INPUT, gpio.PULLUP)

buttonPressed = false

gpio.trig(3, "down", function(L)
  if (buttonPressed == false) then
    buttonPressed = true
    tmr.alarm(3, 250, 0, function() buttonPressed = false; end)
    print("oi")
  end
end)