function eventAttack(_, target, targetType)
    local attack = Nf.profile.attack
    if type(attack) == "string" then
        send(attack .. " " .. target)
    elseif type(attack) == "table" then
        if attack.command and attack.delay then
            delayAttack(target, attack.command, attack.delay)
        else
            for k, cmd in pairs(attack) do
                send(cmd .. " " .. target)
            end
        end
    end

    Nf.target.name = target
    Nf.target.type = targetType
end
