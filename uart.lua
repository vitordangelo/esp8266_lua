uart.setup(1, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1)
uart.on("data","\n",function(data) print("receive from uart:", data) end, 0)
