function eventSleep(_, profileName)
    if Nf.flags.lowMana then
        send("sleep")
    end
end
