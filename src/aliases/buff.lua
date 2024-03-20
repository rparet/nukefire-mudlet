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
    send("sling 'blur'")
    send("sling 'shapeshift'")
end
