-- reinitialize MDSP after soft reload
initMSDP(_, "MSDP")
-- if speedwalking when this happens, stop
if speedWalkDir and #speedWalkDir ~= 0 then
    map.stopSpeedwalk()
end

if Nf.inCombat then
    Nf.inCombat = false
end

if Nf.onMission() then
    Nf.startMission("stop")
end

if Nf.flags.utsu then
    setUtsu(0)
end
