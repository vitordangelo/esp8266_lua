tmr.alarm(idTimerReset, 1000, 1, function()
  if (gpio.read(btnReset) == 1) then
    file.remove("ssid.txt")
    file.remove("password.txt")
    print("Reseting...")
  end
end)