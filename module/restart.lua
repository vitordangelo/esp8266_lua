tmr.alarm(idTimerRestart, 60000, 1, function()
  if(wifi.sta.getip() == nil and wifi.ap.getip() == nil) then
    node.restart()
    print("Restarting... - restart.lua")
  end
end)