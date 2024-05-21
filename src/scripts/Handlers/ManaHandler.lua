function ManaHandler()
    if not msdp.MANA_MAX then
        return
    end
    local manaPercent = 100 * (msdp.MANA / msdp.MANA_MAX)
    manaBar:setValue(manaPercent, 100)
    raiseGlobalEvent("mana", manaPercent)

    if not hasFocus() then
        if manaPercent <= 25 then
            raiseGlobalEvent("lowMana", manaPercent)
            Nf.flags.lowMana = true
        end

        if manaPercent >= 90 and Nf.flags.lowMana then
            Nf.flags.lowMana = false
            raiseGlobalEvent("manaReady")
            send("wake")
            send("stand")
        end
    end
end
