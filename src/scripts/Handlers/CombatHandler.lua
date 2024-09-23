function CombatHandler(event)
    if event == "enteredCombat" then
        Nf.msg("Entered combat")
        Nf.setFlag("fighting", true)
        if msdp.CLASS == "Samurai" or msdp.CLASS == "Assassin" or msdp.CLASS == "Ninja" then
            combatSkill()
        elseif msdp.CLASS == "Slinger" then
            combatMagic()
        end
    elseif event == "exitedCombat" then
        Nf.msg("Exited combat")
        Nf.setFlag("fighting", false)
        Nf.setFlag("casting", false)
        Nf.setFlag("action", false)
        --Nf.inCombat = false making this false here breaks missions somehow
    end
end
