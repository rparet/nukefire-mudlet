function eventMissing(_, missing, profileName)
    if not profileName then
        profileName = "You"
    end
    display(profileName .. ":" .. missing .. " pieces equiped.")
end
