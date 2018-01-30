i2c.setup(0, 1, 2, i2c.SLOW)
lcd = dofile("lcd1602.lua")()
lcd:put(lcd:locate(0, 0), "Samia e Vitor!")
lcd:put(lcd:locate(1, 0), "Te amo!")


-- i2c.setup(0, 1, 2, i2c.SLOW)
-- lcd = dofile("lcd1602.lua")()
-- lcd:run(0, 0, 16, "Vitor Ivan DAngelo", 300, 1)