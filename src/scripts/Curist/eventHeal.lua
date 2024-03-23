function eventHeal(_, healthPercent, profileName)
  if profileName then
    display("Caught event heal " .. healthPercent .. "% from " .. profileName)
    heal(profileName)
  else
    heal("self")
  end
end
