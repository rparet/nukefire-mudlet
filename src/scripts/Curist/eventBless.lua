function eventBless(_, profileName)
    local bless = "bless"
    if msdp.CLASS == "Heretic" then
        if tonumber(msdp.LEVEL) >= 22 then
            bless = "aura of dark blessing"
        else
            bless = "dark blessing"
        end
    end

    local lastCast = Nf.lastCast[bless]

    if not lastCast then
        Nf.lastCast[bless] = getEpoch()
    else
        local elapsed = getEpoch() - lastCast
        if elapsed < 60 then
            Nf.msg("eventBless - it's been less than a minute since last call, skipping")
            return
        else
            Nf.lastCast[bless] = getEpoch()
        end
    end
    if profileName then
        display("Caught event bless from " .. profileName)
        send("sling '" .. bless .. "' " .. profileName)
    else
        send("sling '" .. bless .. "' self")
    end
end
