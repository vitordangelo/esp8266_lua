sntp.sync("a.st1.ntp.br",
  function(sec, usec, server, info)
    rtctime.set(sec - 7200)
    print('sync', sec, usec - 7200, server)
  end,
  function()
   print('failed!')
  end
)