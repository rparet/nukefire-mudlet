function setUtsu(utsu)
    if Nf.flags.utsuBlocked then
        if Nf.timers.reUtsu and isActive(Nf.timers.reUtsu, "timer") then
            return
        else
            Nf.timers.reUtsu = tempTimer(60, function() Nf.flags.utsuBlocked = false end)
            return
        end
    end
    Nf.flags.utsu = utsu
    raiseGlobalEvent("utsu", utsu)
    if utsu <= 2 then
        if Nf.triggers.utsu and isActive(Nf.triggers.utsu, "trigger") then -- already done
            return
        end
        Nf.triggers.utsu =
            tempRegexTrigger(
                "^You can't summon decoys YET|^Your shihei bursts into flames between your first two fingers, summoning illusory decoys!",
                function()
                    if matches[1] == "You can't summon decoys YET" then
                        Nf.flags.utsuBlocked = true
                    else
                        Nf.flags.utsuBlocked = false
                    end
                end, 1)
        send("utsu")
    end
end
