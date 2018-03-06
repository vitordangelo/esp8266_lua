file.remove("init.lua");
file.open("init.lua","w+");
w = file.writeline
w([==[sntp.sync("224.0.1.1",]==]);
w([==[  function(sec, usec, server, info)]==]);
w([==[    print('sync', sec, usec, server)]==]);
w([==[  end,]==]);
w([==[  function()]==]);
w([==[   print('failed!')]==]);
w([==[  end]==]);
w([==[)]==]);
file.close();
dofile("init.lua");
