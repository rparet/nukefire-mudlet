-- take an action immediately after assisting
if not Nf.profile.autos then return end
if msdp.CLASS == "Samurai" or msdp.CLASS == "Assassin" or msdp.CLASS == "Ninja" or msdp.CLASS == "Knight" or msdp.CLASS == "Heretic" then
    combatSkill()
elseif msdp.CLASS == "Slinger" then
    combatMagic()
elseif msdp.CLASS == "Voidstriker" then
    Nf.combatLoop()
end
