function eventBless(_, profileName)
    if profileName then
        display("Caught event bless from " .. profileName)
        send("sling 'bless' " .. profileName)
    else
        send("sling 'bless' self")
    end
end
