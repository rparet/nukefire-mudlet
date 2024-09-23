function OpponentHandler(event)
    if event == "msdp.OPPONENT_LEVEL" then
        local level = tonumber(msdp.OPPONENT_LEVEL)
        if level > 0 then
            Nf.inCombat = true
            Nf.msg("Opponent level: " .. level)
            raiseEvent("enteredCombat")
        elseif Nf.inCombat then
            raiseEvent("exitedCombat")
            -- if Nf.inCombat then
            --     Nf.inCombat = false
            --     if map.prompt.mobs == nil then return end -- for inital event on login.

            --     -- died or fled
            --     if next(map.prompt.mobs) ~= nil then
            --         table.remove(map.prompt.mobs, 1)
            --     end
            --     if next(map.prompt.mobs) ~= nil and Nf.hunting then
            --         Nf.msg("Calling clearRoom from OpponentHandler")
            --         Nf.clearRoom()
            --         return
            --     end
            --     if (speedWalkDir and #speedWalkDir ~= 0) and Nf.hunting then
            --         Nf.msg("Resuming speedwalk from OpponentHandler")
            --         map.resumeSpeedwalk(1)
            --         Nf.walking = true
            --     elseif Nf.onMission() then
            --         Nf.msg("Raising advanceMission from OpponentHandler")
            --         raiseEvent("advanceMission")
            --     end
            -- end
        end
    end
    if event == "msdp.OPPONENT_NAME" then
        if msdp.OPPONENT_NAME ~= "" then
            Nf.msg("Opponent name: " .. msdp.OPPONENT_NAME)
        end
    end
end
