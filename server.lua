srv=net.createServer(net.TCP,3) 
srv:listen(80,function(conn) 
    conn:on("receive",function(conn,payload) 
    print(payload) 
    conn:send("<h1> Hello, NodeMcu.</h1>")
    end)
    conn:on("sent", function (c) c:close() end) --close the socket after succesfully flushed data
end)