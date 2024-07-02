-- take an action immediately after assisting
if msdp.CLASS == "Samurai" or msdp.CLASS == "Assassin" or msdp.CLASS == "Ninja" or msdp.CLASS == "Knight" or msdp.CLASS == "Heretic" then
    combatSkill()
elseif msdp.CLASS == "Slinger" then
    combatMagic()
end
