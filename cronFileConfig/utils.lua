sntp.sync("a.st1.ntp.br",
  function(sec, usec, server, info)
    rtctime.set(sec - 7200)
    print('sync', sec, usec - 7200, server)
    scheduled()
  end,
  function()
   print('failed!')
  end
)

scheduled = function
  ()
  if file.open("scheduled") then
    while true do
      line = file.readline()
      
      if (line ~= nill) then
        t = sjson.decode(line)
    
        for key, value in pairs(t) do 
          if key == "scheduled" then
            print(value)
          end
          if key == "pin" then
            print(value)
          end
        end  

        else
          file.close()
          break
      end
    end
  end
end