function groupBless()
    for _, profileName in pairs(Group) do
        send("sling 'bless' " .. profileName)
    end
end
