uart.setup(0, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1)
uart.on("data","\n",function(data)
  if (string.sub(data, 2, 6) == "GPRMC") then
    print(data)
    -- print("Hora: ", string.sub(data, 8, 13))
    local hora = string.sub(data, 8, 9)
    local minutos = string.sub(data, 10, 11)
    local segundos = string.sub(data, 12, 13)
    -- print(hora .. ":" .. minutos .. ":" .. segundos)

    local latGP = string.sub(data, 21, 22)
    local latGP1 = string.sub(data, 23, 29)
    local num1 = tonumber(latGP)
    local num2 = tonumber(latGP1)
    print(num1)
    print(num2)
    print(type(num1))
    print(type(num2))
  end
end, 0)

-- receive from uart:	$GPRMC,132039.000,A,2215.3513,S,04541.7069,W,0.34,196.16,310118,,,A*63
-- 3731.9404  ----> 37 + 31.9404/60 = 37.53234 degrees
-- 10601.6986 ---> 106+1.6986/60 = 106.02831 degrees