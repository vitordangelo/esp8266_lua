--Input
sensor1 = 1
sensor2 = 2
btnReset = 7
gpio.mode(sensor1, gpio.INPUT, gpio.PULLUP)
gpio.mode(sensor2, gpio.INPUT, gpio.PULLUP)
gpio.mode(btnReset, gpio.INPUT, gpio.PULLUP)

--Output
ledSiren = 0
siren = 3
output2 = 5
output1 = 7
gpio.mode(ledSiren, gpio.OUTPUT)
gpio.mode(siren, gpio.OUTPUT)
gpio.mode(output2, gpio.OUTPUT)
gpio.mode(output1, gpio.OUTPUT)

--Variables Control
ledState = 0
ledD2State = 0
hash = node.chipid()

--Timers
idTimersensorAlarm = 3