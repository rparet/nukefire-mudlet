function eventInvig(_, profileName)
  if msdp.CLASS == "Knight" then
    return
  end

  local function invig()
    Nf.setFlag("invig", true)

    if Nf.profiles[profileName] and Nf.profiles[profileName]["move"] then
      local currentMove = Nf.profiles[profileName]["move"]
      if currentMove >= 95 then
        Nf.msg("Called invig for " .. profileName .. " but already near max.")
        Nf.setFlag("invig", false)
        return
      end
    end
    if msdp.CLASS == "Curist" then
      send("sling 'invig' " .. profileName)
      send("sling 'invig' " .. profileName)
    elseif msdp.CLASS == "Heretic" then
      send("sling 'sinful vigor' " .. profileName)
      send("sling 'sinful vigor' " .. profileName)
    end
  end
  if Nf.flags.invig then
    Nf.msg("Caught eventInvig for " .. profileName .. " but there's already an invig running")
    return
  end

  display("Caught event invig from " .. profileName)
  invig()
end
