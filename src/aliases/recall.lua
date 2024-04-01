-- emergency recall, assumes you're already remorted.
if msdp.CLASS == "Curist" and msdp.LEVEL >= 12 then
    send("sling 'world of recall'")
else
    local bag = Nf.profile.bag.one or "bag"
    send("get recall " .. bag)
    send("recite recall")
end
