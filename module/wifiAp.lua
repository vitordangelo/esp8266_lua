wifi.setmode(wifi.SOFTAP)
cfg = {}
cfg.ssid="ALARM_MODULE"
cfg.pwd="12345678910"
wifi.ap.config(cfg)
print("Mode Wifi: AP")

parseJson = function (data)
  local ssid
  local password
  local hash

  t = sjson.decode(data)
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
  print(ssid)
  print(password)
  print(hash)
  if file.open("ssid.txt", "a+") then
    file.write(ssid)
    file.close()
  end
  if file.open("password.txt", "a+") then
    file.write(password)
    file.close()
  end
  if file.open("hash.txt", "a+") then
    file.write(hash)
    file.close()
  end
end

sv = net.createServer(net.TCP, 500)

sv:listen(80, function(conn)
  conn:on("receive", function(sck, data)
    print(string.match(data, '{.*}'))
    parseJson(string.match(data, '{.*}'))
    -- sck:send("HTTP/1.0 200 OK\r\nServer: NodeMCU on ESP8266\r\nhash: .. node.chipid() ..\r\nContent-Type: text/html\r\n\r\n<h1>" .. node.chipid() .. "</h1>")
    sck:send("HTTP/1.0 200 OK\r\nServer: NodeMCU on ESP8266\r\nhash: .. node.chipid() ..\r\nContent-Type: application/json\r\n\r\n{hash:" .. node.chipid() .. "}")
  end)
  conn:on("sent", function(sck) sck:close() end)
  
  tmr.alarm(1, 5000, 0, function()
    if (file.exists("ssid.txt")) then
      node.restart()
    end
  end)
end)