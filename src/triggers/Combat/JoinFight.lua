-- take an action immediately after assisting
if msdp.CLASS == "Samurai" then
    combatSkill()
elseif msdp.CLASS == "Slinger" then
    combatMagic()
end
