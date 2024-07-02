if map.prompt.exits then
    map.prompt.exits = map.prompt.exits .. ", " .. string.trim(matches[2])
else
    map.prompt.exits = string.trim(matches[2])
end
map.prompt.exitNames[string.lower(matches[2])] = matches[3]
setTriggerStayOpen("NfMultiLineExits", 1)
