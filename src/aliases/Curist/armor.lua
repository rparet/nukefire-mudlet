if msdp.CLASS == "Curist" or msdp.CLASS == "Heretic" then
    raiseEvent("armor")
elseif msdp.CLASS == "Knight" then
    send("sling 'armor'")
else
    raiseGlobalEvent("armor")
end
