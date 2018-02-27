wifi.setmode(wifi.STATION)
wifi_config = {}
wifi_config.ssid="DVRTESTE"
wifi_config.pwd="v2techwifi"
wifi.sta.config(wifi_config)

tmr.alarm(1, 10000, 0, function()
  print(wifi.sta.getip())
  -- dofile("utils.lua")
  
  sntp.sync("a.st1.ntp.br",
  function(sec, usec, server, info)
    rtctime.set(sec - 7200)
  end,
  function()
   print('failed!')
  end
)
end)

