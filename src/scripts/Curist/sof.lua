-- shield of flames.
function Nf.SoF()
    send("sling 'shield of flames'")
    send("autorescue")
    tempTimer(15, function() send("autorescue") end)
end
