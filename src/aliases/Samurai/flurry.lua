local match = matches[2] or ""
if msdp.CLASS == "Samurai" then
    send("flurry " .. match)
else
    raiseGlobalEvent("samurai", "flurry", match)
end
