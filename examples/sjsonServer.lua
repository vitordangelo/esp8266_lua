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