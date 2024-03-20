-- emergency recall
if msdp.CLASS == "Curist" and msdp.LEVEL >= 12 then
    send("sling 'world of recall'")
else
    send("get recall blast")
    send("recite recall")
end
