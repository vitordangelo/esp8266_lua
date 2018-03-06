--Inputs
btnOption = 3
gpio.mode(btnOption, gpio.INPUT, gpio.PULLUP)

--Controlers
optionCtrl = 0

--Timers
tmrInput = 0
tmrCtrl = 1
tmrMain = 2

tmr.alarm(tmrInput, 100, 1, function()
  if (gpio.read(btnOption) == 0) then
    optionCtrl = optionCtrl + 1
  end
end)

tmr.alarm(tmrCtrl, 500, 1, function()
  if (optionCtrl ~= 0) then
    --print(optionCtrl)
  end
end)

tmr.alarm(tmrMain, 1000, 1, function()
  if (optionCtrl == 1) then
    optionCtrl = 0
    print("OP1")
  end
  if (optionCtrl == 2) then
    print("OP2")
    optionCtrl = 0
  end
  if (optionCtrl == 3) then
    print("OP3")
    optionCtrl = 0
  end
  if (optionCtrl == 4) then
    optionCtrl = 0
  end
end)