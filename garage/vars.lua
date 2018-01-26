--Input
sensorPresencePin = 3
gpio.mode(sensorPresencePin, gpio.INPUT, gpio.PULLUP)

--Output
ledStatusAlarmPin = 4
gpio.mode(ledStatusAlarmPin, gpio.OUTPUT)
sirenePin = 5
gpio.mode(sirenePin, gpio.OUTPUT)
lamp = 8
gpio.mode(lamp, gpio.OUTPUT)

--Variables Control
ledStatusAlarm = 0
hash = node.chipid()
alarmActiveDesactive = 0

--Timers
timerActiveAlarm = 0
timerSensorPresence = 1