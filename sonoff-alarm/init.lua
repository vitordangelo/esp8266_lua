wifi.setmode(wifi.STATION)
wifi_config = {}
wifi_config.ssid=ssid
wifi_config.pwd=password
wifi.sta.config(wifi_config)
print("Mode Wifi: Station")