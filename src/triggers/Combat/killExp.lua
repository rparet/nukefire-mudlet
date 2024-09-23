-- handle the case where you get kill xp but Nf.inCombat wasn't cleared by the msdp.OPPONENT_LEVEL event.
if Nf.inCombat then
    Nf.inCombat = false
    Nf.setFlag("fighting", false)
    if next(map.prompt.mobs) ~= nil then
        table.remove(map.prompt.mobs, 1)
    end

    if next(map.prompt.mobs) ~= nil and Nf.hunting then
        Nf.msg("Calling clearRoom from killExp")
        Nf.clearRoom()
        return
    end
    if (speedWalkDir and #speedWalkDir ~= 0) and Nf.hunting then
        Nf.msg("got kill xp, resuming speedwalk.")
        map.resumeSpeedwalk(1)
        Nf.walking = true
    elseif Nf.onMission() then
        Nf.msg("Raising advanceMission from killExp.")
        raiseEvent("advanceMission")
    end
end
