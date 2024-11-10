function MoveHandler()
    if not msdp.MOVEMENT_MAX then
        return
    end
    local movePercent = 100 * (msdp.MOVEMENT / msdp.MOVEMENT_MAX)
    moveBar:setValue(movePercent, 100)
    raiseGlobalEvent("move", movePercent)

    if movePercent <= 50 then
        raiseGlobalEvent("lowMove")
        Nf.flags.lowMove = true
        if msdp.CLASS == "Curist" or msdp.CLASS == "Heretic" then
            raiseEvent("invig")
        else
            raiseGlobalEvent("invig")
        end
    end
    if movePercent >= 90 and Nf.flags.lowMove then
        Nf.flags.lowMove = false
    end
end
