function eventSetFlag(_, flag, value, profileName)
    --display("Caught eventSetFlag: " .. flag .. " " .. tostring(value) .. " " .. profileName)

    if not Nf.profiles[profileName].flags then
        Nf.profiles[profileName].flags = {}
    end

    Nf.profiles[profileName].flags[flag] = value

    local text = ""

    if Nf.profiles[profileName].flags["fighting"] then
        text = "⚔️"
    end
    if Nf.profiles[profileName].flags["casting"] then
        text = text .. " 🧙"
    end

    if Nf.profiles[profileName].flags["action"] then
        text = text .. " 🌪️"
    end

    if Nf.profiles[profileName].flags["heal"] then
        text = text .. " ❤️‍🩹"
    end


    Nf.profiles[profileName]["moveBar"]:setText("<b>" .. text .. "</b>")
end
