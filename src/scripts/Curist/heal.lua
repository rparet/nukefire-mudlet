-- level appropriate heal. needs MSDP level attribute

function heal(profileName, healthPercent)
  -- just get Knight out of the way
  if msdp.CLASS == "Knight" then
    send("sling 'heal' " .. profileName)
    return
  end

  local level = tonumber(msdp.LEVEL)
  local spell = "rejuv" -- default spell

  if msdp.CLASS == "Curist" then
    if level <= 8 then
      spell = "cure light"
    elseif level <= 11 then
      spell = "cure critic"
    elseif level <= 24 then
      spell = "heal"
    else --rejuv or restore if we're in real trouble
      if level >= 40 and healthPercent <= 70 then
        spell = "restoration"
      else
        spell = "rejuvinate"
      end
    end
  elseif msdp.CLASS == "Heretic" then
    if level < 14 then
      return
    elseif level < 25 then
      spell = "heal"
    else
      spell = "rejuvinate"
    end
  end

  if profileName == "self" and level >= 26 and healthPercent <= 60 then
    spell = "augury"
  end

  send("sling '" .. spell .. "' " .. profileName)

  -- sling non restore again if we're in trouble
  if level < 40 and healthPercent <= 40 then
    send("sling '" .. spell .. "' " .. profileName)
  end
end
