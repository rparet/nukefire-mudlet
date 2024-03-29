function groupSanct()
    if not Group then
        display("Group not set!")
        send("group")
        tempTimer(2, groupSanct())
        return
    end
    for _, profileName in pairs(Group) do
        send("sling 'sanct' " .. profileName)
    end
end
