-- reinitialize MDSP after soft reload
initMSDP(_, "MSDP")
-- if speedwalking when this happens, stop
if speedWalkDir and #speedWalkDir ~= 0 then
    map.stopSpeedwalk()
end
