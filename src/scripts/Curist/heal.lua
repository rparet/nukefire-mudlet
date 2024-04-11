-- level appropriate heal. needs MSDP level attribute

function heal(profileName, healthPercent)
  local level = tonumber(msdp.LEVEL)
  local spell = "rejuv" -- default spell
  if level <= 8 then
    spell = "cure light"
  elseif level <= 11 then
    spell = "cure critic"
  elseif level <= 24 then
    spell = "heal"
  else --rejuv or restore if we're in real trouble
    if level == 40 and healthPercent <= 40 then
      spell = "restoration"
    else
      spell = "rejuvinate"
    end
  end

  send("sling '" .. spell .. "' " .. profileName)

  -- sling non restore again if we're in trouble
  if level < 40 and healthPercent <= 40 then
    send("sling '" .. spell .. "' " .. profileName)
  end
end
