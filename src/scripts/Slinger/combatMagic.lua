-- choose a level appropriate combat spell to sling. uses MSDP

function combatMagic()
    local level = tonumber(msdp.LEVEL)
    local opponentLevel = tonumber(msdp.OPPONENT_LEVEL)
    local spell = ""

    if not Nf.inCombat then
        return
    end
    -- don't bother casting. save your mana for bigger mobs
    if opponentLevel < 20 then
        return
    end
    if level <= 2 then
        spell = "magic missile"
    elseif level <= 4 then
        spell = "chill touch"
    elseif level <= 6 then
        spell = "burning hands"
    elseif level <= 8 then
        spell = "shocking grasp"
    elseif level <= 10 then
        spell = "lightning bolt"
    elseif level <= 14 then
        spell = "color spray"
    elseif level <= 17 then
        spell = "fireball"
    elseif level <= 21 then
        spell = "calliope"
    elseif level <= 39 then
        spell = "calliope"
    elseif level >= 40 then
        spell = "calliope"
        -- handle phoenix nova separately
    end

    send("sling '" .. spell .. "'")
    if Nf.timers.combatMagic then killTimer(Nf.timers.combatMagic) end
    Nf.timers.combatMagic = tempTimer(2, combatMagic)
end
