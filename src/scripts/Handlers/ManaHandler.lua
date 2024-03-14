function ManaHandler()
    local manaPercent = 100 * (msdp.MANA / msdp.MANA_MAX)
    setGauge("manaBar", manaPercent, 100)

    if not hasFocus() then
        if manaPercent <= 40 then
            raiseGlobalEvent("mana")
        end
    end
end
