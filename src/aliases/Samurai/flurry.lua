local match = matches[2] or ""
if msdp.CLASS == "Samurai" or msdp.CLASS == "Knight" or Nf.profile.flurry then
    send("flurry " .. match)
else
    raiseGlobalEvent("samurai", "flurry", match)
end
