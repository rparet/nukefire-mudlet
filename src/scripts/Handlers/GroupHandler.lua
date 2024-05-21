function GroupHandler(event, profileName)
    if event == "unGroup" then
        send("follow self")
        send("group leave")
    elseif event == "groupUp" then
        if profileName then
            send("follow " .. profileName)
        end
    end
end
