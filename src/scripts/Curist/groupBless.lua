function groupBless()
    if not Group then
        display("Group not set!")
        send("group")
        tempTimer(2, groupSanct())
        return
    end
    for _, profileName in pairs(Group) do
        send("sling 'bless' " .. profileName)
    end
end
