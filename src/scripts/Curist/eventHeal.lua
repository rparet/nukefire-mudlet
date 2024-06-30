function eventHeal(_, healthPercent, profileName)
  if Nf.flags.heal then
    Nf.msg("Caught eventHeal but there's already a heal running")
  end
  if profileName then
    display("Caught event heal " .. healthPercent .. "% from " .. profileName)
    heal(profileName, tonumber(healthPercent))
  else
    heal("self", tonumber(healthPercent))
  end
end
