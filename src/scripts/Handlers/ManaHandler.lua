function ManaHandler()
 manaPercent = 100 * (msdp.MANA / msdp.MANA_MAX)
 setGauge("manaBar", manaPercent, 100)
end