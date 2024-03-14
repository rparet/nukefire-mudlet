if not directions[matches[2]] then
    display("Couldn't find any directions for " .. matches[2])
    return
end

send(matches[2])
