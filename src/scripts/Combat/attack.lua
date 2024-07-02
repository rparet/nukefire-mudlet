function Nf.attack(target)
    send("kill " .. target)
    raiseGlobalEvent("eventAttack", target)
end
