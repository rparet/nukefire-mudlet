function eventSanct(_, profileName)
    if profileName then
        display("Caught event sanct from " .. profileName)
        send("sling 'sanct' " .. profileName)
    else
        send("sling 'sanct' self")
    end
end
