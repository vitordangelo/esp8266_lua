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

return module