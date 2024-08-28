if getCurrentLine() == "Obvious exits:" then
    setTriggerStayOpen("NfRoomName", 0)
    return
end
if selectSection(0, 1) then
    if isAnsiFgColor(0) then
        if map.prompt.description then
            map.prompt.description = map.prompt.description .. " " .. multimatches[1][1]
        else
            map.prompt.description = multimatches[1][1]
        end
        setTriggerStayOpen("NfRoomName", 1)
    end
end
