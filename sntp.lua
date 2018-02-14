sntp.sync("200.160.7.186",
  function(sec, usec, server, info)
    print('sync', sec, usec, server)
  end,
  function()
   print('failed!')
  end
)