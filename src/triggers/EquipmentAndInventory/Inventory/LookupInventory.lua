local obj = string.trim(matches.obj)
selectCaptureGroup("obj")
setUnderline(true)
setLink([[fetchItem("]] .. obj .. [[")]], obj)
setUnderline(false)
Nf.setInventory(obj)
if matches.inscribe and matches.inscribe ~= "" then
    Nf.setInventoryInscribe(matches.inscribe)
end
setTriggerStayOpen("Inventory", 1)
