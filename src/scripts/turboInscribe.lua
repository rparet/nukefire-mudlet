-- inscribe everything you're wearing
function turboInsribe(profileName)
    for key, value in pairs(eqTable) do
        _, _, keyword = string.find(key, "(%w+)$")
        if keyword then
            send("remove " .. keyword)
            send("buy inscribe " .. keyword .. " " .. profileName)
        end
    end
end
