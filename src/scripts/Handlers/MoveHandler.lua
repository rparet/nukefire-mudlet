function MoveHandler()
    if not msdp.MOVEMENT_MAX then
        return
    end
    local movePercent = 100 * (msdp.MOVEMENT / msdp.MOVEMENT_MAX)
    moveBar:setValue(movePercent, 100)
    raiseGlobalEvent("move", movePercent)

    if movePercent <= 50 then
        raiseGlobalEvent("lowMove")
        if msdp.CLASS == "Curist" then
            raiseEvent("invig")
        else
            raiseGlobalEvent("invig")
        end
    end
end
