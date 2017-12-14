parseJson = function (data)
  local ssid
  local password

  t = sjson.decode(data)
  for key, value in pairs(t) do 
      if key == "ssid" then
        ssid = value
      end
      if key == "password" then
        password = value
      end
  end  
  print(ssid)
  print(password)
end


server = net.createServer(net.TCP, 30)
function receiver(sck, data)
  --print(string.match(data, '{.*}'))
  parseJson(string.match(data, '{.*}'))
  sck:close()
end

if server then
  server:listen(80, function(conn)
    conn:on("receive", receiver)
    conn:send("vulpi")
  end)
end