function OpponentHandler(event)
    if event == "msdp.OPPONENT_LEVEL" then
        local level = tonumber(msdp.OPPONENT_LEVEL)
        if level > 0 then
            if not Nf.inCombat then
                Nf.inCombat = true
            end
        else
            if Nf.inCombat then
                Nf.inCombat = false
            end
        end
    end
end
