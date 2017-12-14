server = net.createServer(net.TCP, 3) 
server:listen(80,function(conn) 
    conn:on("receive", function(conn, data) 
        print(string.match(data, '{.*}')) 
        conn:send("<h1> Hello, NodeMcu.</h1>")
        conn:send("<h1> Hello, NodeMcu.</h1>")
        conn:send("<h1> Hello, NodeMcu.</h1>")
    end)
    conn:on("sent", function (c) c:close() end)
end)


-----------------------


server = net.createServer(net.TCP, 30)

function receiver(sck, data)
  print(string.match(data, '{.*}'))
  sck:close()
end

if server then
  server:listen(80, function(conn)
    conn:on("receive", receiver)
    conn:send("hello world")
  end)
end