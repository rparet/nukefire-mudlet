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
end
