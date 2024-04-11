-- toggle debug
if Nf.debugMode == true then
    Nf.debugMode = false
    Nf.debug = function(message) end
    return
else
    Nf.debugMode = true
    Nf.debug = function(message) cecho("[<orange_red>NF-debug<reset>] " .. message .. "\n") end
end
