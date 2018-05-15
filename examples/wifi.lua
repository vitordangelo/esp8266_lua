wifi.setmode(wifi.STATION)
wifi_config = {}
wifi_config.ssid="V2Tech"
wifi_config.pwd="v2techwifi"
wifi.sta.config(wifi_config)

tmr.alarm(1, 10000, 0, function()
  print(wifi.sta.getip())
end)