wifi.setmode(wifi.SOFTAP)
cfg = {}
cfg.ssid="ALARM_MOD_V2"
cfg.pwd="123456789"
wifi.ap.config(cfg)

server = net.createServer(net.TCP, 30)

function receiver(sck, data)
  -- print(string.match(data, '{.*}'))
  jsonData = string.match(data, '{.*}')
  t = sjson.decode(jsonData)
  for key, value in pairs(t) do 
    if key == "ssid" then
      ssid = value
    end
    if key == "pass" then
      password = value
    end
    if key == "hash" then
      hash = value
    end
  end
  sck:close()
  print(ssid)
  print(password)
  print(hash)
end

if server then
  server:listen(80, function(conn)
    conn:on("receive", receiver)
    conn:send("hello world")
  end)
end