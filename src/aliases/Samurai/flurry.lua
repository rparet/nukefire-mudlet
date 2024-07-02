local match = matches[2] or ""
if msdp.CLASS == "Samurai" or msdp.CLASS == "Knight" then
    send("flurry " .. match)
else
    raiseGlobalEvent("samurai", "flurry", match)
end
