timerIdConfigAp = 0
ledState = 0
ledBoardSmall = 0

gpio.mode(ledBoardSmall, gpio.OUTPUT)

apMode = function
  () 
  wifi.setmode(wifi.SOFTAP)
  cfg = {}
  cfg.ssid="ALARM_MOD_V2"
  cfg.pwd="123456789"
  wifi.ap.config(cfg)
  print("Wifi mode: 1 - wifi.STATION, 2 - wifi.SOFTAP")
  print(wifi.getmode())

  tmr.alarm(timerIdConfigAp, 300, 1, function()
    ledState = 1 - ledState;
    gpio.write(ledBoardSmall, ledState)
  end)
end

if file.open("password") then
  print(file.read())
  file.close()
else
  print("Password File not found...")
end

if file.open("ssid") then
  print(file.read())
  file.close()
else
  print("SSID File not found...")
  print("AP Mode Initializing...")
  apMode()
end
