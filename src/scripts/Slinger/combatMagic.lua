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

    local slinger_spell_table = {
        { level = 40, spell = "disintegrate" },
        { level = 22, spell = "disruption" },
        { level = 18, spell = "calliope" },
        { level = 15, spell = "fireball" },
        { level = 13, spell = "energy drain" },
        { level = 11, spell = "color spray" },
        { level = 9,  spell = "lightning bolt" },
        { level = 7,  spell = "shocking grasp" },
        { level = 5,  spell = "burning hands" },
        { level = 3,  spell = "chill touch" },
        { level = 1,  spell = "magic missile" }
    }
    table.sort(slinger_spell_table, function(a, b) return a.level > b.level end)

    local voidstriker_spell_table = {
        { level = 40, spell = "annihilate" },
        { level = 35, spell = "ravaged terrain" },
        { level = 15, spell = "grave grasp" },
        { level = 2,  spell = "bonespur" }
    }
    local function get_highest_spell(caster_level, spell_table)
        for _, entry in ipairs(spell_table) do
            if caster_level >= entry.level then
                return entry.spell
            end
        end
        return "" -- Return nil if no spell is available
    end

    if msdp.CLASS == "Slinger" then
        spell = get_highest_spell(level, slinger_spell_table)
        if level >= 40 and Nf.target.type == "machine" then
            spell = "disruption"
        end
    elseif msdp.CLASS == "Voidstriker" then
        spell = get_highest_spell(level, voidstriker_spell_table)
    end

    send("sling '" .. spell .. "'")
    Nf.lastCast[spell] = getEpoch()

    if spell == "calliope" then
        Nf.setFlag("casting", true)
        Nf.triggers.casting = tempRegexTrigger("^Your calliope",
            function()
                local elapsed = getEpoch() - Nf.lastCast["calliope"]
                echo("\nResolved calliope trigger. Trigger took " .. elapsed .. "s\n")
                Nf.setFlag("casting", false)
            end, 1)
    end

    if spell == "disintegrate" then
        Nf.setFlag("casting", true)
        Nf.triggers.casting = tempRegexTrigger("^You disintegrate",
            function()
                local elapsed = getEpoch() - Nf.lastCast["disintegrate"]
                echo("\nResolved disintegrate trigger. Trigger took " .. elapsed .. "s\n")
                Nf.setFlag("casting", false)
            end, 1)
    end

    if spell == "disruption" then
        Nf.setFlag("casting", true)
        Nf.triggers.casting = tempRegexTrigger("^You sling a ray of disruption|^Your ray of disruption",
            function()
                local elapsed = getEpoch() - Nf.lastCast["disruption"]
                echo("\nResolved disruption trigger. Trigger took " .. elapsed .. "s\n")
                Nf.setFlag("casting", false)
            end, 1)
    end

    if Nf.timers.combatMagic then killTimer(Nf.timers.combatMagic) end
    Nf.timers.combatMagic = tempTimer(2, combatMagic)
end
