-- execute a command with a slight delay. Used for assisting / garrote / etc.
function delayAttack(target, command, delay)
    tempTimer(delay, function() send(command .. " " .. target) end)
end
