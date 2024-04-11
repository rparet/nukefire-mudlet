map.prompt.mobs = {}
if Nf.inCombat then
    Nf.inCombat = false
end
if speedWalkDir and #speedWalkDir ~= 0 then
    map.resumeSpeedwalk(1)
    Nf.walking = true
elseif Nf.onMission() then
    raiseEvent("advanceMission")
end
