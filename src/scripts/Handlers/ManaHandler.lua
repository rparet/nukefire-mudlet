function ManaHandler()
    if not msdp.MANA_MAX then
        return
    end
    local manaPercent = 100 * (msdp.MANA / msdp.MANA_MAX)
    manaBar:setValue(manaPercent, 100)

    if not hasFocus() then
        if manaPercent <= 40 then
            raiseGlobalEvent("mana")
        end
    end
end
