function Nf.reWear()
    for k, wearCmd in pairs(Nf.profile.customWear) do
        send(wearCmd)
    end
    send("wear all." .. getProfileName())
    send("wear all")
end

function Nf.getCorpse()
    send("run eswds")
    send("retrieve")
    disableTrigger("sortItems")
    send("get all from corpse")
    send("get all from fupa")
    if msdp.CLASS == "Ninja" then
        send("conceal " .. getProfileName())
        send("conceal " .. getProfileName())
    end
    Nf.reWear()
end
