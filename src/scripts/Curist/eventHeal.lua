function eventHeal(_, healthPercent, profileName)
  display("Caught event heal " .. healthPercent .. "% from " .. profileName)
  heal(profileName)
end
