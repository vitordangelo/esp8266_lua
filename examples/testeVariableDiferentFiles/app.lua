tmr.alarm(idTimersensorAlarm, 100, 1, function()
  if (gpio.read(sensor1) == 0) then
    print("PRESSIONASO")
  end
end)  