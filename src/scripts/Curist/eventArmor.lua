function eventArmor(_, profileName)
    if msdp.CLASS == "Curist" then
        if tonumber(msdp.LEVEL) >= 9 then
            send("sling 'aura of protection'")
        else
            send("sling 'armor' " .. profileName)
        end
    elseif msdp.CLASS == "Knight" then
        send("sling 'armor' " .. profileName)
    elseif msdp.CLASS == "Heretic" then
        if tonumber(msdp.LEVEL) >= 9 then
            send("sling 'aura of fortificaton'")
        else
            send("sling 'fortify' " .. profileName)
        end
    end
end
