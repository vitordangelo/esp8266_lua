tmr.alarm(0, 1000, 1, function()
  uart.write(0, "Hello, world\n")
end)