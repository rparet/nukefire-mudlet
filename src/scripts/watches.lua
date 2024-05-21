-- Stopwatches
Nf.watches = Nf.watches or {}
Nf.watch = Nf.watch or {}

function Nf.watch.start(stopwatch)
    if not Nf.watches[stopwatch] then
        Nf.watches[stopwatch] = createStopWatch()
    end
    Nf.watches.startExp = tonumber(msdp.EXPERIENCE)
end

function Nf.watch.stop(stopwatch)
    if not stopwatch then return end

    if getStopWatchTime(stopwatch) > 0 then
        local elapsedTime = stopStopWatch(stopwatch)
        local xpGained = tonumber(msdp.EXPERIENCE) - Nf.watches.startExp
        local xpPerSecond = xpGained / elapsedTime
        Nf.msg("Stopwatch ran for " .. tostring(elapsedTime) .. " seconds.")
        Nf.msg("XP gained: " .. tostring(xpGained) .. " / " .. xpPerSecond .. " per second.")
        resetStopWatch(stopwatch)
        Nf.watches.startExp = 0
    end
end
