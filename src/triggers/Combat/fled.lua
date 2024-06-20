-- handle the cast where we're manually set in combat and a flee happens before msdp.OPPONENT_LEVEL event.
if Nf.inCombat then
    Nf.inCombat = false
    if next(map.prompt.mobs) ~= nil then
        table.remove(map.prompt.mobs, 1)
    end

    if next(map.prompt.mobs) ~= nil and Nf.hunting then
        Nf.msg("Calling clearRoom from fled")
        Nf.clearRoom()
        return
    end
    if (speedWalkDir and #speedWalkDir ~= 0) and Nf.hunting then
        Nf.msg("mob fled, resuming speedWalk")
        map.resumeSpeedwalk(3)
        Nf.walking = true
    elseif Nf.onMission() then
        Nf.msg("Raising advanceMission from fled.")
        tempTimer(2, function() raiseEvent("advanceMission") end)
    end
end
