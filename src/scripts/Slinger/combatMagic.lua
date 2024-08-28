-- choose a level appropriate combat spell to sling. uses MSDP

function combatMagic()
    local level = tonumber(msdp.LEVEL)
    local opponentLevel = tonumber(msdp.OPPONENT_LEVEL)
    local spell = ""

    if not Nf.inCombat then
        return
    end

    if Nf.flags.casting then
        Nf.msg("got to CombatMagic() but I'm already casting, so returning.")
        if Nf.timers.combatMagic then killTimer(Nf.timers.combatMagic) end
        Nf.timers.combatMagic = tempTimer(2, combatMagic)
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
        spell = "disruption"
    elseif level >= 40 then
        spell = "disintegrate"
        -- handle phoenix nova separately
    end

    if level >= 40 and Nf.target.type == "machine" then
        spell = "disruption"
    end

    send("sling '" .. spell .. "'")
    Nf.lastCast[spell] = getEpoch()

    if spell == "calliope" then
        Nf.flags.casting = true
        Nf.triggers.casting = tempRegexTrigger("^Your calliope",
            function()
                local elapsed = getEpoch() - Nf.lastCast["calliope"]
                echo("\nResolved calliope trigger. Trigger took " .. elapsed .. "s\n")
                Nf.flags.casting = false
            end, 1)
    end

    if spell == "disintegrate" then
        Nf.flags.casting = true
        Nf.triggers.casting = tempRegexTrigger("^You disintegrate",
            function()
                local elapsed = getEpoch() - Nf.lastCast["disintegrate"]
                echo("\nResolved disintegrate trigger. Trigger took " .. elapsed .. "s\n")
                Nf.flags.casting = false
            end, 1)
    end

    if spell == "disruption" then
        Nf.flags.casting = true
        Nf.triggers.casting = tempRegexTrigger("^You sling a ray of disruption|^Your ray of disruption",
            function()
                local elapsed = getEpoch() - Nf.lastCast["disruption"]
                echo("\nResolved disruption trigger. Trigger took" .. elapsed .. "s\n")
                Nf.flags.casting = false
            end, 1)
    end

    if Nf.timers.combatMagic then killTimer(Nf.timers.combatMagic) end
    Nf.timers.combatMagic = tempTimer(2, combatMagic)
end
