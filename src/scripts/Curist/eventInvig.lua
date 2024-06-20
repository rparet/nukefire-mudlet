function eventInvig(_, profileName)
  if msdp.CLASS == "Knight" then
    return
  end

  display("Caught event invig from " .. profileName)

  if msdp.CLASS == "Curist" then
    send("sling 'invig' " .. profileName)
    send("sling 'invig' " .. profileName)
  elseif msdp.CLASS == "Heretic" then
    send("sling 'sinful vigor' " .. profileName)
    send("sling 'sinful vigor' " .. profileName)
  end
end
