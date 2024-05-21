function eventBlur(_, profileName)
    if profileName then
        display("Caught event blur from " .. profileName)
        send("sling 'blur' " .. profileName)
    else
        send("sling 'blur' self")
    end
end
