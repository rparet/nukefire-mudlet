function MoveHandler()
    if not (msdp.MOVEMENT or msdp.MOVEMENT_MAX) then
        return
    end
    local movePercent = 100 * (msdp.MOVEMENT / msdp.MOVEMENT_MAX)
    moveBar:setValue(movePercent, 100)

    if movePercent <= 50 then
        raiseGlobalEvent("move")
        raiseGlobalEvent("invig")
    end
end
