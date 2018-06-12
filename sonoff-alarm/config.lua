local module = {}

if file.exists("ssid.txt") then
  if file.open("ssid.txt") then
    ssid = file.read()
    file.close()
  end
  if file.open("password.txt") then
    password = file.read()
    file.close()
  end
end

module.ID = node.chipid()

module.WIFI_SSID = ssid
module.WIFI_PASSWORD = password

module.MQTT_HOST = "v2alarm.ddns.net"
module.MQTT_PORT = 1883
-- module.MQTT_USER = "user"
-- module.MQTT_PASSWORD = "password"
module.MQTT_TOPIC = "/sonoff/alarm/"

-- GPIO Configuration
module.BUTTON = 3
module.RELAY = 6
module.LED = 7
module.ZONE1 = 11
module.ZONE2 = 12
module.ZONE3 = 5

-- Topics
module.TOPIC_STATUS_DEVICE = "/sonoff/alarm/" .. node.chipid() .. "/status"
module.TOPIC_TRIGGER = "/sonoff/alarm/" .. node.chipid() .. "/trigger"
module.TOPIC_SIREN = "/sonoff/alarm/" .. node.chipid() .. "/siren"
module.TOPIC_ARM_DISARM_ALARM = "/sonoff/alarm/" .. node.chipid() .. "/arm_disarm"
module.TOPIC_STRENGTH_WIFI = "/sonoff/alarm/" .. node.chipid() .. "/strength_wifi"
module.TOPIC_ZONE1 = "/sonoff/alarm/" .. node.chipid() .. "/zone1"
module.TOPIC_ZONE2 = "/sonoff/alarm/" .. node.chipid() .. "/zone2"
module.TOPIC_ZONE3 = "/sonoff/alarm/" .. node.chipid() .. "/zone3"

return module