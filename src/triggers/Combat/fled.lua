-- handle the cast where we're manually set in combat and a flee happens before msdp.OPPONENT_LEVEL event.
if Nf.inCombat then
    Nf.inCombat = false
    if next(map.prompt.mobs) ~= nil then
        table.remove(map.prompt.mobs, 1)
    end
    if (speedWalkDir and #speedWalkDir ~= 0) and not Nf.walking then
        Nf.msg("mob fled, resuming speedWalk")
        map.resumeSpeedwalk(1)
        Nf.walking = true
    elseif Nf.onMission() then
        raiseEvent("advanceMission")
    end
end
