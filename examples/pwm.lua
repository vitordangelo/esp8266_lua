duty = 0
crenscent = true
decrescent = false

pwm.setup(4, 500, 512)
pwm.start(4)
  
tmr.alarm(1, 5, 1, function()
  if crenscent then
    duty = duty + 1
    pwm.setduty(4, duty)
    if duty == 1020 then
      crenscent = false
      decrescent = true
    end
  end

  if decrescent then
    duty = duty - 1
    pwm.setduty(4, duty)
    if duty == 0 then
      crenscent = true
      decrescent = false
    end
  end
end)