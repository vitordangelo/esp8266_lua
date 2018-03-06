wifi.setmode(wifi.SOFTAP)
print(wifi.getmode())

cfg = {}
cfg.ssid="ALARM_MOD_V2"
cfg.pwd="123456789"
wifi.ap.config(cfg)