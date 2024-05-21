function eventManaReady(_, profileName)
    display(profileName .. " mana recovered. Ready to go.")
    Nf.waitForMana = false
end
