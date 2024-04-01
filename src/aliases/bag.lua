if not matches[2] then
    Nf.msg("Bag status: one:" ..
        tostring(Nf.profile.bag.one) .. " two:" .. tostring(Nf.profile.bag.two) .. " three:" ..
        tostring(Nf.profile.bag.three))
end

if matches[2] and not matches[3] then
    Nf.msg("What bag do you want to set for position " .. matches[2] .. "?")
end

if matches[2] and matches[3] then
    Nf.profile.bag[matches[2]] = matches[3]
    Nf.msg("Bag " .. matches[2] .. " set to " .. matches[3])
end

Nf.profile.save()
