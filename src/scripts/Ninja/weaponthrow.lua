function weaponThrow()
    send("weaponthrow mob")
    send("get " .. getProfileName())
    send("conceal " .. getProfileName())
end
