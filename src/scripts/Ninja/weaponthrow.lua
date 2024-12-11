function weaponThrow()
    send("shurikenthrow mob")
    send("get " .. getProfileName())
    send("conceal " .. getProfileName())
end
