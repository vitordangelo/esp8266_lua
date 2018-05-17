local module = {}

m = nil

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
					utils.twoBeepSiren()
				end
				if (data == "1") then
					utils.oneBeepSiren()
				end
			end
		end
	end)

	m:connect(config.MQTT_HOST, config.MQTT_PORT, 0, function(c)
		print("Conecting to broker...")
		mqttSubsribe()
		m:publish(config.TOPIC_STATUS_DEVICE, "1", 2, 1)
	end)
end

function module.start()
  gpio.mode(config.RELAY, gpio.OUTPUT)
  gpio.mode(config.LED, gpio.OUTPUT)
  gpio.write(config.LED, gpio.HIGH)
  gpio.mode(config.BUTTON, gpio.INPUT, gpio.PULLUP)
  gpio.mode(config.REEDSWITCH, gpio.INPUT, gpio.PULLUP)

  mqttStart()

  buttonPressed = false
  buttonTimer = 0
  longPressTime = 10000000
  
  gpio.trig(config.BUTTON, "down", function(L)
    if (buttonPressed == false) then
      buttonPressed = true
      tmr.alarm(3, 250, 0, function() buttonPressed = false; end)
      print("Desligar Sirene")
			buttonTimer = tmr.now()
			print(buttonTimer)
    end
	end)
	
	tmr.alarm(4, 100, 1, function()
		if ((tmr.now() - buttonTimer > longPressTime) and gpio.read(config.BUTTON) == 0) then
			print("Resetar")
		end
	end)

end

return module