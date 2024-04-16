function ManaHandler()
    if not msdp.MANA_MAX then
        return
    end
    local manaPercent = 100 * (msdp.MANA / msdp.MANA_MAX)
    manaBar:setValue(manaPercent, 100)

    if not hasFocus() then
        if manaPercent <= 40 then
            raiseGlobalEvent("mana")
            Nf.flags.lowMana = true
        end

        if manaPercent >= 90 and Nf.flags.lowMana then
            Nf.flags.lowMana = false
            raiseGlobalEvent("manaReady")
        end
    end
end
