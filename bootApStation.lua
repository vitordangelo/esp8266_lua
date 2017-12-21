timerIdConfigAp = 0
ledState = 0

ledBoardSmall = 0
btnReset = 6

gpio.mode(ledBoardSmall, gpio.OUTPUT)
gpio.mode(btnReset, gpio.INPUT, gpio.PULLUP)

serverMode = function
  ()
  server = net.createServer(net.TCP, 30)

  function receiver(sck, data)
    jsonData = string.match(data, '{.*}')
    t = sjson.decode(jsonData)
    for key, value in pairs(t) do 
      if key == "ssid" then
        ssid = value
      end
      if key == "password" then
        password = value
      end
      if key == "hash" then
        hash = value
      end
    end
    sck:close()
    if file.open("ssid", "a+") then
      file.write(ssid)
      file.close()
    end
    if file.open("password", "a+") then
      file.write(password)
      file.close()
    end
    if file.open("hash", "a+") then
      file.write(hash)
      file.close()
    end
    node.restart()
  end

  if server then
    server:listen(80, function(conn)
      conn:on("receive", receiver)
      conn:send("hello world")
    end)
  end
end

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
  serverMode()
end

stationMode = function
  ()
  if file.open("ssid") then
    ssid = file.read()
    file.close()
  end
  if file.open("password") then
    password = file.read()
    file.close()
  end

  wifi.setmode(wifi.STATION)
  wifi_config = {}
  wifi_config.ssid=ssid
  wifi_config.pwd=password
  wifi.sta.config(wifi_config)

  tmr.alarm(timerIdConfigAp, 1000, 1, function()
    ledState = 1 - ledState;
    gpio.write(ledBoardSmall, ledState)
  end)

  tmr.alarm(1, 5000, 0, function()
    print(wifi.sta.getip())
  end)
end

if (gpio.read(btnReset) == 0) then
  file.remove("ssid")
  file.remove("password")
  file.remove("hash")
end

if file.open("password") and file.open("ssid") then
  stationMode()
  tmr.alarm(2, 10000, 0, function()
    print(wifi.sta.getip())
    dofile("module.lua")
  end)
else
  apMode()
end