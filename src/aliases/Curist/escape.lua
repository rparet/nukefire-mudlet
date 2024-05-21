if msdp.CLASS == "Curist" then
    send("sling 'aura of escape'")
else
    raiseGlobalEvent("escape")
    send("/") -- weird command to send so that the room gets updated after recall.
end
