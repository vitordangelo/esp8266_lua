function scheduled()
  if file.open("scheduled.txt") then
    -- while (file.readline() ~= nill) do
    --   line = file.readline()
    --   print(line)
    -- end
    while 1 do
      line = file.readline()
      print(line)

      if(file.readline() == nil) then
        break
      end

    end
  end
end

scheduled()