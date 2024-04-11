function giveAll(event, target, profileName)
    display("Caught event giveAll with target " .. tostring(target))

    if target ~= "" then
        send("give" .. " " .. target .. " " .. profileName)
    else
        send("give all " .. tostring(profileName))
    end
end
