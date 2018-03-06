wifi.setmode(wifi.STATION)
wifi_config = {}
wifi_config.ssid="DVRTESTE"
wifi_config.pwd="v2techwifi"
wifi.sta.config(wifi_config)

sv = net.createServer(net.TCP, 500)

sv:listen(80, function(conn)

  conn:on("receive", function(sck,payload)
    print(payload)
    sck:send("HTTP/1.0 200 OK\r\nServer: NodeMCU on ESP8266\r\nContent-Type: text/html\r\n\r\n<h1> Hello, NodeMCU.</h1>")
  end)
  conn:on("sent", function(sck) sck:close() end)
end)