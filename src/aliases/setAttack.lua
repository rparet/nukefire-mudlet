if not matches[2] then
    Nf.msg("Current attack: " .. Nf.profile.attack)
    return
else
    Nf.profile.attack = matches[2]
    Nf.msg("Attack set to: " .. matches[2])
    Nf.save()
end
