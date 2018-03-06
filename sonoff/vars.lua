--Input
gpio.mode(3, gpio.INPUT, gpio.PULLUP)

--Output
relayOutput = 6
gpio.mode(relayOutput, gpio.OUTPUT)

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
idTimerRelayTimer = 4
idTimerRestart = 5

--Topics
statusModuleTopic = "v2tech/".. hash .."/state_alarm" 
statusCentralAlarmTopic = "v2tech/".. hash .."/state" 
statusRelayFixedTopic = "v2tech/".. hash .."/status_btn_fixed"
statusRelayTimedTopic = "v2tech/".. hash .."/status_btn_temp"
statusArmDisarmCentralAlarmTopic = "v2tech/".. hash .."/arm_disarm"
statusTriggerTopic = "v2tech/".. hash .."/trigger_state"
timerRelayTimedTopic = "v2tech/".. hash .."/timer_btn_temp"
timerTempTopic = "v2tech/".. hash .."/timer_temp"