map.prompt.mobs = {}
if Nf.inCombat then
    Nf.inCombat = false
    Nf.setFlag("fighting", false)
end
if (speedWalkDir and #speedWalkDir ~= 0) and Nf.hunting then
    map.resumeSpeedwalk(1)
    Nf.walking = true
elseif Nf.onMission() then
    Nf.msg("Raising advanceMission from cantKill")
    raiseEvent("advanceMission")
end
