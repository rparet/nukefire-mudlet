function eventUtsu(_, utsu, profileName)
    if Nf.profiles[profileName] then
        Nf.profiles[profileName]["hpBar"]:setText("<b>" .. profileName .. " " .. string.rep("+", utsu) .. "</b>")
    end
end
