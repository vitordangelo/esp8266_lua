if file.exists("ssid.txt") then
  if file.open("ssid.txt") then
    ssid = file.read()
    file.close()
  end
  if file.open("password.txt") then
    password = file.read()
    file.close()
  end

  wifi.setmode(wifi.STATION)
  wifi_config = {}
  wifi_config.ssid=ssid
  wifi_config.pwd=password
  wifi.sta.config(wifi_config)
  print("Mode Wifi: Station")

  tmr.alarm(1, 10000, 0, function()
    print(wifi.sta.getip())
    dofile("vars.lua")
    dofile("app.lua")
  end)

  else
    dofile("wifiAp.lua")
end