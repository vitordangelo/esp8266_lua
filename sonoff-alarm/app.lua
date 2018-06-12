local module = {}

alarmArmDisarm = false
m = nil
control = true

-- local function inputWatch()
-- 	tmr.alarm(6, 250, 1, function()
-- 		if ((gpio.read(config.ZONE3) == 0) and alarmArmDisarm == true) then
-- 			utils.triggerAlarm()
-- 			utils.triggerAlarmLed()
-- 		end
-- 	end)
-- end

tmr.alarm(6, 250, 1, function()
	if ((gpio.read(config.ZONE1) == 0) and alarmArmDisarm == true and control == true) then
		utils.triggerAlarm()
		utils.triggerAlarmLed()
		print('Zona 1')
		m:publish(config.TOPIC_TRIGGER, "1", 2, 1)
		m:publish(config.TOPIC_ZONE1, "1", 2, 1)
		control = false
	end

	if ((gpio.read(config.ZONE2) == 0) and alarmArmDisarm == true and control == true) then
		utils.triggerAlarm()
		utils.triggerAlarmLed()
		print('Zona 2')
		m:publish(config.TOPIC_TRIGGER, "1", 2, 1)
		m:publish(config.TOPIC_ZONE2, "1", 2, 1)
		control = false
	end

	if ((gpio.read(config.ZONE3) == 0) and alarmArmDisarm == true and control == true) then
		utils.triggerAlarm()
		utils.triggerAlarmLed()
		print('Zona 3')
		m:publish(config.TOPIC_TRIGGER, "1", 2, 1)
		m:publish(config.TOPIC_ZONE3, "1", 2, 1)
		control = false
	end
end)

local function mqttSubsribe()
	m:subscribe({[config.TOPIC_SIREN]=0, [config.TOPIC_ARM_DISARM_ALARM]=0}, 
		0, function(m) print("Subscribed...") 
	end)
end

local function mqttStart()
	m = mqtt.Client(config.ID, 10, config.MQTT_USER, config.MQTT_PASSWORD)

	m:lwt(config.TOPIC_STATUS_DEVICE, "0", 2, 1)

	m:on("offline", function(c)
		tmr.alarm(2, 5000, 0, function()
			node.restart();
		end)
	end)

	m:on("message", function(client, topic, data) 
		if data ~= nil then
			-- print("Data: "..data)
			-- print("Topic: "..topic)
			if (topic == config.TOPIC_ARM_DISARM_ALARM) then
				if (data == "0") then
					alarmArmDisarm = false
					utils.twoBeepSiren()
					utils.ledAlarmDisarmed()
					utils.offSiren()
					m:publish(config.TOPIC_TRIGGER, "0", 2, 1)
					m:publish(config.TOPIC_ZONE1, "0", 2, 1)
					m:publish(config.TOPIC_ZONE2, "0", 2, 1)
					m:publish(config.TOPIC_ZONE3, "0", 2, 1)
				end
				if (data == "1") then
					alarmArmDisarm = true
					utils.oneBeepSiren()
					utils.ledAlarmArmed()
					control = true
				end
			end
		end
	end)

	m:connect(config.MQTT_HOST, config.MQTT_PORT, 0, function(c)
		print("Conecting to broker...")
		mqttSubsribe()
		m:publish(config.TOPIC_STATUS_DEVICE, "1", 2, 1)
		m:publish(config.TOPIC_STRENGTH_WIFI, utils.wifiPercent(), 2, 1)
	end)
end

function module.start()
  gpio.mode(config.RELAY, gpio.OUTPUT)
  gpio.mode(config.LED, gpio.OUTPUT)
  gpio.write(config.LED, gpio.LOW)
  gpio.mode(config.BUTTON, gpio.INPUT, gpio.PULLUP)
  gpio.mode(config.ZONE1, gpio.INPUT, gpio.PULLUP)
  gpio.mode(config.ZONE2, gpio.INPUT, gpio.PULLUP)
  gpio.mode(config.ZONE3, gpio.INPUT, gpio.PULLUP)

  mqttStart()

  buttonPressed = false
  buttonTimer = 0
  longPressTime = 5000000
  
  gpio.trig(config.BUTTON, "down", function(L)
    if (buttonPressed == false) then
      buttonPressed = true
      tmr.alarm(3, 250, 0, function() buttonPressed = false; end)
			print("Desligar Sirene")
			utils.offSiren()
			utils.ledAlarmDisarmed()
			buttonTimer = tmr.now()
			alarmArmDisarm = false
			print(buttonTimer)
			m:publish(config.TOPIC_TRIGGER, "0", 2, 1)
    end
	end)
	
	tmr.alarm(4, 100, 1, function()
		if ((tmr.now() - buttonTimer > longPressTime) and gpio.read(config.BUTTON) == 0) then
			print("Resetar")
			utils.reset()
		end
	end)
	utils.ledAlarmDisarmed()
end

return module