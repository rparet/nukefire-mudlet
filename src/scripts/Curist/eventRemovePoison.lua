function eventRemovePoison(_, profileName)
    if profileName then
        display("Caught event remove poison from " .. profileName)
        send("sling 'remove poison' " .. profileName)
    else
        send("sling 'remove poison' self")
    end
end
