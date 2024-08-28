if not msdp.CLASS then
    return
end

if msdp.CLASS == "Mutant" then
    send("grow arms")
    send("grow body")
    send("grow claws")
    send("grow brain")
    send("grow claws")
    send("grow eyes")
    send("grow fingers")
    send("grow muscle")
    send("grow shell")
elseif msdp.CLASS == "Samurai" then
    send("sling 'battle rites'")
elseif msdp.CLASS == "Curist" then
    send("sling 'holyfist'")
elseif msdp.CLASS == "Slinger" then
    send("sling 'invis'")
    send("sling 'shapeshift'")
    send("sling 'blur")
elseif msdp.CLASS == "Assassin" then
    send("shadowform")
elseif msdp.CLASS == "Ninja" then
    send("ghost")
    if tonumber(msdp.LEVEL) >= 20 then
        send("utsusemi")
    end
elseif msdp.CLASS == "Knight" then
    if tonumber(msdp.LEVEL) >= 5 then
        send("sling 'armor'")
        send("sling 'bless'")
    end

    if tonumber(msdp.LEVEL) >= 19 then
        send("sling 'honor'")
    end

    if tonumber(msdp.LEVEL) >= 25 then
        send("sling 'barrier'")
        send("sling 'war banner'")
    end

    if tonumber(msdp.LEVEL) >= 40 then
        send("oath")
    end
elseif msdp.CLASS == "Heretic" then
    send("sling 'fortify'")
    if tonumber(msdp.LEVEL) >= 11 then
        send("sling 'unholyfist'")
    end
    if tonumber(msdp.LEVEL) >= 25 then
        send("darkpact")
        send("covenant")
    end
elseif msdp.CLASS == "Kaiju" then
    send("grow organs")
    send("grow swarm")
    send("grow limbs")
    send("grow plates")
    send("grow tentacles")
    send("grow spines")
    send("grow carapace")
    send("grow organs")
    send("grow plates")
    send("grow organs")
    send("grow plates")
    send("grow organs")
    send("grow organs")
    send("grow plates")
    send("grow plates")
end
