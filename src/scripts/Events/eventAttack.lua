function eventAttack(_, target, targetType)
    if type(Nf.profile.attack) == "string" then
        send(Nf.profile.attack .. " " .. target)
    elseif type(Nf.profile.attack) == "function" then
        Nf.profile.attack(target)
    end

    Nf.target.name = target
    Nf.target.type = targetType
end
