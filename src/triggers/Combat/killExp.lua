-- handle the case where you get kill xp but Nf.inCombat wasn't cleared by the msdp.OPPONENT_LEVEL event.
if Nf.inCombat then
    Nf.inCombat = false
    if next(map.prompt.mobs) ~= nil then
        table.remove(map.prompt.mobs, 1)
    end
    if (speedWalkDir and #speedWalkDir ~= 0) and not Nf.walking then
        Nf.msg("got kill xp, resuming speedwalk.")
        map.resumeSpeedwalk(1)
        Nf.walking = true
    elseif Nf.onMission() then
        raiseEvent("advanceMission")
    end
end
