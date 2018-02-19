sntp.sync("a.st1.ntp.br",
  function(sec, usec, server, info)
    rtctime.set(sec - 7200)
    -- print('sync', sec, usec - 7200, server)
    scheduled()
  end,
  function()
   print('failed!')
  end
)

scheduled = function
  ()
  if file.open("scheduled") then
    while (file.readline() ~= nill) do
      line = file.readline()
      print(line)
    end
  end
end