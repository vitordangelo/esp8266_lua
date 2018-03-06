sntp.sync("224.0.1.1",
  function(sec, usec, server, info)
    print('sync', sec, usec, server)
  end,
  function()
   print('failed!')
  end
)

cron.schedule("* * * * *", function(e)
  print("Every minute")
end)
