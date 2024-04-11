if not Nf.profile.remort then
    Nf.msg("Remort code not set!")
    return
end

send("buy " .. Nf.profile.remort)
