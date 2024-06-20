function eventBless(_, profileName)
    local bless = "bless"
    if msdp.CLASS == "Heretic" then
        if tonumber(msdp.LEVEL) >= 22 then
            bless = "aura of dark blessing"
        else
            bless = "dark blessing"
        end
    end
    if profileName then
        display("Caught event bless from " .. profileName)
        send("sling '" .. bless .. "' " .. profileName)
    else
        send("sling '" .. bless .. "' self")
    end
end
