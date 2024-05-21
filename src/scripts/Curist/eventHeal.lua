function eventHeal(_, healthPercent, profileName)
  if profileName then
    display("Caught event heal " .. healthPercent .. "% from " .. profileName)
    heal(profileName, tonumber(healthPercent))
  else
    heal("self", tonumber(healthPercent))
  end
end
