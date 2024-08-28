function Nf.attack(target, type)
    send("kill " .. target)
    Nf.target.name = target
    Nf.target.type = type
    raiseGlobalEvent("eventAttack", target, type)
end
