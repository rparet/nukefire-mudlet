raiseEvent("onMoveFail")
if Nf.walking then
    Nf.msg("Pausing speedwalk due to move failure")
    map.pauseSpeedwalk()
    Nf.walking = false

    -- assume that we may have moved off the path, recalculate.
    if speedWalkPath[#speedWalkPath] then
        getPath(map.currentRoom, speedWalkPath[#speedWalkPath])
    end

    tempTimer(2, function() Nf.tryResumeSpeedwalk() end)
end
