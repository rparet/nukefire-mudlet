function groupSanct()
    for _, profileName in pairs(Group) do
        send("sling 'sanct' " .. profileName)
    end
end
