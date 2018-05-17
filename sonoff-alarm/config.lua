local module = {}

module.ID = node.chipid()

module.WIFI_SSID = "V2Tech"
module.WIFI_PASSWORD = "v2techwifi"

module.MQTT_HOST = "v2alarm.ddns.net"
module.MQTT_PORT = 1883
-- module.MQTT_USER = "user"
-- module.MQTT_PASSWORD = "password"
module.MQTT_TOPIC = "/sonoff/alarm/"

-- GPIO Configuration
module.BUTTON = 3
module.RELAY = 6
module.LED = 7
module.REEDSWITCH = 5

-- Topics
module.TOPIC_STATUS_DEVICE = "/sonoff/alarm/" .. node.chipid() .. "/status"
module.TOPIC_TRIGGER = "/sonoff/alarm/" .. node.chipid() .. "/trigger"
module.TOPIC_SIREN = "/sonoff/alarm/" .. node.chipid() .. "/siren"
module.TOPIC_ARM_DISARM_ALARM = "/sonoff/alarm/" .. node.chipid() .. "/arm_disarm"

return module