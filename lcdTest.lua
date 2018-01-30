i2c.setup(0, 3, 4, i2c.SLOW)
lcd = dofile("lcd1602.lua")()
lcd:put(lcd:locate(0, 5), "Hello, dvv!")