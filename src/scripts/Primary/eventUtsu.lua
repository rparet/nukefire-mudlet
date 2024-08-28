function eventUtsu(_, utsu, profileName)
    Nf.profiles[profileName]["hpBar"]:setText("<b>" .. profileName .. " " .. string.rep("+", utsu) .. "</b>")
end
