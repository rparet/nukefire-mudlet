function eventLowMana(_, percent, profileName)
  display(profileName .. " low mana at: " .. percent .. "%!")
  Nf.waitForMana = true
end
