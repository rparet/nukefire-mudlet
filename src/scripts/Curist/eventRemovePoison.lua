function eventRemovePoison(_, profileName)
    -- no remove poison while fighting
    if Nf.inCombat then return end
    if profileName then
        display("Caught event remove poison from " .. profileName)
        send("sling 'remove poison' " .. profileName)
    else
        send("sling 'remove poison' self")
    end
end
