local module = {}

m = nil

local function blink()
    if (gpio.read(config.LED) == 1) then gpio.write(config.LED, gpio.HIGH) end
    gpio.write(config.LED, gpio.LOW)
    tmr.alarm(1, 500, 0, function() gpio.write(config.LED, gpio.HIGH) end)
end

local function publishMessage()
    if (gpio.read(config.RELAY) == 0) then
        m:publish(config.MQTT_TOPIC .. config.ID .. "/state", "OFF", 0, 0)
    else
        m:publish(config.MQTT_TOPIC .. config.ID .. "/state", "ON", 0, 0)
    end
end

local function getDefault()
    m:publish(config.MQTT_TOPIC .. config.ID .. "/get", "defaultState", 0, 0)
    blink()
    print("Ready")
    print("====================================")
end

local function setON()
    gpio.write(config.RELAY, gpio.HIGH)
    publishMessage()
end

local function setOFF()
    gpio.write(config.RELAY, gpio.LOW)
    publishMessage()
end

local function mqttSubsribe()
    m:subscribe(config.MQTT_TOPIC .. config.ID .. "/cmd", 0, function(c)
        getDefault()
    end)
end

local function mqttStart()
	m = mqtt.Client("Sonoff (ID=" .. config.ID .. ")", 180, config.MQTT_USER, config.MQTT_PASSWORD)

	m:lwt("/lwt", "Sonoff " .. config.ID, 0, 0)

	m:on("offline", function(c)
		ip = wifi.sta.getip()
		tmr.alarm(2, 5000, 0, function()
			node.restart();
		end)
	end)

	-- m:on("message", function(c, t, d)
	-- 	blink()
	-- 	if (d == "turnON") then
	-- 		setON()
	-- 	elseif (d == "turnOFF") then
	-- 		setOFF()
	-- 	elseif (d == "reportState") then
	-- 		publishMessage()
	-- 	end
	-- end)

	m:connect(config.MQTT_HOST, config.MQTT_PORT, 0, function(c)
		gpio.write(config.LED, gpio.HIGH)
		-- mqttSubsribe()
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