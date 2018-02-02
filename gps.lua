-- uart.setup(0, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1)
uart.on("data","\n",function(data)
  if (string.sub(data, 2, 6) == "GPRMC") then
    print(data)
    -- print("Hora: ", string.sub(data, 8, 13))
    local hora = string.sub(data, 8, 9)
    local minutos = string.sub(data, 10, 11)
    local segundos = string.sub(data, 12, 13)
    -- print(hora .. ":" .. minutos .. ":" .. segundos)

    local latGP = tonumber(string.sub(data, 21, 22))
    local latGP1 = string.sub(data, 23, 29)
    print(latGP .. "|" .. latGP1)

    print(type(latGP1))
    print(tonumber(latGP1))
    print(tonumber(latGP1) / 1000)

    -- local latGP1Part1 = string.sub(latGP1, 1, 2)
    -- local latGP1Part2 = string.sub(latGP1, 4, 7)
    -- local latGPAdjusted = latGP1Part1 .. latGP1Part2

    -- print(tonumber(latGPAdjusted)/1000)

    -- local divided = tonumber(latGPAdjusted / 60)
    -- print(latGP + divided)

  end
end, 0)

-- receive from uart:	$GPRMC,132039.000,A,2215.3513,S,04541.7069,W,0.34,196.16,310118,,,A*63
-- 3731.9404  ----> 37 + 31.9404/60 = 37.53234 degrees
-- 10601.6986 ---> 106+1.6986/60 = 106.02831 degrees

-- 2215.662 ----> 22 + 15.662/60 = 22.2610