--Input
centralAlarmStateInput = 2
gpio.mode(centralAlarmStateInput, gpio.INPUT, gpio.PULLUP)
centralAlarmTrigger = 1
gpio.mode(centralAlarmTrigger, gpio.INPUT, gpio.PULLUP)
btnReset = 3
gpio.mode(btnReset, gpio.INPUT, gpio.PULLUP)

--Output
relayTimedOutput = 4
gpio.mode(relayTimedOutput, gpio.OUTPUT)
relayOutput = 5
gpio.mode(relayOutput, gpio.OUTPUT)
armDisarmOutput = 6
gpio.mode(armDisarmOutput, gpio.OUTPUT)

--Variables Control
hash = node.chipid()
alarmTrigger = 0
alarmTriggerChanged = 0
centralAlarmState = 0
centralAlarmStateChanged = 0

--Timers
idTimerReset = 1
idTimerCentralAlarmState = 2
idTimerCentralAlarmTrigger = 3

--Topics
statusModuleTopic = "/lua/".. hash .."/state_alarm" 
statusCentralAlarmTopic = "/lua/".. hash .."/state" 
statusRelayFixedTopic = "/lua/".. hash .."/status_btn_fixed"
statusRelayTimedTopic = "/lua/".. hash .."/status_btn_temp"
statusArmDisarmCentralAlarmTopic = "/lua/".. hash .."/arm_disarm"
statusTriggerTopic = "/lua/".. hash .."/trigger_state"