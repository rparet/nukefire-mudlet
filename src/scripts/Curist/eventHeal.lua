function eventHeal(_, healthPercent, profileName)
  if not profileName then
    profileName = "self"
  end
  if Nf.flags.heal then
    Nf.msg("Caught eventHeal for " .. profileName .. " but there's already a heal running")
    return
  end
  if profileName then
    display("Caught event heal " .. healthPercent .. "% from " .. profileName)
    heal(profileName, tonumber(healthPercent))
  else
    heal("self", tonumber(healthPercent))
  end
end
