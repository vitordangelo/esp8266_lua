if file.exists("ssid.txt") then
  config = require("config")
  setup = require("setup")
  utils = require("utils")
  app = require("app")

  setup.start()
  else
    dofile("wifiAp.lua")
end