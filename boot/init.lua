if file.exists("ssid.txt") then
  wifi.setmode(wifi.STATION)
  wifi_config = {}
  wifi_config.ssid="DVRTESTE"
  wifi_config.pwd="v2techwifi"
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