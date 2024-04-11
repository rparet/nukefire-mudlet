function OpponentHandler(event)
    if event == "msdp.OPPONENT_LEVEL" then
        local level = tonumber(msdp.OPPONENT_LEVEL)
        if level > 0 then
            Nf.inCombat = true
        else
            if Nf.inCombat then
                Nf.inCombat = false
            end

            -- died or fled
            if next(map.prompt.mobs) ~= nil then
                table.remove(map.prompt.mobs, 1)
            end
            if (speedWalkDir and #speedWalkDir ~= 0) and not Nf.walking then
                Nf.msg("Resuming speedwalk from OpponentHandler")
                map.resumeSpeedwalk(1)
                Nf.walking = true
            elseif Nf.onMission() then
                raiseEvent("advanceMission")
            end
        end
    end
end
